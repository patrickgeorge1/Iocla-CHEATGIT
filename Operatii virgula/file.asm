%include "includes/io.inc"
extern printf
extern scanf


section .data
	n1    dq    1.1
    n2    dq    4.6
vector    dq    1.1, 2.2, 3.3, 4.2
len		  dd    4
format    db     "%f", 10, 0
formatInt db     "%d", 10, 0
res		  dd    0
max   	  dq    -1000000.0

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
    ;call avg_vecor
    call max_vector
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


avg_vecor:
	enter 0, 0

	xor ecx, ecx
	fldz

	add_eleM:
		fadd QWORD[vector + ecx * 8]
		inc ecx
		cmp ecx, 5
		jl add_eleM

	fidiv DWORD[len]

	sub esp, 8
	fstp QWORD[esp]
	push format
	call printf
	add esp, 12

	leave
	ret


max_vector:
	enter 0, 0

	xor ecx, ecx
	comp_Elem:
		fld QWORD[vector + ecx * 8]
		fld QWORD[max]
		fcomip
		ja not_update_max
		fst QWORD[max]
		not_update_max:
		fstp QWORD[res]

		inc ecx
		cmp ecx, 5
		jl comp_Elem

		fld QWORD[max]
		sub esp, 8
		fstp QWORD[esp]
		push format
		call printf
		add esp, 12


	leave
	ret