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
   
CMP AL,39H           ;进行比较    ASCII码57（39H）对应9
JBE A                ;<=时转移A
SUB AL,07H

A:      
SUB AL,30H          ;A
MOV X,AL
MOV AH,1
INT 21H

CMP AL,39H           ;进行比较    ASCII码57（39H）对应9
JBE B                ;<=时转移B
SUB AL,07H

B:	
SUB AL,30H          ;B
MOV Y,AL
MOV AH,1
INT 21H

AP:CMP AL,41H         ;判断是否大于A的ASCII码65   <=
JNE BPP               ; ZF＝0,转至标号处执行
XOR AL,AL             ;清空AL
MOV AL,X
ADD AL,Y              ;X+Y
MOV W,AL              ;保存结果
JMP OUT_PUT

BPP:CMP AL,42H        ;B
JNE CP
XOR AL,AL
MOV AL,X
SUB AL,Y               ;X-Y
MOV W,AL
CMP AL,0                ;判断是否大于0
JG OUT_PUT             ;大于=0转到


NEG AL                  ;为负求补
MOV W,AL
JMP OUT_PUT


CP:CMP AL,43H           ;C
JNE DP
XOR AL,AL
MOV AL,X
MUL Y                    ;X*Y
MOV W,AL                 
JMP OUT_PUT

DP:XOR AX,AX             ;清空AX
MOV AL,X
DIV Y                    ;X/Y
MOV W,AL

OUT_PUT:MOV DL,AL
MOV CL,4
SHR DL,CL                   ;右移位
CMP DL,9
JNE ONE                     ;ZF＝0,转至标号处执行
ADD DL,07H

ONE:ADD DL,30H
MOV AH,02H
INT 21H
MOV DL,W
AND DL,0FH
CMP DL,9
JNA TWO                     ;低于等于/不高于时转移
ADD DL,07H

TWO:ADD DL,30H
MOV AH,02H
INT 21H


MOV AH,4CH
INT 21H
CODE ENDS
END START


