CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
;
PPIC_C EQU 1EH
PPIC EQU 1CH
PPIB EQU 1AH
PPIA EQU 18H
KEY EQU 01H

;    ; TASK4
     ORG 1000H
     MOV AX, 0
     MOV DS, AX
     ;
     MOV AL, 80H
     OUT PPIC_C, AL
     ;
     ;
     MOV AL, 18H
     OUT PPIC, AL
     MOV AL, 00100111B
     OUT PPIB, AL
     MOV AL, 11100100B
     OUT PPIA, AL
     ;
     INT 3
     ;

SCAN:
     IN AL, KEY
     TEST AL, 10000000B
     JNZ SCAN
     TEST AL, 00010000B
     JNZ SCAN
     ;
     AND AL, 00001111B
     MOV BYTE PTR K_BUF, AL
     ;
     OUT KEY, AL    ;CLEAR
     RET

K_BUF: DB 1


TIMER:     MOV CX, 0
TIMER1:    NOP
           NOP
           NOP
           LOOP TIMER1
           RET
           ;
CODE       ENDS
           END
