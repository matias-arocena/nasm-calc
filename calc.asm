SECTION .DATA
	menuStr:	db 'Menu:', 0xA, 0xD
	menuLen:	equ $-menuStr
	addItem:	db '1-Add', 0xA, 0xD
	addItemLen:	equ $-addItem
	exitItem:	db '0-Exit', 0xA, 0xD
	exitItemLen:	equ $-exitItem
	readLen	equ 8

SECTION .TEXT
	global 	_start

read:
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

_start:
	nop
	mov 	eax, menuStr
	mov	ebx, menuLen
	call	print
	mov	eax, addItem
	mov	ebx, addItemLen
	call 	print
	mov	eax, exitItem
	mov	ebx, exitItemLen
	call 	print
	call	read
	mov	eax, [buf]
	cmp 	eax, 0xa30 
	jne	_start

exit:
	mov	eax, 1
	mov	ebx, 0
	int	0x80

section	.bss
	buf:	resb 8
