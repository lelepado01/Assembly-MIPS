
	.data
A: 		.word 1,2,3,4,5, 6, 7
out: 		.asciiz "Risultato: "
	.text
	.globl main
	
main: 
	la $a0, A
	li $a1, 7
	
	jal sommaRicorsiva
	move $s1, $v0
	j exit 
	
sommaRicorsiva: 
	addi $sp, $sp, 4
	sw $ra, ($sp)
	addi $sp, $sp, 4
	sw $a1, ($sp)
	
	bne $a1, 0, else
	li $v0, 0
	
	lw $a1, ($sp) 
	subi $sp, $sp, 4
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
else: 
	subi $a1, $a1, 1
	jal sommaRicorsiva
	
	li $t0, 4
	mul $t1, $t0, $a1
	add $t1, $t1, $a0
	lw $t2, ($t1)
	
	add $v0, $v0, $t2

	lw $a1, ($sp) 
	subi $sp, $sp, 4
	lw $ra, ($sp) 
	subi $sp, $sp, 4
	jr $ra

exit: 
	li $v0, 4
	la $a0, out
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 10
	syscall
