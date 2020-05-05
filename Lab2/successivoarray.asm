
	.data
A: 	.word 0 0
input:.asciiz "Inserire Intero:"
	.text
	.globl main

main:
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	addi $t1, $t0, 1
	
	la $t2, A
	sw $t0, ($t2)
	sw $t1, 4($t2)  
