all:
	gcc -g spectre.c -o spectre -O1

asm:
	gcc -S spectre.c -o spectre.s -O1
	
mac:
	clang spectre.c -o spectre

watch:
	watch -n 0.2 ./spectre

gcc_a:
	gcc attacker.c -o attack

mwatch:
	watch -n 0.2 LD_PRELOAD=$(realpath ./mimalloc-main/out/libmimalloc.so) ./mspectre

masm:
	gcc -g mspectre.c -o mspectre

clean:
	rm spectre
