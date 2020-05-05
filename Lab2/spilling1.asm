	
	.data
	
	.text
	.globl main
	
main:
	# usare soltanto registri $t0 e $s0
	addi $sp, $sp, 4 		# stack pointer ++ (all'inizio lo devo fare 
					# altrimenti non memorizza 3)
	addi $t0, $zero, 1
	addi $s0, $zero, 3
	mult $t0, $s0		# 1 * 3
	
	mflo $t0 			# t0 = 1 * 3
	sw $t0, ($sp)		# push (1 * 3)
	addi $sp, $sp, 4 		# stack pointer ++
	
	addi $t0, $zero, 2	
	mult $t0, $s0		# 2 * 3
	
	mflo $t0 			# t0 = 2 * 3
	sw $t0, ($sp)		# push (2 * 3)
	addi $sp, $sp, 4 		# stack pointer ++
	
	addi $t0, $zero, 3	
	mult $t0, $s0		# 3 * 3
	
	mflo $t0 			# t0 = 3 * 3
	sw $t0, ($sp)		# push (3 * 3)
	addi $sp, $sp, 4 		# stack pointer ++
	
	subi $sp, $sp, 4		# stack pointer --
	lw $s0, ($sp)		# s0 = 9
	
	subi $sp, $sp, 4		# stack pointer --
	lw $t0, ($sp)		# t0 = 6
	
	add $s0, $s0, $t0		# 9 + 6
	
	subi $sp, $sp, 4		# stack pointer --
	lw $t0, ($sp)		# t0 = 3
	add $s0, $t0, $s0 	# 9 + 6 + 3
	
	
	
	
	
	
	
	