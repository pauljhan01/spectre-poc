all:
	gcc -g -O0 spectre.c -o spectre

mac:
	clang spectre.c -o spectre

gcc_a:
	gcc attacker.c -o attack

clean:
	rm spectre
