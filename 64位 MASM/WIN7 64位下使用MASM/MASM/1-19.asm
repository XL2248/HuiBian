 ;��ʮ����������ASCII��ת��Ϊʮ������(�������
DATA  SEGMENT               ;����Դ���ݶ�
      STRING  DB        'Input:','$'
         MSR  DW        000CH
         MDR  DB        5 DUP(?),'$'
        DATA  ENDS
        CODE  SEGMENT               ;��������
              ASSUME    CS:CODE, DS:DATA
      START:  MOV       AX,DATA
              MOV       DS,AX
              MOV       BX,OFFSET MDR
              MOV       SI, 5
              MOV       AX,[MSR]    ;������000CH���浽AX����
      NEXT1:  DEC       SI
              MOV       DX,0
              MOV       CX,0AH
              DIV       CX
              ADD       DL,30H
              MOV       [BX+SI],DL
              CMP       AX,0
              JNE       NEXT1
              CMP       SI,0        ;�ж�SI�Ƿ�Ϊ�㣬Ϊ���������λʮ��������ÿһλ����Ϊ�㣬����Ӧ��ǰ��Ϊ���λ�ϲ�����
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