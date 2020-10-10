PUBLIC output_X
EXTRN X: byte

DS2 SEGMENT AT 0b800h ; разместить сегмент по адресу видеопамяти
	CA LABEL byte ; метка CA
	ORG 80 * 2 * 2 + 2 * 2 ; 2 строки по 80 символов + 2 символа на третьей строке
	SYMB LABEL word ; метка SYMB
DS2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, ES:DS2
output_X proc near
  ; сегментный адрес видеопамяти, ES:DI начало видеопамяти
	mov ax, DS2
	mov es, ax

	mov ah, 10  ; записать символ с позиции курсора

	mov al, X ; символ

	mov symb, ax ; ?
	ret
output_X endp
CSEG ENDS
END