DATA SEGMENT    ;�ж��Ƿ��Сд��ĸ �ӳ���
	STR1 DB "Please input a letter:",0DH,0AH,'$'
	STR2 DB 0DH,0AH,"This is a capital letter!$"
	STR3 DB 0DH,0AH,"This is a small letter!$"
	STR4 DB 0DH,0AH,"This is not a letter!$"
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
START:MOV AX,DATA
	MOV DS,AX

	;����ַ���
	LEA DX,STR1
	MOV AH,09H
	INT 21H 

	;�����ַ���AL
	MOV AH,01H
	INT 21H
	CALL JUDGE
	
   EXIT: MOV AH,09H
	INT 21H
        MOV AH,4CH
	INT 21H 

   JUDGE PROC
        CMP AL,41H;С��65����
	JB L3

	CMP AL,5BH;С��90���
	JB L1

	CMP AL,61H;С��97����
	JB L3
	
	CMP AL,7BH;С��122���
	JB L2

	CMP AL,7BH
	JNB L3

   L3:  LEA DX,STR4
	
	JMP EXIT
	
   L2:  LEA DX,STR3
	
	JMP EXIT

   L1:  LEA DX,STR2
	
	RET
	JUDGE ENDP

CODE ENDS
	END START 
