	.data
a: 	.asciiz "Inserisci intero a: "
b: 	.asciiz "Inserisci intero b: "
c: 	.asciiz "Inserisci intero c: "
err: 	.asciiz "Comando non riconosciuto!"
array:.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 
	.text
	.globl main
	
main:
	li $v0, 4 			# print_string a
	la $a0, a
	syscall
	li $v0, 5			# read_int a
	syscall
	move $s0, $v0		# a = s0
	
	li $v0, 4			# print_string b
	la $a0, b
	syscall
	li $v0, 5			# read_int b
	syscall
	move $s1, $v0		# b = s1
	
	li $v0, 4			# print_string c
	la $a0, c
	syscall
	li $v0, 5			# read_int c
	syscall
	move $s2, $v0		# c = s2
	
	addi $t0, $zero, 12	# bound -> Array out of Bounds
	bgt $s0, $t0, error
	bgt $s1, $t0, error 	# if a > 13 || b > 13 -> error
	
	beq $s2, $zero, zero	# if c == 0 -> zero
	addi $t0, $zero, 1
	beq $s2, $t0, one		# if c == 1 -> one
	addi $t0, $zero, -1
	beq $s2, $t0, minus_one	# if c == -1 -> minus_one
	
error: 
	la $a0, err			# else -> print error, jmp exit
	li $v0, 4
	syscall
	j exit		
	
zero: 
	la $s3, array		# base address of array
	addi $t1, $zero, 4	# off
	mul $t2, $s0, $t1		# 4 * a
	add $t3, $t2, $s3		# *array[a] 
	lw $t4, ($t3)		# t4 = array[a]
		
	mul $t5, $t1, $s1		# 4 * b
	add $t6, $s3, $t5		# *array[b]				
	lw $t7, ($t6)		# t7 = array[b]		
	
	sw $t7, ($t3)		# array[a] = t7 (b)
	sw $t4, ($t6)		# array[b] = t4 (a)
	
	j exit
	
one: 
	la $s3, array
	addi $t0, $zero, 4	# off
	mul $t1, $t0, $s1		# 4 * b
	add $t2, $s3, $t1		# *array[b]
	
	mul $t3, $s0, $t0		# 4 * a
	add $t4, $t3, $s3		# *array[a] 
	lw $t5, ($t4)		# t5 = array[a]
	
	sw $t5,($t2)		# array[b] = t5
			
	j exit
	
minus_one: 	
	la $s3, array
	addi $t0, $zero, 4	# off
	mul $t1, $t0, $s1		# 4 * b
	add $t2, $s3, $t1		# *array[b]
	lw $t5, ($t2)		# t5 = array[b]
	
	mul $t3, $s0, $t0		# 4 * a
	add $t4, $t3, $s3		# *array[a] 
	
	sw $t5,($t4)		# array[b] = t5
			
	j exit
	
exit:
	li $v0, 10
	syscall
	
	