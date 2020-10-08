; поменять местами минимальный и максимальный
; элемент в каждом столбце

EXTRN newline: near
EXTRN prnt_matrix: near
EXTRN change_max_min: near
EXTRN space: near

PUBLIC m
PUBLIC n
PUBLIC matrix

STK SEGMENT PARA STACK 'STACK'
    db 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
    m             db 1; строки
    n             db 1; столбцы

    matrix        db 81 DUP ("0")
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEGCODE, DS:SEGDATA, SS:STK
main:
    mov ax, SEGDATA
    mov ds, ax

    ; записываем количество строк в m
    mov ah, 1
    int 21h
    mov m, al
    sub m, "0" ; ?
 
    ; поставить пробел
    call space

    ; записываем количество строк в n
    mov ah, 1
    int 21h
    mov n, al
    sub n, "0"

    ; перевод на новую строку
    call newline

    ; в al поместим m
    ; n - это байт => AX = AL * число => AX = m * n
    mov al, m
    mul n
    mov cx, ax ; в cx количество элементов массива

    mov si, 0 ; индекс источника
    read_lbl:
        ; считаем число в матрицу
        mov ah, 1
        int 21h
        mov matrix[si], al
        inc si

        call space

        ; ?
        mov ax, si
        mov dh, byte ptr[n]
        div dh

        ; cmp - установка и сброс флагов
        cmp ah, 0 ; сравнение операндов ah и 0
        je call_newline ; переход на новую строку, если ah = 0

        ; цикл продолжается
        go_back:
          loop read_lbl

    call newline

    ; основная логика обмена значений в матрице
    call change_max_min

    ; вывод матрицы
    call prnt_matrix

    mov ax, 4Ch
    int 21h

call_newline:
    call newline
    jmp go_back

SEGCODE ENDS
END main