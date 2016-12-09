data segment
	str db 10h dup('1',3 dup('2'));
	str1 db '$'
data ends;
	code segment
	ASSUME CS:CODE,DS:DATA
	start:
		mov ax,data;
		mov ds,ax;
		mov dx,offset str;
		mov ah,9;
		int 21h;
		mov ah,4ch;
		int 21h;
		code ends;
	end start;


		