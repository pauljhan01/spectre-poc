#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
// #include <linux/nospec.h>

int main (void){
    
}

void victim_function(uint32_t index){
    static uint32_t length;
    index = array_idx_nospec(index, length);

    uint32_t secret = 
}

