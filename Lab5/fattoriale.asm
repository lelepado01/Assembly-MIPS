
	.data
input: 	.asciiz "Inserisci N: "
out: 		.asciiz "Risultato: "
	.text
	.globl main
	
main:

	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	
	move $a0, $v0			# N
	addi $a1, $zero, 1
	jal fatt
	move $s0, $v0
	
	j exit 
	
fatt: 
	addi $sp, $sp, 4
	sw $ra, ($sp)
	
	beqz $a0, base
	mul $a1, $a1, $a0
	subi $a0, $a0, 1
	
	jal fatt
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
	
base:
	lw $ra, ($sp)
	subi $sp, $sp, 4
	move $v0, $a1
	jr $ra
	
	
exit: 
	li $v0, 4
	la $a0, out
	syscall
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 10
	syscall