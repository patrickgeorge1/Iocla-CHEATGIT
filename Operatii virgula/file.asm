%include "includes/io.inc"
extern printf
extern scanf


section .data
	n1    dq    1.1
    n2    dq    4.6
vector    dq    1.1, 2.2, 3.3, 4.1
format    db     "%f", 10, 0
formatInt db     "%d", 10, 0
res		  dd    0

section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    ;call add_float
    ;call multiply_float
    ;call div_float
    ;call round_float
    ;call sinX_mPI
    ;call suma_vecor
    ;call fractionr_float

    ret



add_float:
	enter 0, 0

	fld QWORD[n1]
	fadd QWORD[n2]

	sub esp, 8
	fstp QWORD[esp]

	push format
	call printf
	add esp, 12

	leave
	ret


multiply_float:
	enter 0, 0

	fld QWORD[n1]
	fmul QWORD[n2]

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf

	add esp, 12

	leave
	ret


div_float:
	enter 0, 0

	fld qword[n2]
	fdiv qword[n1]

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf
	add esp, 12

	leave
	ret


round_float:
	enter 0, 0

	fld QWORD[n2]
	frndint

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf
	add esp, 12

	leave
	ret

sinX_mPI:
	enter 0, 0

	fldpi
	fmul QWORD[n1]
	fsin

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf
	add esp, 12

	leave
	ret

suma_vecor:
	enter 0, 0

	xor ecx, ecx
	fldz

	add_elem:
		fadd QWORD[vector + ecx * 8]
		inc ecx
		cmp ecx, 5
		jl add_elem

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf
	add esp, 12

	leave
	ret

fractionr_float:
	enter 0, 0

	fld QWORD[n1]
	fisttp DWORD[res]   ; am partea intreaga in res
	fld QWORD[n1]
	fisub DWORD [res]

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf
	add esp, 12

	leave
	ret