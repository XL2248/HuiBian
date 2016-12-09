DATA SEGMENT
     SJZS DB 28H,?,30H DUP(?)    ;存放键盘输入的十进制数
     P    DB ?                   ;存放要转换成的进制数
     NUM  DB ?                   ;存放从键盘输入的字符数
     SHI  DB ?,?,?,?             ;存放真正的十进制数
     TEN  DB 0AH
     SUM  DW ?
     YUS  DB 20H DUP(?)          ;存放余数
DATA ENDS
STACK SEGMENT
       DB 20H DUP(?)
STACK ENDS
CODE SEGMENT
     ASSUME CS:CODE,DS:DATA,SS:STACK
     START:MOV AX,DATA
           MOV DS,AX
	   CALL JINZHI
	   MOV AH,4CH
	   INT 21H       
JINZHI PROC                ;进制转换子程序   
	   LEA DX,SJZS
	   MOV AH,0AH
	   INT 21H      ;从键盘读入数字，存入SJZS
	  MOV DL,0AH
          MOV AH,02H
	  INT 21H
	  MOV DL,0DH
	  MOV AH,02H
	  INT 21H   ;输出回车换行
	  MOV AH,1
	  INT 21H
	  MOV P,AL  ;从键盘读入一个字符存入P
	  MOV DL,0AH
          MOV AH,02H
	  INT 21H
	  MOV DL,0DH
	  MOV AH,02H
	  INT 21H   ;输出回车换行
	  LEA SI,SJZS
	  INC SI
	  MOV BL,[SI]
	  MOV NUM,BL
	  INC SI
	  MOV CX,0
	  MOV CX,NUM
       L1:MOV BL,[SI]
	  MOV BH,30H
	  SUB BL,BH
	  MOV BH,0
	  MOV [SI],BL
	  INC SI
	  LOOP L1    ;将输入的字符串转化为数字
	  MOV BL,30H
	  SUB P,BL   ;将P转化成数字
          LEA SI,SJZS
	  INC SI
	  INC SI
	  MOV AL,[SI]
	  MOV BL,NUM
	  DEC BL
	  MOV CX,0
	  MOV CL,BL
      L2: MUL TEN
	  INC SI
	  MOV DX,AX
	  ADD DX,[SI]
	  MOV SUM,DX
	  MOV AL,SUM
	  LOOP L2     ;此循环完成把字符转化数值存于AX中
	  MOV SUM,AX
	  LEA DI,YUS
	  MOV AX,SUM
       L3:DIV P
	  MOV [DI],AH
	  INC DI
	  MOV AH,0
	  CMP AL,0
	  JNA L4
	  JMP L3
       L4:DEC DI
	  MOV BH,30H
	  ADD [DI],BH
	  MOV BH,0
	  MOV DL,[DI]
	  MOV AH,2
	  INT 21H
	  MOV CX,OFFSET YUS
	  CMP DI,CX
	  JBE L5
	  JMP L4
       L5:RET
JINZHI ENDP
  CODE ENDS
       END START