CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
;
PPIC_C EQU 1EH
PPIC EQU 1CH
PPIB EQU 1AH
PPIA EQU 18H
KEY EQU 01H

;    ; TASK3
     ORG 1000H
     MOV AX, 0
     MOV DS, AX
     ;
     MOV AL, 80H
     OUT PPIC_C, AL
     ;
     ;
     MOV AL, 0FFH
     OUT PPIB, AL
     ;
     MOV AL, 0E7H
     OUT PPIA, AL
     ;
     MOV AL, 018H
     OUT PPIC, AL
     ;
L2:
     CALL SCAN
     MOV AL, BYTE PTR K_BUF
     AND AL, 000FH
     CMP AL, 0AH
     JE L3
     JMP L2

L3:  MOV AL, 018H
L1:
     ROR AL, 1
     OUT PPIC, AL
     CALL TIMER
     CMP AL, 18H
     JE L2
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
