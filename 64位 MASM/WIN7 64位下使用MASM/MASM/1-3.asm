DATA SEGMENT ;��bx�еĶ���������ʮ�����Ƶ���ʽ��ʾ����Ļ��
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE
START:MOV BX,1234H         ;bx�д����Ҫ��ʾ��ֵ
	MOV CX,4           ;����ѭ������
NEXT:PUSH CX
	MOV CL,4
	ROL BX,CL          ;ѭ�����ƣ�����λ������λ
	MOV DL,BL          
	AND DL,0FH         ;ȡ����λ��ֵ
	CMP DL,0AH         ;�ж���ֵ����0~9֮�䣬������A~F֮��
	JL DISP
	ADD DL,7
DISP:ADD DL,30H            ;���ӷ�
	MOV AH,2           ;��ʾ
	INT 21H
	POP CX
	LOOP NEXT
	MOV AH,4CH 
	INT 21H
CODE ENDS 
	END START