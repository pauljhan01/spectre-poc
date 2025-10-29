all:
	gcc -o spectre /usr/local/lib/mimalloc-2.2/mimalloc.o spectre.c

mac:
	clang spectre.c -o spectre

gcc_a:
	gcc attacker.c -o attack

clean:
	rm spectre
