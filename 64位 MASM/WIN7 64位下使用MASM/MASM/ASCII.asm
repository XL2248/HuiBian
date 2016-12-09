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

 

 

 

 

个人汇编语言基础学习总结：

 

学习汇编就像学习用新的材料创造建筑，汇编不像C，C++一类语言已经建立完整的模型函数库，汇编语言就像沙子，给你无尽的内存地址，就看你在这些地址上放些什么以及如何摆放。其实任何一个程序员都应该对汇编的基础语言学习了解，否则他永远不知道原来计算机的内存是可以这么“玩”的