SECTION .DATA
	menuStr:	db 'Menu:', 0xA, 0xD
	menuLen:	equ $-menuStr
	addItem:	db '1-Add', 0xA, 0xD
	addItemLen:	equ $-addItem
	subItem:	db '2-Sub', 0xA, 0xD
	subItemLen: 	equ $-subItem
	exitItem:	db '0-Exit', 0xA, 0xD
	exitItemLen:	equ $-exitItem
	inputNumber:	db 'Input a number:', 0xA, 0xD
	inputNumberLen:	equ $-inputNumber
	pressKey:	db 'Press any key to continue...', 0xA, 0xD
	pressKeyLen:	equ $-pressKey
	result:		db 'The result is:', 0xA, 0xD
	resultLen:	equ $-result
	readLen	equ 8

SECTION .TEXT
	global 	_start

read:
; read() -> buf:string buffer
	push	rax
	push	rbx
	push	rcx
	push	rdx
	mov 	eax, 3 		; sys_read is syscall 3
	mov	ebx, 0 		; file descriptor for stdin is 0
	mov	ecx, buf 	; buffer is str defined in .bss section
				; .bss section is used for writable data
	mov	edx, readLen	; allocate space for reading
	int 	0x80
	pop 	rdx
	pop 	rcx
	pop	rbx
	pop 	rax
	ret

print:
; print(eax <- string buffer, ebx <- string lenght) -> void
	push 	rcx
	push	rdx
	mov	ecx, eax
	mov	edx, ebx
	mov	eax, 4
	mov	ebx, 1
	int	0x80
	pop	rdx
	pop	rcx
	ret

add:	
	mov eax, addItem
	mov ebx, addItemLen
	call print

	mov eax, inputNumber
	mov ebx, inputNumberLen
	call print
	call read
	mov ecx, buf
	
	mov eax, inputNumber
	mov ebx, inputNumberLen
	call print
	call read
	mov eax, buf
	
	;TODO: Proper sum
	add eax, ecx
	mov eax, ecx
	
	mov eax, result
	mov ebx, resultLen
	call print

	; TODO: Proper sum
	mov eax, ecx
	mov ebx, 16
	call print
	
	mov eax, pressKey
	mov ebx, pressKeyLen
	call print
	call read 
		
	jmp _start	


sub:
	mov eax, subItem
	mov ebx, subItemLen
	call print

	mov eax, inputNumber
	mov ebx, inputNumberLen
	call print
	call read
	mov ecx, buf
	
	mov eax, inputNumber
	mov ebx, inputNumberLen
	call print
	call read
	mov eax, buf
	
	;TODO: Proper sub
	sub eax, ecx
	mov eax, ecx
	
	mov eax, result
	mov ebx, resultLen
	call print

	; TODO: Proper sub
	mov eax, ecx
	mov ebx, 16
	call print
	
	mov eax, pressKey
	mov ebx, pressKeyLen
	call print
	call read 
		
	jmp _start	



_start:
	nop
	
	mov 	eax, menuStr 
	mov	ebx, menuLen 
	call	print ; print(menuStr, menuLen)
	
	mov	eax, addItem
	mov	ebx, addItemLen
	call 	print ; print(addItem, addItemLen)
	
	mov	eax, subItem
	mov	ebx, subItemLen
	call	print ; print(subItem, subItemLen)
	
	mov	eax, exitItem
	mov	ebx, exitItemLen
	call 	print ; print(exitItem, exitItemLen)
	
	call	read ; read()
	mov	eax, [buf]

	and	al, 0xF ; mask to get last nibble

	cmp	al, 0x1 ; is add?
	je 	add

	cmp	al, 0x2 ; is sub?
	je	sub

	cmp 	al, 0x0 
	jne	_start

exit:
	mov	eax, 1
	mov	ebx, 0
	int	0x80

section	.bss
	buf:	resb 8

