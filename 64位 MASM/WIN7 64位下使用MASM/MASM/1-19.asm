 ;将十六进制数的ASCII码转换为十进制数(汇编语言
DATA  SEGMENT               ;定义源数据段
      STRING  DB        'Input:','$'
         MSR  DW        000CH
         MDR  DB        5 DUP(?),'$'
        DATA  ENDS
        CODE  SEGMENT               ;定义代码段
              ASSUME    CS:CODE, DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       BX,OFFSET MDR
              MOV       SI, 5
              MOV       AX,[MSR]    ;将数据000CH保存到AX当中
      NEXT1:  DEC       SI
              MOV       DX,0
              MOV       CX,0AH
              DIV       CX
              ADD       DL,30H
              MOV       [BX+SI],DL
              CMP       AX,0
              JNE       NEXT1
              CMP       SI,0        ;判断SI是否为零，为零则表明五位十进制数的每一位都不为零，否则应给前面为零的位上补上零
              JE        NEXT3
      NEXT2:  DEC       SI
              MOV       AL,30H
              MOV       [BX+SI],AL
              CMP       SI,0
              JNE       NEXT2
      NEXT3:  MOV       DX,OFFSET MDR
              MOV       AH,09H
              INT       21H
              MOV       AX,4C00H
              INT       21H
        CODE  ENDS
              END       START