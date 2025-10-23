#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "nospec.h"
#include <string.h>
// #include "../inline_asm.h"
// #include "../color.h"
// #include <assert.h>
// #include <ctype.h>
// #include <inttypes.h>
// #include <stdbool.h>
// #include <sys/mman.h>
// #include <x86intrin.h>

void victim_function(uint32_t index);

int main (void){
    victim_function(index);
}

uint8_t array_idx[8] = {0, 1, 2, 3, 4, 5, 6, 7};
volatile uint32_t arr_size = 8;
uint32_t victim_function(uint32_t * arr, uint32_t index, uint32_t stride){
    /*
        This Spectre PoC relies on realloc failing due to not enough memory for reallocation
        When this occurs, arr_size would double in size due to being speculatively executed
        Yet, access to the public array would occur during the speculation window, resulting in an array out of bounds access.
        This leaves this code vulnerable to a Spectre attack that utilizes a side channel attack to extract the private index of the data array
    */
    if(arr_size < index){
        array_idx = realloc(arr_size*2);
        arr_size *= 2;
        //I would like to fill the array after it is resized with new indices that are randomly generated
        //However, this may exceed the speculation window in which we can extract secrets so the resized array will just have to be filled with 0s
        //This should be ok
    }
    
    uint32_t new_idx = array_idx_nospec(index, arr_size);
    uint32_t secret_idx = array_idx[new_idx];

    return arr[secret_idx * stride];
}

