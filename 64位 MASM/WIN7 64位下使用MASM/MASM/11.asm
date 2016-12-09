DATA    SEGMENT
BUF1    DW  9348H
BUF2    DW  4 DUP(0),0AH,0DH,'$'
BUF3    DW  4 DUP(0),'$'
DATA    ENDS
CODE    SEGMENT
   ASSUME  CS:CODE,DS:DATA
BEGIN:MOV    AX,DATA
        MOV    DS,AX
        MOV    AX,BUF1
        ADD    AX,0
        JS       NEXT
        MOV    BUF2,AX
        MOV    BUF3,AX
        JMP     EEE
 NEXT:AND    AX,7FFFH
        NOT     AX
        MOV    BUF2,AX
        INC     AX
MOV    BUF3,AX
  EEE:  MOV    CX,0004H
        MOV    DI,OFFSET BUF2
        MOV    DX,[DI]
        ADD     DI,03
BBB:MOV    AX,DX
        AND    AX,000FH
        CMP    AL,0AH
        JB      QQQ
        ADD    AL,07H
QQQ:ADD    AL,30H
  MOV    [DI],AL
  DEC     DI
PUSH   CX
  MOV    CL,04H
  SHR     DX,CL
  POP     CX
  LOOP    BBB
  MOV    CX,0004H
  MOV    SI, OFFSET  BUF3
  MOV    DX,[SI]
  ADD    SI,03H
CCC: MOV    AX,DX
 AND    AX,000FH
 CMP    AL,0AH
 JB      DDD
      ADD    AL,07H
DDD:ADD    AL,30H
      MOV    [SI],AL
      DEC    SI
      PUSH   CX
      MOV   CL,04H
      SHR    DX, CL
      POP    CX
      LOOP  CCC
      MOV   DX,OFFSET  BUF2
  MOV   AH,09H
  INT    21H
  MOV    DX,OFFSET  BUF3
  MOV    AH,09H
  INT    21H
  MOV    AH,4CH
  INT    21H
 CODE  ENDS
  END    BEGIN
