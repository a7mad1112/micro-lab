;*****************************************
;     MDA-Win8086 EXPERIMENT PROGRAM    *
;     FILENAME  : FND.ASM
;     PROCESSOR : I8086
;     8255 TEST
;*****************************************
CODE	SEGMENT
	ASSUME	CS:CODE,DS:CODE,ES:CODE,SS:CODE
	;
PPIC_C	EQU	1FH
PPIC	EQU	1DH
PPIB	EQU	1BH
PPIA	EQU	19H
	;	
KEY	EQU	01H
        ;
        ;TASK 2
	ORG	1000H
	MOV	AL,10000000B
	OUT	PPIC_C,AL
	;
	MOV	AL,11110000B
	OUT	PPIB,AL
	;
	MOV	AL,00000000B
	OUT	PPIC,AL
	;
L1:     CALL	SCAN
        MOV	AL,BYTE PTR K_BUF
        AND AX, 000FH
        CMP AX, 0001H
        JNE L1
        MOV AL, 0FFH
        MOV     BYTE PTR K_BUF,AL
        MOV DX, 0
L3:     MOV DL, 10
        MOV SI, OFFSET DATA
L2:     MOV AX, 0
        MOV AL, BYTE PTR CS:[SI]
        OUT PPIA, AL
        CALL SCAN
        MOV	AL,BYTE PTR K_BUF
        AND AX, 000FH
        CMP AL, 01H
        JZ L1
        CMP AL, 00H
        JE L1
        CALL TIMER
        INC SI
        DEC DL
        CMP DL, 0
        JE L3
        JMP L2		
	;
	INT	3
	;		
TIMER:	MOV	CX, 0000H
TIMER1:	NOP
	NOP
	NOP
	NOP
	LOOP	TIMER1
        RET
	;
SCAN:	IN	AL,KEY
	TEST	AL,10000000B
	JNZ	END
	TEST	AL,00010000B
	JNZ	END
	;
	AND	AL,00001111B
	MOV	BYTE PTR K_BUF,AL
	; key clear
END:	OUT	KEY,AL
	RET
	;
DATA:	DB	11000000B
	DB	11111001B
	DB	10100100B
	DB	10110000B
	DB	10011001B
	DB	10010010B
	DB	10000010B
	DB	11111000B
	DB	10000000B
	DB	10010000B
	;
K_BUF:  DB 1
        ;
CODE	ENDS
	END

