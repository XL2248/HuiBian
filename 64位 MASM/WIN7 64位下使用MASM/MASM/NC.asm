﻿DATA SEGMENT
	STR1 DB "the program design to add up some number$"
	STR2 DB "input the number by the system that doubule digit decimal(every two number separate by blank, stop by press 'q')$"
	STR3 DB 0AH,0DH,'$'
	RES DW 0
	RESA DB 16 DUP(?)
DATA ENDS
STACK SEGMENT
	DB 255 DUP(?)
STACK ENDS
CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,SS:STACK
START:
	MOV AX,DATA
	MOV DS,AX
	MOV DX,STACK
	MOV SS,DX
	
	MOV DX,OFFSET STR1
	CALL PRINT1
	MOV DX,OFFSET STR2
	CALL PRINT1
	
	CALL CALCULATE
	
	
	CALL OUTPUT
	
	MOV AH,4CH
	INT 21H
	
	PRINT1 PROC
	MOV AH,09H
	INT 21H
	LEA DX,STR3
	INT 21H
	RET
	PRINT1 ENDP
	
	
	;输入两位十进制数字并且计算
	;每两个数之间通过回车来间隔，最后通过q来停止输入
	CALCULATE PROC
	MOV AH,01H
	L1:
	INT 21H
	CMP AL,'Q'
	JE NEXT
	CMP AL,'q'
	JE NEXT
	CALL SCANF
	AND BX,00FF
	ADD RES,BX
	JMP L1
	NEXT:
	MOV DX,OFFSET STR3
	CALL PRINT1
	RET
	CALCULATE ENDP
	
	;输入一个两位二进制数字并且处理放入bl中
	SCANF PROC
	SUB AL,30H
	MOV BL,10
	MUL BL
	MOV BL,AL
	MOV AH,01H
	INT 21H
	SUB AL,30H
	ADD BL,AL
	MOV AH,01H
	INT 21H		;接收回车
	RET 
	SCANF ENDP
	
	OUTPUT PROC
	MOV AX,RES
	MOV SI,0
	MOV BX,10
	L13:MOV DX,0
	DIV BX
	ADD DL,30H
	MOV RESA[SI],DL
	INC SI
	CMP AX,0
	JNZ L13
	L14:DEC SI
	MOV DL,RESA[SI]
	MOV AH,2
	INT 21H
	CMP SI,0
	JNZ L14
	RET
  OUTPUT ENDP
	
CODE ENDS
END START

	
	
	
	
	
	