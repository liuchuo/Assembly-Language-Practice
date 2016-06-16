;统计一个数中的1的个数
;在ADDR单元中存放着数Y的地址，试编制一个程序把Y中1的个数存入COUNT单元中
;***********************************************************
datarea segment 			;define data segment
addr 	dw		number
number 	dw 		1111111111111111B
count 	dw 		?
datarea	ends
;***********************************************************
prognam segment				;define code segment
;-----------------------------------------------------------
main proc far				;main part of program
	assume cs:prognam, ds:datarea

start:						;starting execution address
;set up stack for return
	push	ds				;save old data segment
	sub		ax, ax			;put zero in AX 
	push	ax 				;save it on stack

;set DS register to current data segment
	mov 	ax, datarea		;datarea segment addr
	mov		ds, ax 			;into DS register

;main part of program goes here
	mov		cx, 0			;initialize C to 0
	mov 	bx, addr 
	mov		ax, [bx]		;put Y in AX 

repeat:
	test	ax, 0ffffh		;test Y
	jz		exit			;if Y = 0, get exit
	jns		shift			;结果为正则转移（每次比较的是最高位）
	inc		cx

shift:
	shl		ax, 1
	jmp		repeat
	
exit:

    add     cl, 30h
    cmp     cl, 3ah
    jle     print
    add     cl, 7h
print:
    mov     dl, cl
    mov     ah, 2
    int     21h

    ret
main endp
;---------------------------------------------------------
prognam ends
	end 	start