data segment
	var1 db 12h,34h,f5h
	var2 db 100h,'a','b'
	var3 dw '1234567890'
	var4 db "1234567890"
	var5 db dup(0)
	var6 dw 'ab',5678h,0
data1 ends
stack1 segment stack
	dw 20h dup(0)
stack1 ends
code segment
	assume cs:code,ds:data1,ss:stack1
	begin mov ds,ax
	mov ds,ax
	num1 equ 5
	mov bx,offset var5
	mov [bx],num1
	num1 equ 10
	add [bx],num1
	mov ax,var1
	inc bx,1
	shr ax,4
	sub [bx],ax
	lea si,var4
	adc [bx],[si]
	mov ah,4ch
	int 21h
	codeseg ends
ends begin
