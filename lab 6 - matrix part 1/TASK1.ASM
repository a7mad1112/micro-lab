CODE SEGMENT
ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
;
PPIC_C EQU 1EH
PPIC EQU 1CH
PPIB EQU 1AH
PPIA EQU 18H
;    ; TASK1
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

     MOV AL, 0FFH
     OUT PPIC, AL
     ;
L1:
      MOV AL, 11111110B
      OUT PPIA, AL
      CALL TIMER
      AND AL, 11111100B
L2:
     OUT PPIA, AL
     SHL AL, 1
     OR AL, 01
     CALL TIMER
     CMP AL, 11111111B
     JE L1
     JMP L2
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
