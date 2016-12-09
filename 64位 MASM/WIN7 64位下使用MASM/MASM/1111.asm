DATA SEGMENT  ;多字节整数加减法
    X DB 12H,34H,56H,78H       ;X为12345678
    Y DB 90H,0ABH,0CDH,0EFH    ;Y为90abcdef
    SUM DB ?,?,?,?,? ;存放加法结果
    JIFA DB ?,?,?,?  ;存放减法结果
DATA ENDS
STACK SEGMENT
       DB 20H DUP(?)
STACK ENDS
CODE SEGMENT
     ASSUME DS:DATA,CS:CODE
        START: MOV AX,DATA
	       MOV DS,AX
	       CLC      ;清除进位标志位
	       MOV SI,3  ;x最后一字节存入SI
	       MOV DI,7  ;Y最后一字节存入DI
	       MOV BX,0CH ;SUM最后一字节存入BX
	       MOV CX,4   ;指定加法循环次数
	      L1: MOV DL,[DI]
	          ADC DL,[SI]
	          MOV [BX],DL
		  DEC SI
		  DEC DI
		  DEC BX
	       LOOP L1   ;加法循环体
	          JC L2
		  JMP L3
		  L2:MOV DH,1
		     MOV [BX],DH
		  L3:MOV CX,5
		  L4: MOV AL,[BX]
	  PUSH CX
          MOV CL,4
	  SHR AL,CL
	  CMP AL,9H
	  JBE L5
	  ADD AL,7

     L5:  ADD AL,30H
          MOV DL,AL
	  MOV AH,02H
	  INT 21H       ;输出高位结果（16进制）
          MOV DL,[BX]
          AND DL,0FH
          CMP DL,9
          JBE L6
          ADD DL,7
     L6:  ADD DL,30H
          MOV AH,2
	  INT 21H     ;输出低位结果（16进制）
	  POP CX
	  INC BX
	  LOOP L4     ;结果输出循环体
	 MOV DL,0AH
	 MOV AH,02H
	 INT 21H
	 MOV DL,0DH
	 MOV AH,02H
	 INT 21H   ;输出回车换行
;减法实现代码
               MOV SI,3  ;X最后一字节存入SI
	       MOV DI,7  ;Y最后一字节存入DI
	       MOV BX,10H ;JIANFA最后一字节存入BX
	       CLC
	       MOV CX,4
      L10: MOV DL,[DI]
	   SBB DL,[SI]
	   MOV [BX],DL
           DEC SI
	   DEC DI
           DEC BX
       LOOP L10   ;减法循环体
	   MOV CX,4
           INC BX
      L40:MOV AL,[BX]
	  PUSH CX
          MOV CL,4
	  SHR AL,CL
	  CMP AL,9H
	  JBE L50
	  ADD AL,7
    L50:  ADD AL,30H
          MOV DL,AL
	  MOV AH,02H
	  INT 21H       ;输出高位结果（16进制）
	  MOV DL,[BX]
          AND DL,0FH
          CMP DL,9
          JBE L60
          ADD DL,7
     L60: ADD DL,30H
          MOV AH,2
	  INT 21H     ;输出低位结果（16进制）
	  POP CX
	  INC BX
	  LOOP L40     ;结果输出循环体
	  MOV AH,4CH
          INT 21H  ;结束程序
CODE ENDS
     END START