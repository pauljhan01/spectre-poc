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
    uint32_t index = 30;
    victim_function(index);
}

void victim_function(uint32_t index){
    static uint32_t length = 15;
    index = array_index_nospec(index, length);

    printf("Index: %d\n", index);
}

// int main(int argc, char **argv) {
//     if (argc == 2 && strcmp(argv[1], "naive") == 0) {
//         printf("Using a naive Spectre PoC\n");
//     } else {
//     }
//     return 0;
// }
