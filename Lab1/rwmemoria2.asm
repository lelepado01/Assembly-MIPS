
	.data
A:	.word -1, -1, 1, 4
B: 	.word -1, 6, -1, -1
	.text
	.globl main

main:
	addi $s1, $zero, 2 		# c = 2
	la $s2, A
	la $s3, B
	
	addi $t0, $zero, 4		# byte offset
	mul $t1, $s1, $t0			# c * offset
	add $t1, $t1, $s2 		# A[c]
	lw $t2, ($t1)			# t2 <- A[c]
	mul $t2, $t2, $t0			# A[c] * offset
	
	add $t3, $t2, $s3			# B[A[c]]
	lw $t4, ($t3)			# t4 <- B[A[c]]
	add $s4, $t4, $s1			# B[A[c]] + c
	mul $s4, $s4, $s1			# (B[A[c]] + c) * c
	
	addi $t1, $zero, 2
	mul $t2, $s1, $t1			# 2 * c 
	subi $t3, $t2, 1			# 2c - 1
	mul $t4, $t3, $t0			# (2c -1) * off
	
	add $t5, $s2, $t4			# *A[2c -1]
	lw $s5, ($t5)			# s5 <- A[2c-1]
	
	div $s6, $s4, $s5			# (B[A[c]] + c) * c / A[2c-1]
	
	subi $t1, $s1, 1			# c - 1
	mul $t1, $t1, $t0			# (c-1) * off 
	add $t2, $t1, $s2			# *A[c-1]
	sw $s6, ($t2)			# A[c-1] <- (B[A[c]] + c) * c / A[2c-1]
	
	
	