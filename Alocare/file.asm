%include "includes/io.inc"

section .data   ; 1 DB,  2 DW, 4 DD  
	var:		DB 64
	vect:		DD 1, 2, 3
	vectLen: 	DD ($ - vect) / 4  ; ATENTIE, daca vect nu e DB trebuie impartit la ... sau $ echiv cu vectLen
	array: 		TIMES 8 DB 0   ; array size 8 plin de 0
	string:		DB "salut", 0    ; poate sa fie si DD ca face singur aritmetica

section .bss
	val		resb 1
	arrayU  resb 20

section .text



global CMAIN
CMAIN:
    mov ebp, esp

    ; code in main
    PRINT_UDEC 4, [vectLen]
    NEWLINE

    PRINT_CHAR [string]  ; [string + 1] = a
    NEWLINE


    ret


; functions