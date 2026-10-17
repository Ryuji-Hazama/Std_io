DEFAULT REL

	; - - - - - - - - - - - - - - - -;
	; Test script for std in and out ;
	; - - - - - - - - - - - - - - - -;

extern sys_exit_rax	; Pull functions
extern std_out
extern std_in_int
extern std_out_int

section .bss
	first_number resd 1	; Reserve 1 quadword (32 bytes) for the first number
	second_number resd 1	; Reserve 1 quadword for the second number
	result_number resd 1	; Reserve 1 quadeword for the resul

section .data
	input_msg_1 db "Input the base number: ", 0
	input_msg_1_len equ $ - input_msg_1
	input_msg_2 db "Input additional number: ", 0
	input_msg_2_len equ $ - input_msg_2
	output_msg db "Result is: ", 0
	output_msg_len equ $ - output_msg

	new_line db "", 0Ah
	new_line_len equ $ - new_line

section .text
	global _start

_start:

	; Get the first input
	mov rsi, input_msg_1
	mov rdx, input_msg_1_len
	call std_out			; Output the message
	call std_in_int			; Recieve input
	mov [first_number], eax		; Save the first number to memory

	; Get the second input
	mov rsi, input_msg_2
	mov rdx, input_msg_2_len
	call std_out
	call std_in_int
	mov [second_number], eax	; Save the second number to memory

	; Calculate the addition
	xor eax, eax			; Clear RAX
	add eax, [first_number]		; Add the firs number to RAX
	add eax, [second_number]	; Add the second number to RAX
	mov [result_number], eax	; Seve the result to memory

	; Output result
	mov rsi, output_msg
	mov rdx, output_msg_len
	call std_out
	mov eax, [result_number]	; Revert the result
	call std_out_int

	; Exit function
	mov rax, 0
	call sys_exit_rax
