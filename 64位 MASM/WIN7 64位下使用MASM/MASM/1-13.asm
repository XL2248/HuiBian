;等腰三角形
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
	MOV	AH,0	;设置显示方式
	MOV	AL,12H
	INT	10H

	MOV	DX,200		;画右边斜线
	MOV	CX,0
	CALL	PROC_Y
	
	MOV   	DX,200		 ;画下面横线
	MOV   	CX,0
	CALL   PROC_X
	
	MOV   	DX,100		 ;画左斜线
	MOV   	CX,100
	CALL   PROC_Z

	MOV	AH,1			 ;输入
  	INT	21H
	MOV	AH,0
	MOV	AL,3
	INT	10H
	MOV   	AH,4CH			 ;结束
	INT  	21H

     PROC_X   PROC	;画横线子程序
	MOV	BP,0C8H	
      	MOV	AL,COLOR	
	MOV	AH,0CH	
     LOP1:
	INT	10H
        INC 	CX     ;修改列号
	DEC	BP
	JNE	LOP1
	RET
     PROC_X   ENDP

     PROC_Y   PROC	;划竖线子程序
	MOV	BP,LENGTH1	
	MOV	AL,COLOR 
	MOV	AH,0CH  		
     LOP2:	
	INT	10H
        deC	DX;修改行号
	Inc     cx;修改列号
	DEC	BP
	JNE	LOP2
	RET
     PROC_Y   ENDP

     PROC_Z   PROC	;划斜线子程序
	MOV	BP,LENGTH1	
	MOV	AL,COLOR 
	MOV	AH,0CH  		
     LOP3:	
	INT	10H
        INC	DX      ;修改行号
	INC     CX      ;修改列号
	DEC	BP
	JNE	LOP3
	RET
     PROC_Z	ENDP

CODE	ENDS
	END	START


