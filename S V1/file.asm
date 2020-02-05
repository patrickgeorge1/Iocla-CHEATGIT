%include "includes/io.inc"

section .data
	vector:			DD 	10, 20, 30, 40, 50
	len:			DD  ($ - vector) / 4

section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    ;push DWORD[len]
    ;push vector
    ;call print
    ;add esp, 8

    call task_c

    ret



print:
	enter 0, 0
	mov edx, [ebp + 12]
	mov ebx, [ebp + 8]

	xor ecx, ecx     ; mov ecx 1 ca sa mearga task c
	print_elem:
		cmp ecx, edx
		je done

		mov eax, DWORD[ebx + 4 * ecx]
		PRINT_DEC 4, eax
		PRINT_STRING " "
		inc ecx
		jmp print_elem


	done:
	NEWLINE
	leave
	ret

compute:
	enter 0, 0

	mov eax, [ebp + 8]
	mov ebx, eax
	add ebx, 10

	mul ebx
	;PRINT_DEC 4, eax
	;NEWLINE

	leave
	ret

task_c:
	enter 0, 0


	xor ecx, ecx
	alocate_elem:
		cmp ecx, DWORD[len]
		je done_c

		push ecx 				; in eax am compute(i)
		call compute
		add esp, 4

		sub esp, 4
		mov [esp], eax
		inc ecx
		jmp alocate_elem


done_c:

	
	push 6
	push esp
	call print      ; trebuie modificat in print:  mov ecx, 1 
	add esp, 24

	leave
	ret