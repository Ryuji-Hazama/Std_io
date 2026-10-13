extern ascii_to_int
extern int_to_ascii

section .text
	global sys_exit_rax
	global std_in
	global std_in_int
	global std_out
	global std_out_int

; - - - ; Exit function ; - - -;

sys_exit_rax:
	mov rdi, rax	; Move exit code to RDI
	mov rax, 60	; System call 60 = sys_exit
	syscall

; - - - ; String Operators ; - - - ;

std_in:
	; - - - - - - - - - - - ;
	; Reserve buffer before ;
	; call this function    ;
	; - - - - - - - - - - - ;

	mov rax, 0		; System call 0 = sys_read
	mov rdi, 0		; File descriptor 0 = stdin
	syscall

	mov rdx, rax		; Move byte count to RDX
	ret

std_out:
	; - - - - - - - - - - - - - - -;
	; Before call this function:   ;
	; store string pointer to RSI, ;
	; and                          ;
	; store byte length to RDX     ;
	; - - - - - - - - - - - - - - -;

	mov rax, 1		; System call 1 = sys_write
	mov rdi, 1		; File sexcriptor 1 = stdout
	syscall
	ret

; - - - ; Integer Operators ; - - - ;

std_in_int:
	; - - - - - - - - - - - - -;
	; Result will store in RAX ;
	; - - - - - - - - - - - - -;

section .bss
	in_buffer resb 21	; Buffer for 21 digits of integer

section .text
	mov rsi, in_buffer	; Memory address to store string input
	call std_in		; Recieve input
	mov rsi, in_buffer	; Reset pointer
	call ascii_to_int
	ret

std_out_int:
	; - - - - - - - - - - - - - - - - -;
	; Output integer in RAX to std_out ;
	; - - - - - - - - - - - - - - - - -;

	call int_to_ascii	; Convert string to integer
	call std_out		; Output the result
	ret
