extern rand
extern time
extern srand
extern scanf
extern printf
extern puts


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    msg    db "Insert number: ", 0
    is_smaller_string db "Numarul introdus este mai mic", 0
    is_larger_string db "Numarul introdus este mai mare", 0
    int_format db "%d", 0

    dividend3 dq 0
    divisor3 dd 0


section .bss
    num resd 1
    user_input resd 1


section .text


; TODO c: Create read_cmp() function.



global main
main:
    push ebp
    mov ebp, esp


    ; TODO a: Call srand(time(0)) and then rand() and store return value modulo 100 in num.
    push 0
    call time
    add esp, 4

    push eax
    call srand
    add esp, 4

    call rand

    mov DWORD[dividend3], eax
    mov DWORD[divisor3], 100
    mov edx, dword [dividend3 + 4]
    mov eax, dword [dividend3]
    add ebx, dword [divisor3]
    div ebx 
    mov [num], edx   


    ; Debug only: Print value of num to check it was properly initialized.
    push dword [num]
    push uint_format_newline
    call printf
    add esp, 8

    ;jmp make_call
    

                                    ;input_number:
                                    ;    sub esp, 4

                                    ;    push esp
                                    ;    push uint_format
                                    ;    call scanf
                                    ;    add esp, 8

                                    ;    push dword[esp]
                                    ;    push uint_format_newline
                                    ;    call printf
                                    ;    add esp, 8

                                    ;    add esp, 4

                                    ;jmp input_number


    input_number:
        call read_cmp
        cmp eax, 1
        je stop_bucla

    jmp input_number

    stop_bucla:
        
    leave
    ret

make_call:
    
    ; TODO d:



    ; Return 0.
    xor eax, eax
    leave
    ret


read_cmp:
    enter 0, 0

        push msg
        call printf
        add esp, 4

        push user_input
        push uint_format
        call scanf
        add esp, 8

        mov eax, [user_input]
        cmp eax, [num]
        je return_true
        cmp eax, [num]
        jl return_smaller
        cmp eax, [num]
        jg return_greater

 
    leave
    ret

return_true: 
        mov eax, 1
        leave
        ret

return_smaller:
    push is_smaller_string
    call printf
    add esp, 4

    mov eax, 0
    leave
    ret


return_greater:
    push is_larger_string
    call printf
    add esp, 4

    mov eax, 0
    leave
    ret
