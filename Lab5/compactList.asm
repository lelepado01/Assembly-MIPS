	.data
list:		.space 512			# 4 byte * 128
	.text
	.globl main
	
main: 
	la $s0, list			
	move $s1, $s0			#HEAD
	
	move $a0, $s1			# carico head
	li $a1, 1				# dato da aggiungere
	jal insert
	move $a0, $v0
	li $a1, 2
	jal insert
	move $a0, $v0
	li $a1, 3
	jal insert
	move $a0, $v0
	li $a1, 3
	jal delete 
	
	j exit
	
insert:
	addi $sp, $sp, 4
	sw $ra, ($sp)

	sw $a1, ($a0)
	addi $a0, $a0, 4
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	
	move $v0, $a0			# return new_HEAD
	jr $ra
	
delete: 					# a0 = HEAD, a1 = N -> return New_Head 
	addi $sp, $sp, 4
	sw $ra, ($sp)
	
	li $t0, 4
	mul $t1, $t0, $a1
	sub $a2, $a0, $t1		# head - 4 * N = elemento da togliere
	
	move $a1, $a2
	jal fill				# res in V0
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra	
	
fill: 					# fill( a0 = HEAD, a1 = start)
	addi $sp, $sp, 4
	sw $ra, ($sp)
	
	beq $a0, $a1, end
	
	lw $t0, 4($a1)
	sw $t0, ($a1)
	
	addi $a1, $a1, 4
	jal fill
	
end: 
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
exit: 
	li $v0, 10
	syscall 
