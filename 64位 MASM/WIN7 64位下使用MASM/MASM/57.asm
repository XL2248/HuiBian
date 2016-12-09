data segment
     n db 0    ;格数
     a db 0    ;第一行格数
     b db 0    ;第二行格数 
     a_x db 0
     b_x db 0
     y db 100
     str1 db 'Input the number of squares:',0ah,0dh,'$' 
     str2 db 'Error,Input again!',0ah,0dh,'$'
data ends 

stack segment
     db 20 dup(0)
stack ends

code segment 
     assume cs:code,ds:data,ss:stack 
start: 
    mov ax,data
    mov ds,ax
    mov dx,offset str1
    mov ah,09h
    int 21h
lop: 
    mov ah,01h       ;输入格数n
    int 21h 
    cmp al,'0'
    jb error
    cmp al,'9'
    ja error    
    mov n,al 
    jmp next1
error:
    mov dx,offset str2
    mov ah,09h
    int 21h
    jmp lop
next1: 
    mov al,n         ;计算每行格数
    mov ah,0 
    mov bh,2
    div bh
    mov a,al
    sub n,al
    mov al,n
    mov b,al   

    mov ax,640       ;计算第一行每格宽度

    mov bh,a
    div bh
    mov a_x,al       
                   
    mov ax,640      ;计算第二行每格宽度

    mov bh,b
    div bh
    mov b_x,al
    mov ah,0         ;设置显示方式：图形16色，640*480
    mov al,12h
    int 10h            
    
    mov bl,a_x 
    mov ah,0ch   
    mov bh,0   
    mov dx,0    ;行 
l1:mov cx,0    ;列 
    mov al,1
    cmp dx,240
    ja o1
l2:
    push ax
    mov ax,cx
    mul bl
    cmp ah,0
    je s1 
    pop ax
    jmp next2
s1:pop ax
    inc al
next2: 
    int 10h 
    inc cx 
    cmp cx,640
    jae s2 
    jmp l2
s2:inc dx
    jmp l1
o1:                           ;打印第二行方格
    mov bl,a_x 
    mov ah,0ch   
    mov bh,0   
    mov dx,0    ;行 
ll1:mov cx,0    ;列 
    mov al,a
    cmp dx,240
    ja o2
ll2:
    push ax
    mov ax,cx
    mul bl
    cmp ah,0
    je ss1 
    pop ax
    jmp next3
ss1:pop ax
    inc al
next3: 
    int 10h 
    inc cx 
    cmp cx,640
    jae ss2 
    jmp ll2
ss2:inc dx
    jmp ll1
o2:                 
    ;mov ax,1        ;返归文本方式
    ;int 10h   
    mov ah,4ch
    int 21h
code ends
end start
