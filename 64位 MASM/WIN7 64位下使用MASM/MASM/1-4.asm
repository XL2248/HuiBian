;以十六进制输出
CODE SEGMENT
	ASSUME CS:CODE
    START:MOV BX,4534H
	MOV CX,4
    NEXT:PUSH CX
	MOV CL,4
	ROL BX,CL
	MOV DL,BL
	AND DL,0FH
	CMP DL,0AH
	JL DISP
	ADD DL,7
    DISP:ADD DL,30H
	MOV AH,2
	INT 21H
	POP CX
    LOOP NEXT
	MOV AH,4CH
	INT 21H
CODE ENDS
END START