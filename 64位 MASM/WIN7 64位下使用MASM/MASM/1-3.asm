DATA SEGMENT ;把bx中的二进制数以十六进制的形式显示在屏幕上
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE
START:MOV BX,1234H         ;bx中存放需要显示的值
	MOV CX,4           ;设置循环次数
NEXT:PUSH CX
	MOV CL,4
	ROL BX,CL          ;循环左移，将高位移至低位
	MOV DL,BL          
	AND DL,0FH         ;取出低位的值
	CMP DL,0AH         ;判断其值是在0~9之间，还是在A~F之间
	JL DISP
	ADD DL,7
DISP:ADD DL,30H            ;做加法
	MOV AH,2           ;显示
	INT 21H
	POP CX
	LOOP NEXT
	MOV AH,4CH 
	INT 21H
CODE ENDS 
	END START