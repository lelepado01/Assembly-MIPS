
	.data
A:	.space 12
	.text
	.globl ma

ma:
	addi $s1, $zero, 15	# H
	la $s2, A 			# A
	
	addi $t0, $zero, 8	# riempio array
	sw $t0, 32($s2)		# metto dato in array (8)
	
	lw $t0, 32($s2) 		# A[8]
	add $t1, $t0, $s1		# A[8] + H
	
	sw $t1, 48($s2)
	
	
