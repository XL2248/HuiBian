data segment
	u db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,5,0,0,0,0,0,0,0,0,0,0,0
	  db 0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,6,5,0,0,0,0,0,0,0,0,0,0,0
	  db 0,0,0,0,0,0,0,0,0,0,0,0,6,6,6,6,5,0,0,0,0,0,0,0,0,0,0,0
	  db 0,0,0,0,0,0,0,0,0,0,0,6,6,6,6,6,5,0,0,0,0,0,0,0,0,0,0,0
	  db 0,0,0,0,0,0,0,0,0,0,6,6,6,6,6,6,5,0,0,0,0,0,0,0,0,0,0,0
	  db 0,0,0,0,0,0,0,0,0,6,6,6,6,6,6,6,5,0,0,0,0,0,0,0,0,0,0,0
	  db 0,0,0,0,0,0,0,0,6,6,6,6,6,6,6,6,5,0,0,0,0,0,0,0,8,8,8,8
	  db 8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0,8,8,8,8,8,0
	  db 0,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,5,0,0,0,8,8,8,8,8,8,0,0
	  db 0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0
	  db 0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0
	  db 0,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,0,0,0,0
	  db 0,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,0,0
	  db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	  db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	u0 db 1 dup(0)
data ends
stack1 segment para stack
	dw 20h dup(0)
stack1 ends
code segment
	assume cs:code,ds:data,ss:stack1
  start:mov ax,cs
	mov ds,ax
	push ax
	mov ax,30h
	int 10h
	mov cx,200 
	mov bx,0
ll_1:MOV DX,0
LL_0:PUSH DX
	MOV AX,320
	MUL BX
	POP BX
	POP DX
	ADD AX,DX
	MOV DI,AX
	MOV AX,0A000H
	MOV ES,AX
	CMP BL,100
	JA COLOR0
	MOV AL,255
	JMP COLOR1
COLOR0:MOV AL,254
COLOR1:MOV ES:[DI],AL
	INC DX
	MOV AX,DX
	CMP AX,320
	JNZ LL_0
	INC BX
	LOOP LL_1
	MOV CX,0
LL_121:MOV DX,0
LL_11:MOV BX,90
LL_01:PUSH DX
	PUSH BX
	MOV AX,320
	MUL BX
	POP BX
	POP DX
	ADD AX,DX
	ADD AX,CX
	MOV SI,AX
	MOV DI,AX
	MOV AX,0A000H
	MOV DX,AX
	MOV ES,AX
	MOV AL,DS:[SI]
	PUSH AX
	MOV AX,BX
	SUB AX,90
	PUSH BX
	MOV BX,28
	PUSH DX
	MUL BX
	POP DX
	ADD AX,DX
	MOV SI,OFFSET U
	ADD AX,SI
	MOV SI,AX
	MOV AX,DATA
	MOV DS,AX
	POP BX
	POP AX
	MOV AH,AL
	MOV AL,DS:[SI]
	XOR AL,AH
	MOV ES:[DI],AL
	INC BX
	CMP BL,105
	JNZ LL_01
	INC DX
	CMP DX,28
	JNZ LL_11
	MOV AX,DATA
	MOV DS,AX
	MOV SI,OFFSET U0
	MOV AL,DS:[SI]
	CMP AL,0
	JNZ N_DL
	MOV AL,1
	MOV DS:[SI],AL
	CALL DALY
	JMP LL_120
N_DL:MOV AL,0
	MOV DS:[SI],AL
	INC CX
	CMP CX,292
	JNZ LL_121
	JMP LL_18
LL_120:JMP LL_121
LL_18:MOV AX,1
	INT 16H
	MOV AX,07H
	INT 10H
	MOV AH,4CH
	INT 21H
DALY PROC
	PUSH CX
	PUSH BX
	NOP
	NOP
	MOV CX,0FFFFH
DD_2:MOV BX,3FH
DD_1:DEC BX
	CMP BX,0
	JNZ DD_1
	LOOP DD_2
	POP BX
	POP CX
	RET
DALY ENDP
CODE ENDS
END START