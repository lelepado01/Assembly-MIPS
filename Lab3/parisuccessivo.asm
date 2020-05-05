
	.data
input:.asciiz "Inserire Intero: "
	.text
	.globl main

main:

	la $a0, input 
	li $v0, 4			# print_string
	syscall
	
	li $v0, 5			# read_int
	syscall
	
	addi $t0, $zero, 2
	div $v0, $t0		# num / 2
	mfhi $t1 			# prendo resto
	
	beq $t1, $zero, add_two	# if num % 2 == 0
	
	addi $a0, $v0, 1
	j exit 			# salto la sezione add_two
	
add_two: 
	addi $a0, $v0, 2
	 
exit:  
	li $v0, 1			# print_int
	syscall
	