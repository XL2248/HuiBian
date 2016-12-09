DATA SEGMENT
          STR DB"HELLO WORLD$"
DATA ENDS
CODE SEGMENT
          ASSUME CS:CODE,DS:DATA
          S:MOV AX,DATA
          MOV DS,AX
          MOV AH,9
          MOV DX,OFFSET STR
          INT 21H
          MOV AH,4CH
          INT 21H
CODE ENDS
          END S