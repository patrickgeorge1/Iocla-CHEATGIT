%include "includes/io.inc"

section .data
    ; TODO a: Define arr1, arr2 and res arrays.
    arr1:           DD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    arr2:           DD 11, 12, 13, 14, 15, 16, 17, 18, 19, 110  
    num:            DD 10

section .bss
    res resd 10

section .text
global main

main:
    push ebp
    mov ebp, esp


    ; TODO b: Compute res[0] and res[n-1].
    mov eax, [arr1]
    add eax, [arr2 + 4 * 9]
    mov [res], eax

    mov eax, [arr1 + 4 * 9]
    add eax, [arr2]
    mov [res + 4 * 9], eax
    NEWLINE
    NEWLINE
    NEWLINE



    ; List first and last item in each array.
    PRINT_UDEC 4, [arr1]
    NEWLINE
    PRINT_UDEC 4, [arr2]
    NEWLINE
    PRINT_UDEC 4, [res]
    NEWLINE

    PRINT_UDEC 4, [arr1+36]
    NEWLINE
    PRINT_UDEC 4, [arr2+36]
    NEWLINE
    PRINT_UDEC 4, [res+36]
    NEWLINE
    NEWLINE
    NEWLINE


    ; TODO d: Compute cross sums in res[i].
    xor ecx, ecx
    iterate_again:
        mov eax, [arr1 + 4 * ecx]
        push ebx
            mov ebx, 9
            sub ebx, ecx
            add eax, [arr2 + 4 * ebx]
        pop ebx
        mov [res + 4 * ecx], eax
        inc ecx
        cmp ecx, 10
    jne iterate_again

    ; TODO c: List arrays.
    xor ecx, ecx
    print_again:
        PRINT_UDEC 4, [arr1 + 4 * ecx]
        NEWLINE
        PRINT_UDEC 4, [arr2 + 4 * ecx]
        NEWLINE
        PRINT_UDEC 4, [res + 4 * ecx]
        NEWLINE
        inc ecx
        cmp ecx, 10
        jne print_again




    ; Return 0.    
    xor eax, eax
    leave
    ret