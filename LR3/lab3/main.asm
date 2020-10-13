; описание идентификаторов, доступных из других модулей: идентификатор : тип
EXTRN newline: near
EXTRN output: near

; описание идентификатора, видимого из других модулей
PUBLIC string
PUBLIC print_cnt

SEGDATA SEGMENT PARA COMMON 'DATA'
    max_size      db 100 ; максимальная длина строки
    string_len    db 0 ; длина строки
    string        db 100 DUP ("$") ; строка из 100 символов

    max_size2     db 3 ; максимальная длина числа
    print_cnt_len db 0 ; длина числа
    print_cnt     db 3 DUP ("$") ; число
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA
main:
    mov ax, SEGDATA
    mov ds, ax

    ; ввод строки (считаем символы в al)
    mov ah, 0Ah
    mov dx, offset max_size
    int 21h

    ; перевод на новую строку
    call newline

    ; ввод числа
    mov ah, 0Ah
    mov dx, offset max_size2 ; ?
    int 21h

    ; перевод на новую строку
    call newline

    ; расчет и вывод результата
    call output

    ; завершение работы программы
    mov ax, 4Ch
    int 21h
SEGCODE ENDS
END main  ; исполняемый модуль содержит метку main