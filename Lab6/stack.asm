	.data
sep: 		.asciiz ", "
nl: 		.asciiz "\n"
search: 	.asciiz "Found at Index "
	.text
	.globl main
	
main: 
	li $v0, 9
	li $a0, 16
	syscall			# START
	
	# INIZIO OP su STACK
	li $a0, 12
	li $a1, 13
	li $a2, 14
	jal stack_push
	
	jal stack_push
	
	jal stack_pop
	
	li $a0, 1
	li $a1, 3
	li $a2, 4
	jal stack_push
	
	li $a0, 12
	li $a1, 2
	li $a2, 4
	jal stack_push
	
	jal stack_print
	
	li $a0, 1
	li $a1, 3
	li $a2, 4
	jal stack_search
	
	# FINE OP su STACK
	
	j exit 
	
stack_push: 			# push(a0, a1, a2)
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $v0, ($sp)
	addi $sp, $sp, 4
	sw $a0, ($sp)

	li $v0, 9
	li $a0, 16
	syscall			# call a alloc
	
	lw $a0, ($sp)		# per chiamare alloc devo sovrascrivere a0			
	subi $sp, $sp, 4
	
	sw $a0, ($v0)		# metto x, y, angle
	sw $a1, 4($v0)
	sw $a2, 8($v0)
	
	lw $t0, ($sp)		# prendo v0 salvato (NEXT)			
	subi $sp, $sp, 4
	
	sw $t0, 12($v0)		# campo next
	
	lw $ra, ($sp)		
	subi $sp, $sp, 4
	jr $ra			# restituisco il nuovo stack
	
	
stack_pop:
	addi $sp, $sp, 4
	sw $ra, ($sp)
	
	lw $t0, ($v0)			# salvo tutti i reg
	lw $t1, 4($v0)
	lw $t2, 8($v0)
	lw $t3, 12($v0)			# nuovo *Stack
	
	sw $zero, ($v0)
	sw $zero, 4($v0)
	sw $zero, 8($v0)
	sw $zero, 12($v0)
	
	move $v0, $t3			# return nuovo *STACK
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra 

stack_print: 				# print(v0)
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $v0, ($sp)
	
	lw $t0, ($v0)			# salvo tutti i reg
	lw $t1, 4($v0)
	lw $t2, 8($v0)
	lw $t3, 12($v0)
	
	beq $t3, 0, print_ret
	
	li $v0, 1
	move $a0, $t0
	syscall				# x
	li $v0, 4
	la $a0, sep
	syscall				# separator
	li $v0, 1
	move $a0, $t1
	syscall				# y
	li $v0, 4
	la $a0, sep
	syscall				# separator
	li $v0, 1
	move $a0, $t2
	syscall				# angle
	li $v0, 4
	la $a0, sep
	syscall				# separator
	
	li $v0, 4
	la $a0, nl
	syscall				# a capo
	
	move $v0, $t3
	jal stack_print
print_ret: 
	lw $v0, ($sp)
	subi $sp, $sp, 4 
	lw $ra, ($sp)
	subi $sp, $sp, 4
	
	jr $ra
	
stack_search: 				# search(x, y, z) -> START
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $v0, ($sp)
	addi $sp, $sp, 4
	sw $a0, ($sp)
	addi $sp, $sp, 4
	sw $a1, ($sp)
	addi $sp, $sp, 4
	sw $a2, ($sp)
	
	addi $a3, $a3, 1			# index counter ++ 
	
	lw $t0, ($v0)			# salvo tutti i reg
	lw $t1, 4($v0)
	lw $t2, 8($v0)
	lw $t3, 12($v0)
	
	bne $t0, $a0, diff
	bne $t1, $a1, diff
	bne $t2, $a2, diff
	
	li $v0, 4
	la $a0, search
	syscall
	li $v0, 1
	move $a0, $a3
	syscall				# stampo index
	
	li $v0, 4
	la $a0, nl
	syscall				# a capo
	
diff: 	
	beq $t3, 0, search_ret
	
	move $v0, $t3
	jal stack_search
	
search_ret: 
	lw $a2, ($sp)
	subi $sp, $sp, 4 
	lw $a1, ($sp)
	subi $sp, $sp, 4 
	lw $a0, ($sp)
	subi $sp, $sp, 4
	lw $v0, ($sp)
	subi $sp, $sp, 4 
	lw $ra, ($sp)
	subi $sp, $sp, 4
	
	jr $ra

exit: 
	li $v0 10
	syscall
