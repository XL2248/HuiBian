DATA SEGMENT
        
X DB ?
Y DB ?
Z DB ?
W DB ?
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA

START:MOV AX,DATA
MOV DS,AX
XOR AX,AX
MOV AH,1
INT 21H
   
CMP AL,39H           ;���бȽ�    ASCII��57��39H����Ӧ9
JBE A                ;<=ʱת��A
SUB AL,07H

A:      
SUB AL,30H          ;A
MOV X,AL
MOV AH,1
INT 21H

CMP AL,39H           ;���бȽ�    ASCII��57��39H����Ӧ9
JBE B                ;<=ʱת��B
SUB AL,07H

B:	
SUB AL,30H          ;B
MOV Y,AL
MOV AH,1
INT 21H

AP:CMP AL,41H         ;�ж��Ƿ����A��ASCII��65   <=
JNE BPP               ; ZF��0,ת����Ŵ�ִ��
XOR AL,AL             ;���AL
MOV AL,X
ADD AL,Y              ;X+Y
MOV W,AL              ;������
JMP OUT_PUT

BPP:CMP AL,42H        ;B
JNE CP
XOR AL,AL
MOV AL,X
SUB AL,Y               ;X-Y
MOV W,AL
CMP AL,0                ;�ж��Ƿ����0
JG OUT_PUT             ;����=0ת��


NEG AL                  ;Ϊ����
MOV W,AL
JMP OUT_PUT


CP:CMP AL,43H           ;C
JNE DP
XOR AL,AL
MOV AL,X
MUL Y                    ;X*Y
MOV W,AL                 
JMP OUT_PUT

DP:XOR AX,AX             ;���AX
MOV AL,X
DIV Y                    ;X/Y
MOV W,AL

OUT_PUT:MOV DL,AL
MOV CL,4
SHR DL,CL                   ;����λ
CMP DL,9
JNE ONE                     ;ZF��0,ת����Ŵ�ִ��
ADD DL,07H

ONE:ADD DL,30H
MOV AH,02H
INT 21H
MOV DL,W
AND DL,0FH
CMP DL,9
JNA TWO                     ;���ڵ���/������ʱת��
ADD DL,07H

TWO:ADD DL,30H
MOV AH,02H
INT 21H


MOV AH,4CH
INT 21H
CODE ENDS
END START


