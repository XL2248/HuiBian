;�Ƚ��ַ�������

data segment
  string1 db 50,0,50 dup(?)
  string2 db 50,0,50 dup(?)
  mess1 db 'please enter the first string:','$'
  mess2 db 'please enter the second string:','$'
  mess3 db 'The first is less than the second.',13,10,'$'
  mess4 db 'The first is bigger than the second.',13,10,'$'
  mess5 db 'match!',13,10,'$'
data ends
code segment
  assume cs:code,ds:data,es:data
start:
push ds
xor ax,ax     ;ax����
mov ax,data
mov ds,ax
mov es,ax     ;��ʼ��

;�����һ���ַ���
mov ax,data
mov ds,ax
mov dx,offset mess1
mov ah,09h
int 21h       ;���please enter the first string:
mov ax,data
mov ds,ax
mov dx,offset string1
mov ah,0ah
int 21h
call crlf

;����ڶ����ַ���
mov ax,data
mov ds,ax
mov dx,offset mess2
mov ah,09h
int 21h       ;���please enter the second string:
mov ax,data
mov ds,ax
mov dx,offset string2
mov ah,0ah
int 21h
call crlf

   lea si,string1
   lea di,string2
   add si,2
   add di,2

;�������ַ����Ƚ�
   again:
   mov bl,byte ptr [di]
   cmp [si],bl
   jl Little     ;ת��С�����
   jg greate     ;ת���������
   add si,1
   add di,1
   cmp byte ptr [si],0    
   jnz again
   
   
   ;���ַ������ڵ����   
call crlf
mov ax,data
mov ds,ax
mov dx,offset mess5
mov ah,09h
int 21h   
mov ah,4ch
int 21h

   ;С�ڵ����
Little:
call crlf
mov ax,data
mov ds,ax
mov dx,offset mess3
mov ah,09h
int 21h   
mov ah,4ch
int 21h
   
   ;���ڵ����
greate:
call crlf
mov ax,data
mov ds,ax
mov dx,offset mess4
mov ah,09h
int 21h
mov ah,4ch
int 21h

;��������ӳ����������� �س����� �õ�
crlf proc near
  mov dl,0dh
  mov ah,2
  int 21h
  
  mov dl,0ah
  mov ah,2
  int 21h
  ret
 crlf endp

code ends
end start         ;����