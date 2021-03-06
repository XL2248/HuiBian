;直角三角形

DATA	SEGMENT
	COL		DW	100
	ROW		DW	100
	LENGTH1    DW  	100
	COLOR	DB	1
DATA	ENDS

STACK1	SEGMENT	STACK
	DW	 20	DUP(0)
STACK1	ENDS
	
CODE  SEGMENT
	ASSUME	CS:CODE,DS:DATA,SS:STACK1

START:  
	MOV	AX,DATA
	MOV	DS,AX
	MOV	AH,0	;设置显示方式
	MOV	AL,11H
	INT	10H

	MOV	DX,ROW		;画右边竖线
	MOV	CX,COL
	ADD	cx,LENGTH1
	CALL	PROC_y
	
	MOV   	DX,ROW		 ;画下面横线
	MOV   	CX,COL
	ADD	DX,LENGTH1
	CALL   PROC_X
	
	MOV   	DX,0		 ;画斜线
	MOV   	CX,100
	ADD	DX,LENGTH1
	ADD CX,LENGTH1
	CALL   PROC_Z

	MOV	AH,1			 ;输入
  	INT	21H
	MOV	AH,0
	MOV	AL,3
	INT	10H
	MOV   	AH,4CH			 ;结束
	INT  	21H

     PROC_X   PROC	;画横线子程序
	MOV	BP,LENGTH1	
      	MOV	AL,COLOR	
	MOV	AH,0CH	
     LOP1:
	INT	10H
        INC 	CX   ;修改列号
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
        INC	DX;修改行号
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
	deC     CX  ;修改列号
	DEC	BP
	JNE	LOP3
	RET
     PROC_Z	ENDP

CODE	ENDS
	END	START


