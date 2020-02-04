%include "includes/io.inc"

extern printf

section .data
    string db "Nunc tristique ante maximus, dictum nunc in, ultxicies dui.", 0
    len dd ($ - string)
    char db 'a'
    count_char db 'x'
    length dd 0
    res dd 0

    move_string db "aAlexandrAetare"
    size 		dd ($ - move_string)
    a_mic  		db 'a'
    a_mare		db 'A'


section .text

global CMAIN
CMAIN:
    enter 0, 0
    xor eax, eax

    push eax
	    mov al, [char]
		    push string    ; unde
   		    push eax       ; pe cine
		    call memset
		    add esp, 8
    pop eax

    push string
    push 0
    call find        ; what, where, set ecx intern
	add esp, 8


	push DWORD[length]
	push string
	push DWORD[count_char]
    call occurances
    add esp, 12


    ;call move_a_to_final

    leave
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

memset:
	enter 0, 0

    cld
    mov al, byte[ebp + 8]  ; mov al, [char]    ; de unde
    mov edi, [ebp + 12]    ; lea edi, [string] ; unde

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

	mov al, byte[ebp + 8]  ;mov al, 0  ; \0
	mov edi, [ebp + 12]    ;lea edi, [string]

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
		mov al, [ebp + 8] 	 ; mov al, [count_char]
		mov edi, [ebp + 12]  ; lea edi, [string]
		mov ecx, [ebp + 16]	 ; mov ecx, [length]
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

move_a_to_final:
	enter 0, 0

	xor eax, eax
	xor edx, edx
	mov ebx, [size]
	inc ebx
	mov ecx, [size]

	mov al, [a_mic]
    lea edi, [move_string]
    cld
    repne scasb
    dec edi
    sub edi, move_string  ; stau pe caracterul gasit
    dec ebx  	    	  ; aleg unde sa -l transfer
    dec ecx			 	  ; sa nu ajunga pana la final

    push ecx
    push eax
	    mov cl, [move_string + ebx]
	    mov al, [edi]
	    mov [move_string + ebx], al
	    mov [edi], cl
	pop eax
	pop ecx



    mov [length], edi
	    PRINT_UDEC 4, [length]
	    NEWLINE


	leave
	ret