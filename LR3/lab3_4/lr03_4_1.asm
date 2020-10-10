PUBLIC X
EXTRN exit: far ; меняется CS и IP

SSTK SEGMENT para STACK 'STACK'
	db 100 dup(0)
SSTK ENDS

SD1 SEGMENT para public 'DATA'
	X db 'X'
SD1 ENDS

SC1 SEGMENT para public 'CODE'
	assume CS:SC1, DS:SD1
main:	
	jmp exit ; передача управления (не сохр. инф. возврата)
SC1 ENDS
END main