%include "includes/io.inc"
extern scanf
extern stdin
extern gets


section .data
    scanf_format dd "%d", 0
    scanf_format_string dd "%s", 0


section .bss 
    arr times 100 resd 1
    n resb 4
    string times 200 resb 1
    radu  resb 1000


section .text


global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
   	;call citire   ;string

    
    ; citeste n
    push n
    push scanf_format
    call scanf
    add esp, 8
    PRINT_UDEC 4, n
    NEWLINE
    


    ; citeste elementele din array
    mov ecx, 0
	read_array:
	    lea eax, [arr + 4 * ecx]
	    push ecx
		    push dword eax
		    push scanf_format
		    call scanf
		    add esp, 8
	    pop ecx
	    inc ecx
	    cmp ecx, [n]
	jl read_array
 
    
       
    ; afisare
    PRINT_STRING "Array: "
    mov ecx, 0
    lea eax, [arr]
	print_array:
	    PRINT_UDEC 4, [eax]
	    PRINT_CHAR ' '
	    inc ecx
	    add eax, 4
	    cmp ecx, [n]
	jl print_array



    xor eax, eax
    mov ebp, esp
    ret


citire:
	enter 0, 0

	sub esp, 12
	    push esp
	    call gets
	    add esp, 4

	NEWLINE
	PRINT_CHAR [esp]
	NEWLINE
	PRINT_CHAR [esp+1]
	NEWLINE
	PRINT_CHAR [esp+2]


	leave
	ret



citire_direct_pe_stiva:
	enter 0, 0

	    sub esp, 4

        push esp
        push uint_format
        call scanf
        add esp, 8

        push dword[esp]
        push uint_format_newline
        call printf
        add esp, 8

        add esp, 4

    leave
    ret


citire_stiva_fgets:
    enter 0, 0

        sub esp, 4

        mov ebx, esp
        push dword[stdin]
        push 10
        push ebx
        call fgets
        add esp, 12

        push ebx
        push string_format
        call printf
        add esp, 8

        add esp, 4

    leave
    ret


citire_in_memorie:
    enter 0, 0

    push dword[stdin]
    push 18
    push radu
    call fgets
    add esp, 12
    
    push radu
    push format_str
    call printf
    add esp, 8

    leave
    ret