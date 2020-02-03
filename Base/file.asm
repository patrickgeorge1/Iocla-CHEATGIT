%include "includes/io.inc"

section .data


section .text
global CMAIN
CMAIN:
    mov ebp, esp

    mov eax, 4
    PRINT_UDEC 4, eax
    NEWLINE

    ret
