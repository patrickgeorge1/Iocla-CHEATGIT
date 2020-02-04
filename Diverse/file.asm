%include "includes/io.inc"

section .data
	n: 			DD  9
  res:			DD  0


section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    call fibonacciSum

    ret
 

fibonacciN:
	enter 0, 0

	mov eax, 0 ; prim
	mov ebx, 1 ; second
	mov ecx, [ebp + 8]
	
		cmp ecx, 2
		jle baseFibo

	sub ecx, 2

	add_fibo:
		mov [res], ebx
		add ebx, eax
		mov eax, [res]
	loop add_fibo

	jmp print_second

		baseFibo:
			cmp ecx, 2
			je print_second
			dec ebx

			print_second:
			mov eax, ebx

	leave
	ret


fibonacciSum:
	enter 0, 0

	mov ecx, [n]
	xor ebx, ebx
	add_to_sum:
		push ebx
		push ecx
		call fibonacciN
		pop ecx
		pop ebx
		add ebx, eax
		loop add_to_sum


	PRINT_UDEC 4, ebx
	NEWLINE

	leave
	ret

; functions