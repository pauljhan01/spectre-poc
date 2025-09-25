# all:
# 	gcc -c spectre.c -o spectre

mac:
	clang spectre.c -o spectre

clean:
	rm spectre