CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
;
PPIC_C EQU 1EH
PPIC EQU 1CH
PPIB EQU 1AH
PPIA EQU 18H
;    ; TASK0
     ORG 1000H
     MOV AX, 0
     MOV DS, AX
     ;
     MOV AL, 80H
     OUT PPIC_C, AL
     ;
     MOV AL, 0FFH
     OUT PPIA, AL
     ;
     MOV AL, 0
     OUT PPIB, AL
     ;

     MOV AL, 01H
     OUT PPIC, AL
L1:
     ROL AL, 1
     OUT PPIC, AL
     CALL TIMER
     JMP L1
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
