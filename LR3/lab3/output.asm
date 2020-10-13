PUBLIC newline
PUBLIC output

EXTRN string: far
EXTRN print_cnt: far

STK SEGMENT PARA STACK 'STACK'
    db 200 DUP (0)
STK ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
SEGDATA ENDS

; задаем отдельный модуль и определяем 2 процедуры
SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA, SS:STK

; процедура output с переходом near (flat модель)
output proc near

    mov dl, byte ptr[string] ; считываем символ строки в dl
    mov cl, byte ptr[print_cnt] ; считываем количество итераций (код числа)
    sub cx, "0" ; вычитаем из кода числа код нуля

    mov ah, 2 ; вывод dl на дисплей
    mov bx, 0 ; промежуточный регистр для смещения по строке

    symb_label:
        int 21h ; печать байта
        mov dl, 32
        int 21h ; печать пробела
        inc bx
        mov dl, byte ptr[string + bx] ; поместим следующий символ в dl
        loop symb_label

    ret 
output endp

; процедура newline c типом near (flat модель)
; near - возможность обращения из сегмента кода, в котором она объявлена
; far - возможность обращения из любого сегмента кода
; функция делает перевод каретки на новую строку
newline proc near
    mov ah, 2 ; вывод на дисплей того, что содержит в себе dl
    mov dl, 10 ; символ перевода строки
    int 21h
    mov dl, 13 ; символ возврата каретки
    int 21h

    ret ; возврат управления вызывающей программе (main.asm)
newline endp ; конец процедуры

SEGCODE ENDS ; конец сегмента кода
END ; конец модуля