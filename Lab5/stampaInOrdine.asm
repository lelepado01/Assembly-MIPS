
	.data
A: 	.word 1,3,5,7,6,2
sep: 	.asciiz ", "
	.text
	.globl main
	
main:
	li $a0, 6 			# len di A
	jal printarray
	j exit
	
printarray: 			#warning -> consuma array
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $a0, ($sp)
	
	beq $a0, 0, end
	
	li $a0, 0				# max
	li $a1, 0				# index
	la $a2, 6				# len
	la $a3, A				# base address
	
	jal trovamax
	move $a0, $v0
	
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, sep
	syscall
	
	lw $a0, ($sp)
	subi $sp, $sp, 4
	subi $a0, $a0, 1
	
	jal printarray
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
	
end:
	lw $a0, ($sp)
	subi $sp, $sp, 4
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra 
	
trovamax: 					# trovamax(max, index_max, len, A) -> index_max
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $a0, ($sp)
	addi $sp, $sp, 4
	sw $a1, ($sp)
	
	beq $a2, 0, end2
	
	li $t0, 4				# array offset
	mul $t1, $t0, $a2			# 4 * index
	add $t1, $t1, $a3
	lw $t1, ($a3)			# elemento nuovo
	
	bge $a0, $t1, iter
	move $a0, $t1
	move $a1, $a2
	
iter: 
	subi $a2, $a2, 1			# len-- (non controllo più l'ultimo valore)
	jal trovamax
	
end2: 
	lw $a1, ($sp)
	subi $sp, $sp, 4
	lw $a0, ($sp)
	subi $sp, $sp, 4
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
		
exit: 
	li $v0, 10
	syscall
