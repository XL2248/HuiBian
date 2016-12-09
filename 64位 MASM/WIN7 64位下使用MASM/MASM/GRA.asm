DATA SEGMENT
	STR DB "THIS IS A TRANGLE$"
	SAN DW 25,25,25,125,125,125
	COLOR DB 1
	LEN DB 100
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
	A:
		MOV AX,DATA
		MOV DS,AX
		
		MOV AH,12H
		MOV AL,12H
		INT 10H
		
		MOV DX,SAN[0]
		MOV CX,SAN[2]
		CALL PRO_ROW
		
		MOV DX,SAN[4]
		MOV CX,SAN[6]
		CALL PRO_COL
		
		MOV DX,SAN[0]
		MOV CX,SAN[2]
		CALL PRO_DIA	
		
		MOV AH,01H
		INT 21H
		MOV AH,4CH
		INT 21H

			
		
		
		
		;画横线，长度为length，cx为列号，dx为行号，cx++循环
		PRO_ROW PROC
		MOV BP,LEN
		LOP1:
		MOV BH,0
		INC CX
		MOV AL,COLOR
		MOV AH,0CH
		INT 10H
		DEC BP
		JNE LOP1
		RET
		PRO_ROW ENDP
		
		;画竖线，长度为length，dx++循环
		PRO_COL PROC
		MOV BP,LEN
		LOP2:
		MOV BH,0
		INC DX
		MOV AL,COLOR
		MOV AH,0CH
		INT 10H
		DEC BP
		JNE LOP2
		RET
		PRO_COL ENDP
		
		;画斜线,cx++，dx++
		PRO_DIA PROC
		MOV BP,LEN
		LOP3:
		MOV BH,0
		INC CX
		INC DX 
		MOV AL,COLOR
		MOV AH,0CH
		INT 10H
		DEC BP
		JNE LOP3
		RET
		PRO_DIA ENDP
		
		CODE ENDS
	END A
	
		
		
		