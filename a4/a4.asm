%include "Along32.inc"


section .data

	begin	: db "Enter a number or 0 to terminate: ", 0ah
	count	: equ	100	
	
section .bss

arr resd 100

section .text
	global _start

_start:

	

	mov	ecx, 0			; start counter
	getNum:

		mov	edx,begin	; prompt
		call	WriteString
		cmp	ecx, 99		; overflow check
		jg	sort		; if > 100 sort the array
		call	ReadInt
		cmp	eax, 0
		jz	sort		; sort the array if terminated
		mov	[arr+ecx*4],eax
		inc	ecx
		inc	ecx
		loop	getNum

	jmp	show			; cautionary jump


exit:
	call	Crlf
	mov	eax, 1
	int 	0x80
	
sort:

	mov	esi, arr		; moves array into esi
	mov	ecx, count-1		; decrements the count
	jmp	first
first:

	push	ecx
	mov	eax, [esi]
	mov	edi, esi
	jmp	second
second:

	add	edi,4

	mov	ebx,[edi]
	cmp	eax,ebx
	jle	noxchg			; if the first is smaller
	mov	[edi], eax		; than the second go to noxchg
	mov	[esi], ebx

	mov	eax, ebx

noxchg:

	loop	second

	add	esi, 4
	pop	ecx
	loop	first

	mov	esi, arr
	mov 	ecx, count-1

show:				; display the sorted array

	push	ecx
	
	mov	eax,[esi]


	cmp	eax, 0
	je	zeroEx		; gets rid of filler 0's
	
	call	WriteInt
	add	esp,8

	add	esi, 4
	pop	ecx
	loop	show
	
	jmp	exit

zeroEx:

	cmp	ecx, 99		; if reached end of list, exit
	jg	exit

	add	esi, 4
	pop	ecx
	call	show
	call	Crlf
		
