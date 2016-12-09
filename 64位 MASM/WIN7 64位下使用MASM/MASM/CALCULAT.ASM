DATA SEGMENT
	TIP1 DB "THIS PROGRAM IS A CALCULATOR.",0AH,0DH,"$"
	TIP2 DB "PLEASE INPUT THE FIRST NUMBER:$"
	TIP3 DB 0ah,0dh,"PLEASE INPUT ONE OF THE OPERATORS +,-,*,/:$"
	TIP4 DB 0ah,0dh,"PLEASE INPUT THE SECOND NUMBER:$"
	X DW ?
	Y DW ?
	RES Dw ?
	op db ?
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
	S:MOV AX,DATA
	MOV DS,AX
	LEA DX,TIP1
	MOV AH,9
	INT 21H
;MOV DL,0AH
;MOV AH,2
;INT 21H
;MOV DL,0DH
;INT 21H
	MOV DX,OFFSET TIP2
	MOV AH,9
	INT 21H
	mov ah,1	
	int 21h
	SUB AL,30H
	mov ah,0
	mov x,ax

	lea dx,tip3
	mov ah,9
	int 21h
	mov ah,1
	int 21h
	mov op,al
	
	lea dx,tip4
	mov ah,9
	int 21h
	mov ah,1
	int 21h
	SUB AL,30H
	mov ah,0
	mov y,ax

	cmp op,'+'
	jz l1
	cmp op,'-'
	jz l2
	cmp op,'*'
	jz l3
	cmp op,'/'
	jz l4

	L1:mov ax,x
	ADD ax,y
	mov res,ax
	JMP L5

	L2:MOV AX,X
	SUB AX,Y
	MOV RES,AX
	JMP L5

	L3:MOV AX,X
	MUL Y
	MOV RES,AX
	JMP L5

	L4:MOV AX,X
	DIV Y
	MOV RES,AX
	JMP L5

	L5:MOV DL,'='
	MOV AH,2
	INT 21H
	mov Ax,res
	MOV BL,10
	DIV BL
	MOV BL,AH
	MOV DL,AL	
	ADD DL,30H
	mov ah,2
	int 21h
	MOV DL,BL
	ADD DL,30H
	INT 21H

MOV AH,4CH
INT 21H
CODE ENDS
	END S