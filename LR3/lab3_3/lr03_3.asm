SD1 SEGMENT para public 'DATA'
	S1 db 'Y'
	db 65535 - 2 dup (0) ; размер и смещение влево на 2 байта
SD1 ENDS

SD2 SEGMENT para public 'DATA'
	S2 db 'E'
	db 65535 - 2 dup (0)
SD2 ENDS

SD3 SEGMENT para public 'DATA'
	S3 db 'S'
	db 65535 - 2 dup (0)
SD3 ENDS

CSEG SEGMENT para public 'CODE'
	assume CS:CSEG, DS:SD1

output:
	mov ah, 2 ; вывод на дисплей dl
	int 21h

	mov dl, 13 ; символ перехода на новую строку
	int 21h

	mov dl, 10 ; возврат каретки
	int 21h
	ret

main:
	mov ax, SD1
	mov ds, ax

  ; вывод S1
	mov dl, S1
	call output

assume DS:SD2
	mov ax, SD2
	mov ds, ax

	; add ax, 01000h
	; mov ds, ax

	; вывод S2
	; mov dl, ds:0000 ; что не так?!
	mov dl, S2
	call output

assume DS:SD3 ; что делает программа
	mov ax, SD3
	mov ds, ax

	; вывод S3
	mov dl, S3
	call output

	mov ax, 4c00h
	int 21h
CSEG ENDS
END main