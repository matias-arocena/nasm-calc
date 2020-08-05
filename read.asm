SECTION .DATA
	hello:	db 'Hello', 6
	helloLen:	equ $-hello
	readLen	equ 8

SECTION .TEXT
	global 	_start

_start:	
	mov 	eax, 3 		; sys_read is syscall 3
	mov	ebx, 0 		; file descriptor for stdin is 0
	mov	ecx, str 	; buffer is str defined in .bss section
				; .bss section is used for writable data
	mov	edx, readLen	; allocate space for reading
	int 	0x80
;	dec	eax

	mov	ebx, 1
	mov	ecx, str
	mov	edx, eax
	mov	eax, 4
	int	0x80
		
	mov	eax, 1
	mov	ebx, 0
	int	0x80

section	.bss
	str:	resb 8
