EXTRN X: byte
PUBLIC exit

SD2 SEGMENT para 'DATA'
	Y db 'Y'
SD2 ENDS

; SC1, SC2 находятся в пределах сегмента
SC2 SEGMENT para public 'CODE'
	assume CS:SC2, DS:SD2
exit:
	mov ax, seg X ; адрес сегмента занесли во всп.сегм.регистр
	mov es, ax

	mov bh, es:X ; SEG X: OFFSET X

	mov ax, SD2
	mov ds, ax

  ; обмен значений X и Y в памяти
	xchg ah, Y ; ah = ? Y = 'Y' => ah = 'Y' Y = ?
	xchg ah, es:X ; ah = 'Y' X = 'X' => ah = 'X' X = 'Y'
	xchg ah, Y ; ah = 'X' Y = ? => ah = ? Y = 'X'

  ; вывод на дисплей Y (там значение X)
	mov ah, 2
	mov dl, Y
	int 21h	
	
	mov ax, 4c00h
	int 21h
SC2 ENDS
END