
	.data
A: 		.word 1,2,3,4,5
sep: 		.asciiz ", "
	.text
	.globl main
	
main: 
	li $a1, 4
	la $a0, A
	jal stampa_arr
	
	j exit
	
stampa_arr: 
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $a1, ($sp) 
	addi $sp, $sp, 4
	sw $a0, ($sp) 
		
	beq $a1, -1, end
	
	li $t0, 4
	mul $t1, $t0, $a1
	add $t1, $t1, $a0
	lw $t2, ($t1)
	
	move $a0, $t2
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, sep
	syscall
	
	lw $a0, ($sp)
	subi $a1, $a1, 1
	jal stampa_arr
	
end: 
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