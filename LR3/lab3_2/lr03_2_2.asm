SD1 SEGMENT para common 'DATA'
  ; в памяти храним наоборот 34 44 => С1 = 44 С2 = 34
	C1 LABEL byte
	ORG 1h ; связываем метку с конкретным адресом
	C2 LABEL byte
SD1 ENDS

CSEG SEGMENT para 'CODE'
	ASSUME CS:CSEG, DS:SD1
main:
	mov ax, SD1
	mov ds, ax

  ; вывод на экран
	mov ah, 2

  ; С1 = 44 = 'D'
	mov dl, C1
	int 21h

  ; С2 = 34 = '4'
	mov dl, C2
	int 21h

	mov ah, 7
	int 21h

	mov ax, 4c00h
	int 21h
CSEG ENDS
END main