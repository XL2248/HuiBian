data segment
a db 00h
x db "000"
y db "000",0Dh, 0Ah, "$"
data ends
code segment
assume cs:code, ds:data
main:
   mov ax, data
   mov ds, ax
   mov ax, 0B800h
   mov es, ax
   xor di, di
   mov ax , 0003h
   int 10h
   mov al, 0h
   mov [a], al
   cld
again:
   call change
   call change1   
   mov ah, 04h
   mov al, x[0]
   stosw
   mov ah, 02h
   mov al, x[1]
   stosw
   mov al, x[2]
   stosw
   mov ah, 07h
   mov al, y[0]
   stosw
   mov al, y[1]
   stosw
   mov al, y[2]
   stosw
   mov al, y[3]
   stosw
   call next
   mov cl, [a]
   inc cl
   mov [a], cl
   cmp cl, 0h
   jne again
   jmp over
over:
  mov dh, 24
  mov dl, 79
  mov ah, 2
  int 10h
  mov ah, 0
  int 16h
  mov ah, 4Ch
  int 21h
next:
  cmp di, 3840
  ja next1
  add di, 146
  jmp done
next1:
  sub di, 3840
change:
   mov al, [a]
   mov x[0], al
   mov cl, 4
   shr al, cl
   mov ah, al
   call hex
   mov x[1], al
   mov al, [a]
   and al, 0Fh
   call hex
   mov x[2], al
   mov al, [a]
   ret
hex:
   cmp al, 10
   jb add0
   sub al, 10
   add al, 'A'
   jmp done
add0:
   add al, '0'
done:
   ret
change1:
   mov al, [a]
   mov ah, 0
   mov bl, 100
   div bl   
   add al, 30h
   mov y[0], al
   mov al, ah
   mov ah, 0
   mov bl, 10
   div bl
   add al, 30h
   mov y[1], al
   add ah, 30h
   mov y[2], ah
   ret
code ends
end main

 

 

 

 

���˻�����Ի���ѧϰ�ܽ᣺

 

ѧϰ������ѧϰ���µĲ��ϴ��콨������಻��C��C++һ�������Ѿ�����������ģ�ͺ����⣬������Ծ���ɳ�ӣ������޾����ڴ��ַ���Ϳ�������Щ��ַ�Ϸ�Щʲô�Լ���ΰڷš���ʵ�κ�һ������Ա��Ӧ�öԻ��Ļ�������ѧϰ�˽⣬��������Զ��֪��ԭ����������ڴ��ǿ�����ô���桱��