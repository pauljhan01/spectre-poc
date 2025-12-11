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
	watch -n 0.2 LD_PRELOAD=$(realpath ./mimalloc-main/out/release/libmimalloc.so) ./mspectre

compileMI:
	cd mimalloc-main && rm -rf out/release && mkdir -p out/release && cd out/release && cmake ../.. && make -j4
	gcc -g mspectre.c -o mspectre -I./mimalloc-main/include -L./mimalloc-main/out/release -Wl,-rpath,./mimalloc-main/out/release -lmimalloc -lpthread
	gcc -g mspectre_if.c -o mspectre_if -I./mimalloc-main/include -L./mimalloc-main/out/release -Wl,-rpath,./mimalloc-main/out/release -lmimalloc -lpthread
	cd mimalloc-main && rm -rf out/release && mkdir -p out/release && cd out/release && cmake ../.. -DMI_BUILD_STATIC=ON -DMI_OVERRIDE=OFF && make -j4
	gcc -o mspectre_lib mspectre_lib.c ./mimalloc-main/out/release/libmimalloc.a -I./mimalloc-main/include -lpthread
	objdump -d mspectre_lib > mspectre_lib.s
	cd mimalloc-main && rm -rf out/release && mkdir -p out/release && cd out/release && cmake ../.. && make -j4

mspectre:
	gcc -g mspectre.c -o mspectre

masm:
	gcc -S mspectre.c -o mspectre.s

clean:
	rm spectre
