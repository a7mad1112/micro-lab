
## if the user press 1 then start counting from 0 to f. if the user press 0 then stop counting
```
CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
; if the user press 1 then start counting from 0 to f. if the user press 0 then stop counting
PPIC_C EQU 1FH
PPIC EQU 1DH
PPIB EQU 1BH
PPIA EQU 19H
KEY EQU 01H
ORG 1000H
MOV AX, 0
MOV DS, AX
;
MOV AL, 80H
OUT PPIC_C, AL

;

     MOV AL, 11110000B
     OUT PPIB, AL
     ;
     MOV AL, 00
     OUT PPIC, AL
     ;

START:
     CALL SCAN
     CMP AL, 01
     JNE START

     MOV SI, OFFSET DATA
     MOV DL, 16

AGAIN:
     MOV AL, BYTE PTR CS:[SI]
     OUT PPIA, AL
     CALL TIMER3
     CALL SCAN1
     CMP AL, 00
     JE START
     INC SI
     DEC DL
     JNZ AGAIN
     JMP START

INT 3

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


SCAN1:
     IN AL, KEY
     TEST AL, 10000000B
     JNZ R
     TEST AL, 00010000B
     JNZ R
     ;
     AND AL, 00001111B
     MOV BYTE PTR K_BUF, AL
     ;
     OUT KEY, AL    ;CLEAR
R:   RET
     
DATA:
     DB 11000000B
     DB 11111001B
     DB 10100100B
     DB 10110000B
     DB 10011001B
     DB 10010010B
     DB 10000010B
     DB 11111000B
     DB 10000000B
     DB 10010000B
     DB 10001000B ; A
     DB 10000000B ; B
     DB 11000110B ; C
     DB 11000000B ; D
     DB 10000110B ; E
     DB 10001110B ; F
     DB 00H

LEDS:
     DB 00000000B
     DB 00000001B
     DB 00000011B
     DB 00000111B
     DB 00001111B
     DB 00H

K_BUF: DB 1

TIMER1: MOV CX, 1000
TIMER1_LOOP:
        NOP
        NOP
        NOP
        NOP
        LOOP TIMER1_LOOP
        RET

TIMER2: MOV CX, 7000
TIMER2_LOOP:
        NOP
        NOP
        NOP
        NOP
        LOOP TIMER2_LOOP
        RET

TIMER3: MOV CX, 0
TIMER3_LOOP:
        NOP
        NOP
        NOP
        NOP
        LOOP TIMER3_LOOP
        RET

CODE ENDS
END
```
