make:
	nasm -f elf32 a4.asm

compile:

	ld -lc -lAlong32 --dynamic-linker /lib/ld-linux.so.2 -m elf_i386 -o a a4.o

clean:

	rm a4.o | rm a	
