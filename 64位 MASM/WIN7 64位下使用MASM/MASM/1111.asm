DATA SEGMENT  ;���ֽ������Ӽ���
    X DB 12H,34H,56H,78H       ;XΪ12345678
    Y DB 90H,0ABH,0CDH,0EFH    ;YΪ90abcdef
    SUM DB ?,?,?,?,? ;��żӷ����
    JIFA DB ?,?,?,?  ;��ż������
DATA ENDS
STACK SEGMENT
       DB 20H DUP(?)
STACK ENDS
CODE SEGMENT
     ASSUME DS:DATA,CS:CODE
        START: MOV AX,DATA
	       MOV DS,AX
	       CLC      ;�����λ��־λ
	       MOV SI,3  ;x���һ�ֽڴ���SI
	       MOV DI,7  ;Y���һ�ֽڴ���DI
	       MOV BX,0CH ;SUM���һ�ֽڴ���BX
	       MOV CX,4   ;ָ���ӷ�ѭ������
	      L1: MOV DL,[DI]
	          ADC DL,[SI]
	          MOV [BX],DL
		  DEC SI
		  DEC DI
		  DEC BX
	       LOOP L1   ;�ӷ�ѭ����
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
	  INT 21H       ;�����λ�����16���ƣ�
          MOV DL,[BX]
          AND DL,0FH
          CMP DL,9
          JBE L6
          ADD DL,7
     L6:  ADD DL,30H
          MOV AH,2
	  INT 21H     ;�����λ�����16���ƣ�
	  POP CX
	  INC BX
	  LOOP L4     ;������ѭ����
	 MOV DL,0AH
	 MOV AH,02H
	 INT 21H
	 MOV DL,0DH
	 MOV AH,02H
	 INT 21H   ;����س�����
;����ʵ�ִ���
               MOV SI,3  ;X���һ�ֽڴ���SI
	       MOV DI,7  ;Y���һ�ֽڴ���DI
	       MOV BX,10H ;JIANFA���һ�ֽڴ���BX
	       CLC
	       MOV CX,4
      L10: MOV DL,[DI]
	   SBB DL,[SI]
	   MOV [BX],DL
           DEC SI
	   DEC DI
           DEC BX
       LOOP L10   ;����ѭ����
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
	  INT 21H       ;�����λ�����16���ƣ�
	  MOV DL,[BX]
          AND DL,0FH
          CMP DL,9
          JBE L60
          ADD DL,7
     L60: ADD DL,30H
          MOV AH,2
	  INT 21H     ;�����λ�����16���ƣ�
	  POP CX
	  INC BX
	  LOOP L40     ;������ѭ����
	  MOV AH,4CH
          INT 21H  ;��������
CODE ENDS
     END START