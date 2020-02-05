%include "includes/io.inc"

section .data
	NB:			dd		3
	k:			dd  	5
vector:			dd      10, 12, 15, 20, 30, 100
len:			dd  	($ - vector) / 4

section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    ;call caut_bits
	


    push DWORD[k]
    push DWORD[len]
    push vector
	call apply_on_vect
    add esp, 12

    ret


; functions

caut_bits:
	enter 0,0

		mov ebx, DWORD[NB]
		popcnt	eax, ebx
		PRINT_UDEC 4, eax
		NEWLINE


	leave
	ret

apply_on_vect:
	enter 0, 0
	mov eax, [ebp + 8]   ; arr
	mov edx, [ebp + 12]  ; len
	mov ebx, [ebp + 16]  ; k



	xor ecx, ecx
	apply_on_elem:
		cmp ecx, edx
		je stop_apply
			push edx
				push ebx
				push DWORD[eax + 4 * ecx]
					mov edx, eax
				call self_mul
				add esp, 8
				mov DWORD[edx + 4 * ecx], eax
				mov eax, edx
			pop edx
		inc ecx
	jmp apply_on_elem

	stop_apply:
	leave
	ret


self_mul:	
	enter 0, 0 
	push edx
	push ecx
	push ebx
		mov eax, [ebp + 8]     ; nr
		mov ebx, [ebp + 12]    ; ct
		mul ebx
	pop ebx
	pop ecx
	pop edx

	PRINT_UDEC 4, eax
	NEWLINE

	leave
	ret