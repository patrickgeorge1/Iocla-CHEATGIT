%include "includes/io.inc"

extern printf

section .data
    string db "Nunc tristique ante maximus, dictum nunc in, ultxicies dui.", 0
    len dd ($ - string)
    char db 'a'
    count_char db 'x'
    length dd 0
    res dd 0


section .text

global CMAIN
CMAIN:
    enter 0, 0

    call memset
    call find
    call occurances

    leave
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

memset:
	enter 0, 0

    cld
    mov al, [char]    ; de unde
    lea edi, [string] ; unde
    mov ecx, 20       ; cate
    rep stosb
	    PRINT_STRING string
	    NEWLINE

	leave
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

find:
	enter 0, 0
	mov ecx, 100    ; ca daca nu se opreste repne 

 	mov al, 0  ; \0
    lea edi, [string]
    cld
    repne scasb
    dec edi
    sub edi, string
    mov [length], edi
	    PRINT_UDEC 4, [length]
	    NEWLINE

	leave
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INTOTDEAUNA compar pe BYTE  BL CU BYTE[]

occurances:
	enter 0, 0

		xor eax, eax
		mov al, [count_char]
		lea edi, [string]
		mov ecx, [length]
		cld

	continue_find:
		repne scasb
			mov bl, BYTE[edi - 1]    
			cmp bl, BYTE[count_char]
			jne stop_occurances
						mov ebx, [res]
						inc ebx
						mov [res], ebx
	jmp continue_find
	stop_occurances:
		PRINT_UDEC 4, [res]
		NEWLINE
	leave
	ret