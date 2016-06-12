;二进制到16进制转换程序
prognam		segment		;define code segment
main 	proc 	far
		assume cs:prognam
start:
;set up stack for return
	push 	ds
	sub  	ax, ax
	push 	ax			;put zero in AX

;main part of program	
	mov		ch, 4		;number of digits
rotate:
	mov		cl, 4		;set count to 4 bits
	rol		bx, cl		;left digit to right
	mov		al, bl		;move to AL
	and		al, 0fh		;mask off left digit
	add		al, 30h		;convert hex to ASCII
	cmp		al, 3ah		;is it > 9 ?
	jl		printit		;jump if digit = 0 to 9
	add		al, 7h		;digit is A to F
printit:
	mov 	dl, al 		;put ASCII char in DL
	mov 	ah, 2		;display output funct 执行什么指令是根据ah里面的值决定的，2表示输出指令，与下一条int 21h联用
	int		21h 		;call DOS
	dec 	ch 			;done 4 digits
	jnz 	rotate
	ret 				;return to DOS
main endp 				;end of main part of prog
prognam ends			;end of segment
	end 				;end of assembly

