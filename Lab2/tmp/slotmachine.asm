
	.data
input:.asciiz "Inserire Intero:"
output:.asciiz "Credito Rimasto:"
r: 	.asciiz "Numero Estratto:"
	.text
	.globl main

main:
	
	li $v0, 51		# input dialog
	la $a0, input	# address della stringa in a0 
	syscall
	
	addi $t0, $zero, 2
	mul $a1, $a0, $t0	# raddoppio il range
	sub $a1, $a1, $a0 # centro il range su 0
	
	add $s0, $zero, $a0 # salvo il credito dell'user
	
	li $v0, 42		# random int (range in a1)
	li $a0, 1234	# seed casuale
	syscall
	
	li $v0, 1		# print_int
	syscall
	
	add $s0, $s0, $a0 # aggiorno il credito
	
	li $v0, 4		# print_str
	la $a0, output	# address della stringa in a0 
	syscall
	
	li $v0, 1		# print_int
	move $a0, $s0
	syscall
	
	
	
	
	
	
	