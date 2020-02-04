%include "includes/io.inc"
%define ARRAY_SIZE    10

section .data
	dword_array dd 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
	sign_array dd -1, 2, 3, 4, 5, 6, 1, 6, 1, -3

section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    call add_elements
    call add_square
    call count_sign
    call check_even

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

add_elements:
	enter 0, 0

		xor eax, eax
		mov ecx, ARRAY_SIZE
		add_dword:
		    mov edx, dword [dword_array + 4 * (ecx - 1)]
		    add eax, edx
	    loop add_dword
	    
	    PRINT_UDEC 4, eax
	    NEWLINE

	leave
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


add_square:
	enter 0, 0

		xor eax, eax
		mov ecx, ARRAY_SIZE
		add_dword_square:

			push ecx
				push eax 												; salvez suma
					mov eax, dword [dword_array + 4 * (ecx - 1)]
					mul eax
				pop ecx
				add eax, ecx
			pop ecx
		loop add_dword_square
		
		PRINT_UDEC 4, eax
    	NEWLINE

    leave
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

count_sign:
	enter 0, 0

		xor ebx, ebx  ; positive
		xor edx, edx  ; negative

		mov ecx, ARRAY_SIZE

		check_sign:
			mov eax, dword [sign_array + 4 * (ecx - 1)]
			cmp eax, 0
			jl inc_neg
			inc ebx
			sign_come_back:
			loop check_sign

		jmp end_count

		inc_neg:
			inc edx
			jmp sign_come_back

		end_count:

		PRINT_STRING "Positive - "
		PRINT_UDEC 4, ebx
		PRINT_STRING "  si Negative - "
		PRINT_UDEC 4, edx
		NEWLINE
	leave
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

check_even:
	enter 0, 0

	xor edx, edx ; pare 

	mov ecx, ARRAY_SIZE
	check_div:
		xor ebx, ebx 
		mov eax, dword [sign_array + 4 * (ecx - 1)]
		mov ebx, 1
		test eax, ebx
		jz dont_inc
			inc edx
		dont_inc:
		loop check_div


	PRINT_STRING "Pare - "
	PRINT_UDEC 4, edx
	PRINT_STRING "  si Impare - "
	mov ebx, ARRAY_SIZE
	sub ebx, edx
	PRINT_UDEC 4, ebx
	NEWLINE

	leave
	ret