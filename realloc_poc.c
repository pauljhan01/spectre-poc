#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
//#include "nospec.h"
#include <string.h>
#include <sys/resource.h>

//make: gcc -o realloc_poc realloc_poc.c -O2


size_t array_size = 8;

void set_heap_limit(size_t limit_bytes) {
    struct rlimit rl;
    rl.rlim_cur = limit_bytes;
    rl.rlim_max = limit_bytes;
    
    if (setrlimit(RLIMIT_AS, &rl) != 0) {
        perror("setrlimit failed");
        exit(1);
    }
}

uint32_t array_idx_nospec(uint32_t index, size_t size) {
    if (index >= size) return 0;
    return index;
}


#define PAGE_SIZE 4096
#define NUM_PAGES 256
uint32_t* page_init() {
    uint32_t *page = malloc(NUM_PAGES * PAGE_SIZE);
    
    if (page == NULL) {
        perror("Page allocation failed");
        return NULL;  
    }
    
    memset(page, 0, NUM_PAGES * PAGE_SIZE);
    
    for (int i = 0; i < NUM_PAGES; i++) {
        size_t offset = (i * PAGE_SIZE) / sizeof(uint32_t);
        page[offset] = i;
        
        //flush_cache_line(&page[offset]);
    }
    
    return page;
}

uint32_t* array_init(){
    uint32_t* array = malloc(array_size * sizeof(uint32_t));
    if (array == NULL) {
        perror("Initial malloc failed");
        return NULL;
    }
    for(int i = 0; i < 8; i++){
        array[i] = i;
    }
    return array;
} 

uint32_t victim_function(uint32_t ** array, uint32_t * page, uint32_t index, uint32_t stride){
    if(array_size < index){
        uint32_t * new_array = realloc(* array, array_size * 2 * sizeof(uint32_t));
        array_size *= 2;
        if (new_array == NULL) {
            printf("realloc failed! arr_size would be %zu but allocation failed\n", 
                array_size * 2);
            
        } else {
            *array = new_array;
            printf("realloc succeed! arr_size is %zux\n", 
                array_size);
            memset(*array, 0, array_size * sizeof(uint32_t));
        }
    }

    uint32_t new_idx = array_idx_nospec(index, array_size);
    uint32_t secret = (*array)[new_idx];

    return page[secret * stride];
}


#define TRAINING_EPOCH 16
int attacker_function(){
    uint32_t* array = array_init();
    uint32_t* page = page_init();
    size_t stride = PAGE_SIZE;
    //todo calling victim function in a loop until it failed
    
    for (uint32_t i = 12; i < 1600000; i *= 2) {
        printf("Trying with index: %u, current arr_size: %zu\n", i, array_size);
        victim_function(&array, page, i, 4096);
        
        if (array_size * sizeof(uint32_t) > 2 * 1024 * 1024) {
            printf("Approaching memory limit\n");
        }
    }
    
    free(array);
    free(page);
    return 0;
}

int main (void){
    set_heap_limit(10 * 1024 * 1024);
    attacker_function();
    return 0;
}
