
	.data
prompt: .asciiz "Inserisci un numero: "

	.text	
	.globl main
	
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	addi $a0, $v0, 1
	
	li $v0, 1
	syscall
	
	
