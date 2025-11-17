CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
;
PPIC_C EQU 1EH
PPIC EQU 1CH
PPIB EQU 1AH
PPIA EQU 18H
;    ; TASK 2
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
     ;
     MOV DL, 0AH
L1:
     OUT PPIC, AL
     ROR AL, 1
     CALL TIMER
     JC L2
     JMP L1
L2:
     DEC DL
     JNZ L1
     MOV AL, 0
     OUT PPIC, AL
     ;
     INT 3
     ;
TIMER:     MOV CX, 0
TIMER1:    NOP
           NOP
           NOP
           LOOP TIMER1
           RET
           ;
CODE       ENDS
           END
