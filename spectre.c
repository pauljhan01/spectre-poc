#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "nospec.h"
// #include <linux/nospec.h>

void victim_function(uint32_t index);

int main (void){
    uint32_t index = 30;
    victim_function(index);
}

void victim_function(uint32_t index){
    static uint32_t length = 15;
    index = array_index_nospec(index, length);

    printf("Index: %d\n", index);
}

