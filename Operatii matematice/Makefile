CFLAGS=-m32
AFLAGS=-f elf

build:	exec

exec:	file.o includes/macro.o includes/utils.o
	gcc $^ -o $@ $(CFLAGS)

file.o:file.asm
	nasm $^ -o $@ $(AFLAGS)

clean:
	rm -rf file.o exec
