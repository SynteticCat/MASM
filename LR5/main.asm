EXTRN READ_NUM:NEAR ; считать знаковое двоичное
EXTRN PRINT_UO:NEAR ; вывести беззнаковое десятичное
EXTRN PRINT_SH:NEAR ; вывести знаковое шестнадцатиричное
EXTRN NEW_LINE:NEAR ; новая строка

PUBLIC SBHVALUE
PUBLIC SBLVALUE
PUBLIC SIGN
PUBLIC SIGNOCT
PUBLIC UOVALUE
PUBLIC SHVALUE
PUBLIC HEXTABLE

STKS SEGMENT PARA STACK 'STACK'
    DB 200 DUP (?)
STKS ENDS

DATAS SEGMENT PARA PUBLIC 'DATA'
    MENU DB "1. INPUT SIGNED BINARY.", 10, 13 ; меню для вывода на дисплей
        DB "2. PRINT UNSIGNED OCT.", 10, 13
        DB "3. PRINT SIGNED HEX.", 10, 13
        DB "4. EXIT.", 10, 13
        DB "CHOOSE OPERATION: $"
    FUNC DW 4 DUP (0) ; функции 4 пунктов меню
    SBHVALUE DB 00000000B
    SBLVALUE DB 00000000B
    SIGN DB "+" ; знак
    SIGNOCT DB 0
    UOVALUE DB 5 DUP ("0"), "$"
    SHVALUE DB 4 DUP ("0"), "$"
    HEXTABLE DB "0123456789ABCDEF"
DATAS ENDS

CODES SEGMENT PARA PUBLIC 'CODE'
    ASSUME DS:DATAS, CS:CODES
MAIN:
    MOV AX, DATAS
    MOV DS, AX
    
    MOV FUNC[0], 00
    MOV FUNC[2], PRINT_UO
    MOV FUNC[4], PRINT_SH
    MOV FUNC[6], EXIT
    
    MENU_OUT:
        MOV AH, 9 ; выдать строку DS:DX на дисплей 
        MOV DX, 0
        INT 21H
        
        MOV AH, 1 ; ввод с клавиатуры
        INT 21H
        
        MOV AH, 0 ; завершить программу (установим CS c сегментом PSP завершающего процесса)
        ; после прерывания управление упадет на PSP (родительский процесс)

        SUB AL, "1"
        MOV DL, 2
        MUL DL ; умножаем AL на DL
        MOV BX, AX ; получаем индекс операции
        
        CALL NEW_LINE
        CALL FUNC[BX] ; вызов операции
        CALL NEW_LINE
    JMP MENU_OUT

EXIT PROC NEAR
    MOV AX, 4C00H
    INT 21H
EXIT ENDP
    
CODES ENDS
END MAIN