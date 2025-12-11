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
#define PAGE_SIZE 4096
#define SYMBOL_CNT (1 << (sizeof(char) * 8))



int main (){
    for (int i = 0; i < 4; i++) {
        char *secret = malloc(8);
        printf("Malloc addr: %p\n", secret);
        memset(secret, 0, 8);
        secret = realloc(secret, 64);
        printf("Realloc Secret addr: %p\n", secret);
        memset(secret, 0, 64);
        free(secret);
        secret = malloc(64);
        printf("Malloc Post-Realloc addr: %p\n", secret);
        memset(secret, 0, 64);
        free(secret);
    }
    return 0;
}
