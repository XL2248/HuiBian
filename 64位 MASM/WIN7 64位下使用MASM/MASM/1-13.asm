;����������
DATA	SEGMENT
	LENGTH1 DW  	100
	COLOR	DB	12h
DATA	ENDS

STACK	SEGMENT	
	DW      20	DUP(0)
STACK	ENDS
	
CODE  SEGMENT
	ASSUME	CS:CODE,DS:DATA,SS:STACK

START:  
	MOV	AX,DATA
	MOV	DS,AX
	MOV	AH,0	;������ʾ��ʽ
	MOV	AL,12H
	INT	10H

	MOV	DX,200		;���ұ�б��
	MOV	CX,0
	CALL	PROC_Y
	
	MOV   	DX,200		 ;���������
	MOV   	CX,0
	CALL   PROC_X
	
	MOV   	DX,100		 ;����б��
	MOV   	CX,100
	CALL   PROC_Z

	MOV	AH,1			 ;����
  	INT	21H
	MOV	AH,0
	MOV	AL,3
	INT	10H
	MOV   	AH,4CH			 ;����
	INT  	21H

     PROC_X   PROC	;�������ӳ���
	MOV	BP,0C8H	
      	MOV	AL,COLOR	
	MOV	AH,0CH	
     LOP1:
	INT	10H
        INC 	CX     ;�޸��к�
	DEC	BP
	JNE	LOP1
	RET
     PROC_X   ENDP

     PROC_Y   PROC	;�������ӳ���
	MOV	BP,LENGTH1	
	MOV	AL,COLOR 
	MOV	AH,0CH  		
     LOP2:	
	INT	10H
        deC	DX;�޸��к�
	Inc     cx;�޸��к�
	DEC	BP
	JNE	LOP2
	RET
     PROC_Y   ENDP

     PROC_Z   PROC	;��б���ӳ���
	MOV	BP,LENGTH1	
	MOV	AL,COLOR 
	MOV	AH,0CH  		
     LOP3:	
	INT	10H
        INC	DX      ;�޸��к�
	INC     CX      ;�޸��к�
	DEC	BP
	JNE	LOP3
	RET
     PROC_Z	ENDP

CODE	ENDS
	END	START


