
	.data
A: 	.space 400				# .space alloca in byte -> io voglio word => byte * 4
B: 	.space 400

	.text
	.globl main
main:
	
	addi $s0, $zero, 3		# i
	addi $s1, $zero, 2		# C
	
	la $s2, A 				
	la $s3, B
	
	addi $t0, $zero, 4		# byte offset
	mul $t1, $s0, $t0			# i * 4
	add $t2, $t1, $s3			# B[i]
	addi $t3, $zero, 10
	sw $t3, ($t2) 			# B[i] <- 10
	
	# calcolo (ignoro la parte di prima)
	
	addi $t0, $zero, 4		# byte offset
	mul $t1, $s0, $t0			# i * 4
	add $t2, $t1, $s3			# B[i] (indirizzo)
	lw $t3, ($t2)			# B[i]
	
	addi $s4, $t3, 5			# B[i] + 5
	add $s4, $s4, $s1			# B[i] + 5 + C
	
	addi $t1, $zero, 99
	mul $t2, $t1, $t0 		# 99 * 4
	add $t3, $t2, $s2			# A[99] (indirizzo)
	
	sw $s4, ($t3)			# A[99] <- B[i] + 5 + C
	  
	    
	