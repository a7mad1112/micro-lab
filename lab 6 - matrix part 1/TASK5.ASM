CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
;
PPIC_C EQU 1EH
PPIC EQU 1CH
PPIB EQU 1AH
PPIA EQU 18H
KEY EQU 01H

;    ; TASK5
     ORG 1000H
     MOV AX, 0
     MOV DS, AX
     ;
     MOV AL, 80H
     OUT PPIC_C, AL
     ;
     MOV AL, 80H
     OUT PPIC, AL
     MOV AL, 11111111B
     OUT PPIB, AL
     MOV AL, 11111111B
     OUT PPIA, AL
     ;
L1:
     CALL SCAN
     MOV SI, OFFSET DATA
     MOV AL, BYTE PTR K_BUF
     AND AL, 000FH
     CMP AL, 8H
     JBE L2
     JMP L1
L2:
     ADD SI, AX
     MOV AL, BYTE PTR CS:[SI]
     OUT PPIB, AL
     OUT PPIA, AL
     JMP L1
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

DATA:
     DB 0FFH
     DB 11111110B ;1
     DB 11111100B ;2
     DB 11111000B ;3
     DB 11110000B ;4
     DB 11100000B ;5
     DB 11000000B
     DB 10000000B; 7
     DB 00000000B; 8
     


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
