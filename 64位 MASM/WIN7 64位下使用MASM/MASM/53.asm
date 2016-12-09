;矩形
DATA	SEGMENT
	COLOR	        DB	1
DATA	ENDS
CODE  SEGMENT
	ASSUME	CS:CODE,DS:DATA

START:  
	MOV	AX,DATA
	MOV	DS,AX
	MOV	AH,0	        ;设置显示方式
	MOV	AL,12H
	INT	10H

        MOV   	DX,100		 ;画上面横线
	MOV   	CX,100
	CALL   PROC_X
	
	MOV   	DX,200		 ;画下面横线
	MOV   	CX,100
	CALL   PROC_X

        MOV   	DX,100		 ;画左边竖线
	MOV   	CX,100
	CALL   PROC_Y
	
	MOV   	DX,100		 ;画右边竖线
	MOV   	CX,300
	CALL   PROC_Y

	MOV	AH,1			 ;输入
  	INT	21H
	MOV	AH,0
	MOV	AL,3
	INT	10H
	MOV   	AH,4CH			 ;结束
	INT  	21H

     PROC_X   PROC	                 ;画横线子程序
	MOV	BP,0C8H	
      	MOV	AL,COLOR	
	MOV	AH,0CH	
     LOP1:
	INT	10H
        INC 	CX                       ;修改列号
	DEC	BP
	JNE	LOP1
	RET
     PROC_X   ENDP

     PROC_Y   PROC	                  ;划竖线子程序
	MOV	BP,100	
	MOV	AL,COLOR 
	MOV	AH,0CH  		
     LOP2:	
	INT	10H
        INC	DX                         ;修改行号
	DEC	BP
	JNE	LOP2
	RET
     PROC_Y   ENDP

CODE	ENDS
	END	START


