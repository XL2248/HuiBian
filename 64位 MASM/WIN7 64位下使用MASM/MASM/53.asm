;����
DATA	SEGMENT
	COLOR	        DB	1
DATA	ENDS
CODE  SEGMENT
	ASSUME	CS:CODE,DS:DATA

START:  
	MOV	AX,DATA
	MOV	DS,AX
	MOV	AH,0	        ;������ʾ��ʽ
	MOV	AL,12H
	INT	10H

        MOV   	DX,100		 ;���������
	MOV   	CX,100
	CALL   PROC_X
	
	MOV   	DX,200		 ;���������
	MOV   	CX,100
	CALL   PROC_X

        MOV   	DX,100		 ;���������
	MOV   	CX,100
	CALL   PROC_Y
	
	MOV   	DX,100		 ;���ұ�����
	MOV   	CX,300
	CALL   PROC_Y

	MOV	AH,1			 ;����
  	INT	21H
	MOV	AH,0
	MOV	AL,3
	INT	10H
	MOV   	AH,4CH			 ;����
	INT  	21H

     PROC_X   PROC	                 ;�������ӳ���
	MOV	BP,0C8H	
      	MOV	AL,COLOR	
	MOV	AH,0CH	
     LOP1:
	INT	10H
        INC 	CX                       ;�޸��к�
	DEC	BP
	JNE	LOP1
	RET
     PROC_X   ENDP

     PROC_Y   PROC	                  ;�������ӳ���
	MOV	BP,100	
	MOV	AL,COLOR 
	MOV	AH,0CH  		
     LOP2:	
	INT	10H
        INC	DX                         ;�޸��к�
	DEC	BP
	JNE	LOP2
	RET
     PROC_Y   ENDP

CODE	ENDS
	END	START


