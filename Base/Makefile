CFLAGS=-m32
AFLAGS=-f elf

build:	exec

exec:	file.o macro.o utils.o
	gcc $^ -o $@ $(CFLAGS)

file.o:file.asm
	nasm $^ -o $@ $(AFLAGS)

clean:
	rm -rf file.o exec
