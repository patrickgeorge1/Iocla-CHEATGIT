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

    push 100
    push string
    push 0
    call find        ; what, where, set ecx intern
	add esp, 8


	push DWORD[length]
	push string
	push DWORD[count_char]
    call occurances
    add esp, 12

    push DWORD[size]
    push move_string
    push DWORD[a_mic]
    call move_a_to_final
    add esp, 12

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

	mov al, byte[ebp + 8]  ;mov al, 0  ; \0
	mov edi, [ebp + 12]    ;lea edi, [string]
	mov ecx, [ebp + 16]

    cld
    repne scasb
    dec edi
    sub edi, [ebp+12]
    mov [length], edi
	    ;PRINT_UDEC 4, [length]
	    ;NEWLINE

	mov eax, [length]
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

	mov eax, [res]
	leave
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

move_a_to_final:
	enter 0, 0

	xor ebx, ebx
	xor edx, edx
	xor eax, eax

	mov ebx, [ebp + 8]
	mov edi, [ebp +12]
	mov ecx, [ebp + 16]



		

	push edi
		push ecx
			add edi, eax
		push edi
		push ebx
		call find
		pop ebx
		pop edi
		pop ecx

		NEWLINE
		PRINT_CHAR [edi + 1]
		PRINT_STRING " "
		PRINT_UDEC 4, eax

    pop edi
    









	leave
	ret