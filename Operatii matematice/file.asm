%include "includes/io.inc"

section .data
	num1 db 255
    num2 db 255
    num1_w dw 1349
    num2_w dw 9949
    num1_d dd 134932
    num2_d dd 994912

    dividend1 db 91
    divisor1 db 27
    dividend2 dd 67254
    divisor2 dw 1349
    dividend3 dq 690941487
    divisor3 dd 87621

section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    ; BYTE x BYTE
    mov al, byte [num1]
    mov bl, byte [num2]
    mul bl
    	PRINT_UDEC 2, ax
    	NEWLINE



    ; WORD X WORD dar e prea mare asa ca afisam in haxa
    mov ax, word [num1_w]
    mov bx, word [num2_w]
    mul bx
    	PRINT_HEX 2, dx
    	PRINT_HEX 2, ax
    	NEWLINE


    ; DWORD x DWORD in hex
    														xor edx, edx
    mov eax, dword [num1_d]
    mov ebx, dword [num2_d]
    mul ebx
	    PRINT_HEX 4, EDX
	    PRINT_HEX 4, EAX
	    NEWLINE

															xor eax, eax
															xor ebx, ebx
															xor ecx, ecx
															xor edx, edx


	; BYTE / BYTE

	mov al, byte [dividend1]
    mov bl, byte [divisor1]
    div bl
		PRINT_UDEC 1, al
	    PRINT_STRING " r "
	    PRINT_UDEC 1, ah
	    NEWLINE

    													    xor eax, eax
    														xor ebx, ebx
    														xor edx, edx


    ; WORD / WORD														

    mov edx, dword [dividend2 + 2]
    mov ax, word [dividend2]
    add bx, word [divisor2]
    div bx
	    PRINT_UDEC 2, ax
	    PRINT_STRING " r "
	    PRINT_UDEC 2, dx
	    NEWLINE


    													    xor eax, eax
    														xor ebx, ebx
    														xor edx, edx


    ; DWORD / DWORD														
    														
    mov edx, dword [dividend3 + 4]
    mov eax, dword [dividend3]
    add ebx, dword [divisor3]
    div ebx	
        PRINT_UDEC 4, eax
	    PRINT_STRING " r "
	    PRINT_UDEC 4, edx
	    NEWLINE													

    ret


; functions