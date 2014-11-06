section  .data ;Data segment
 
    prodMsg		db	' : is the product ' , 0xA,0xD
    lenprodMsg equ	$-prodMsg

    numMsg		db	' : is the numerator ' , 0xA,0xD
    lennumMsg equ	$-numMsg

    denomMsg		db	' : is the denominator ' , 0xA,0xD
    lendenomMsg equ	$-denomMsg

    fracMsg		db	' : is the quotient ' , 0xA, 0xD
    lenfracMsg	equ	$-fracMsg

    errMsg 		db 	'Cannot divide by zero! ' , 0h 
    lenerrMsg	equ 	$-errMsg

    endMsg		db	' : is the end result ' , 0xA, 0xD
    lenendMsg	equ	$-endMsg

section .bss            ;Uninitialized data
    num 	resb 	4
    num2 	resb 	4
    space   resb	1
    denom  resb 	8
    numerator resb 8
    product   resb 8
    frac	resb 8
    result resb 8

section .text           ;Code Segment
       global main
       global _exit
       global _err
       global _denom
       global _prod
       global _numer
       global _endRes
       global _frac
main:
	
       ; enter numbers 1st
       mov eax, 3
       mov ebx, 0
       mov ecx, num  
       mov edx, 2     
       int 0x80
       
       
       ; enter numbers 2nd
       mov eax, 3
       mov ebx, 0
       mov ecx, num2  
       mov edx, 2      
       int 0x80

	   jmp _denom
	     
_denom:
		; remove and add ascii 0
	   mov eax, [num]
	   sub eax, '0'
	   mov ebx, [num2]
	   sub ebx, '0'
	   
	   cmp eax, ebx
           jbe _err
	   
           ;subtract number
	   sub eax, ebx


           add eax, '0'

           cmp eax, 0
           je _err

	   mov [denom] , eax
           int 0x80
	   
	   mov eax, 4
           mov ebx, 1
           mov ecx, denom
           mov edx, 1
           int 0x80       

           mov eax, 4
           mov ebx, 1
           mov ecx, denomMsg
           mov edx, lendenomMsg
           int 0x80
       	   jmp _numer 
       
_numer:

	   ; remove and add ascii 0
	   mov eax, [num]
	   sub eax, '0'
	   mov ebx, [num2]
	   sub ebx, '0'
	   
	   ;add  number
	   add eax, ebx
	   add eax, '0'
	   mov [numerator] , eax
	   int 0x80
	  
           mov eax, 4
           mov ebx, 1
           mov ecx, numerator 
           mov edx, 1
           int 0x80
          
	   mov eax, 4
           mov ebx, 1
           mov ecx, numMsg
           mov edx, lennumMsg
           int 0x80 
	   jmp _frac
_frac:
	   ; remove and add ascii 0
	   
	   xor edx, edx
           mov eax, [numerator]
           sub eax, '0'
 
           mov ebx, [denom]
           sub ebx, '0'
	   mov edx, 0
	
	   cdq
	   div ebx
	   add eax, '0'
	   mov [frac], eax
	   int 0x80
       	   
	   mov eax, 4
    	   mov ebx, 1
           mov ecx, frac
           mov edx, 1
           int 0x80

	   mov eax, 4
           mov ebx, 1
           mov ecx, fracMsg
           mov edx, lenfracMsg
	   int 0x80

	   jmp _prod

_prod:
	   ; remove and add ascii 0
	   mov eax, [num]
	   sub eax, '0'
	   mov ebx, [num2]
	   sub ebx, '0'
	   
	   mul ebx
	   add eax, '0'
	   mov [product] , eax
	   int 0x80
	  
    	   mov eax, 4
	   mov ebx, 1
	   mov ecx, product
	   mov edx, 1
	   int 0x80
  
           mov eax, 4
	   mov ebx, 1
           mov ecx, prodMsg
	   mov edx, lenprodMsg
	   int 0x80

	   jmp _endRes
	   
_endRes:
		; remove and add ascii 0
	   mov eax, [product]
	   sub eax, '0'
	   mov ebx, [frac]
	   sub ebx, '0'

	   add eax, ebx
	   add eax, '0'
	   mov [result] , eax
	   int 0x80

	   mov eax, 4
	   mov ebx, 1
	   mov ecx, result
	   mov edx, 1
	   int 0x80
	  
	   mov eax, 4
	   mov ebx, 1
	   mov ecx, endMsg
	   mov edx, lenendMsg
           int 0x80
 
	   jmp _exit
	   
_err:

	mov eax, 4
	mov ebx, 1
	mov ecx, errMsg
	mov edx, lenerrMsg
	int 0x80
	
	jmp _exit
	
_exit:
	
       ; Exit code
       mov eax, 1
       mov ebx, 0
       int 0x80

       ret

