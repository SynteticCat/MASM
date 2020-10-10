EXTRN SBHVALUE:BYTE
EXTRN SBLVALUE:BYTE
EXTRN SIGN:BYTE
EXTRN SIGNOCT:BYTE

PUBLIC READ_NUM

CODES SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CODES
    
; чтение знака
READ_SIGN PROC NEAR
    MOV AH, 1
    INT 21H

    CMP AL, "-"
    JE CHANGE_SIGN
    RET
    CHANGE_SIGN:
        MOV SIGN, "-"
        MOV SIGNOCT, "1"
    RET
READ_SIGN ENDP

; считать знаковое двоичное
READ_NUM PROC NEAR
    CALL READ_SIGN

    MOV SBHVALUE, 00000000B
    MOV SBLVALUE, 00000000B

    MOV CX, 8
    READ_SYMB:
        MOV AH, 1
        INT 21H

        CMP AL, 13
        JE FINISHSWITCH

        SUB AL, "0"
        SHL SBHVALUE, 1 ; сдвиг влево на 1
        ADD SBHVALUE, AL ; запись значения
        LOOP READ_SYMB ; считываю 8 символов
    READ_SYMBL:
        MOV AH, 1
        INT 21H

        CMP AL, 13
        JE FINISH

        SUB AL, "0"
        SHL SBLVALUE, 1
        ADD SBLVALUE, AL
        JMP READ_SYMBL
    FINISHSWITCH:
        MOV BL, SBHVALUE
        MOV SBLVALUE, BL
        MOV SBHVALUE, 0
    FINISH:
    RET
READ_NUM ENDP

CODES ENDS
END