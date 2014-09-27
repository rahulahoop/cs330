	SECTION .data

msg: db "Hello world", 10, 0
len: equ $-msg 

	SECTION .text
	global main

main:
	;print hello world
	mov edx, len
	mov ecx, msg
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov ebx, 0	;exit code, 0 = normal
	mov eax, 1	
	int 0x80	;exit
