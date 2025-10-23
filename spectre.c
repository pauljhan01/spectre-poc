#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "lib/nospec.h"
#include <string.h>
// #include "../inline_asm.h"
// #include "../color.h"
// #include <assert.h>
// #include <ctype.h>
// #include <inttypes.h>
// #include <stdbool.h>
// #include <sys/mman.h>
// #include <x86intrin.h>

uint8_t* array_idx;
volatile uint32_t arr_size = 8;

uint32_t victim_function(uint32_t *arr, uint32_t index, uint32_t stride);
void attacker_function(void);
void init(void);

void init(){
    array_idx = (uint8_t *)malloc(arr_size);
    for(int i = 0; i < arr_size; i++){
        array_idx[i] = i;
    }
}

int main (void){
    //victim_function(index);
    //
    init();
    attacker_function();
}
void attacker_function(){
	for(int i = 0; i < 1000; i++){
        
    }
}

uint32_t victim_function(uint32_t * arr, uint32_t index, uint32_t stride){
    /*
        This Spectre PoC relies on realloc failing due to not enough memory for reallocation
        When this occurs, arr_size would double in size due to being speculatively executed
        Yet, access to the public array would occur during the speculation window, resulting in an array out of bounds access.
        This leaves this code vulnerable to a Spectre attack that utilizes a side channel attack to extract the private index of the data array
    */

    if(index > arr_size){
        array_idx = realloc(array_idx, arr_size*2);
        arr_size*=2;
    }    
    
    uint32_t new_idx = array_index_nospec(index, arr_size);
    uint32_t secret_idx = array_idx[new_idx];

    return arr[secret_idx * stride];
}

