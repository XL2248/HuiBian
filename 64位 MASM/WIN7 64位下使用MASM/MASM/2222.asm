DATA SEGMENT
     SJZS DB 28H,?,30H DUP(?)    ;��ż��������ʮ������
     P    DB ?                   ;���Ҫת���ɵĽ�����
     NUM  DB ?                   ;��ŴӼ���������ַ���
     SHI  DB ?,?,?,?             ;���������ʮ������
     TEN  DB 0AH
     SUM  DW ?
     YUS  DB 20H DUP(?)          ;�������
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
JINZHI PROC                ;����ת���ӳ���   
	   LEA DX,SJZS
	   MOV AH,0AH
	   INT 21H      ;�Ӽ��̶������֣�����SJZS
	  MOV DL,0AH
          MOV AH,02H
	  INT 21H
	  MOV DL,0DH
	  MOV AH,02H
	  INT 21H   ;����س�����
	  MOV AH,1
	  INT 21H
	  MOV P,AL  ;�Ӽ��̶���һ���ַ�����P
	  MOV DL,0AH
          MOV AH,02H
	  INT 21H
	  MOV DL,0DH
	  MOV AH,02H
	  INT 21H   ;����س�����
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
	  LOOP L1    ;��������ַ���ת��Ϊ����
	  MOV BL,30H
	  SUB P,BL   ;��Pת��������
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
	  LOOP L2     ;��ѭ����ɰ��ַ�ת����ֵ����AX��
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