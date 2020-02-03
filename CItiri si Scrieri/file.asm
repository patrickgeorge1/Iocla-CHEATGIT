%include "includes/io.inc"


extern scanf
section .data

    scanf_format dd "%d", 0
section .bss 
    arr times 100 resb 4
    n resb 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    
    
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