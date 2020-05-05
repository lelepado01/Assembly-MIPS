
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
	
	move $a0, $v0
	jal fib
	move $s0, $v0
	
	j exit

fib:	
	addi $sp, $sp, 4		# salvo sp
	sw $ra, ($sp)
	addi $sp, $sp, 4		# salvo t0 che modifico
	sw $t0, ($sp)
	addi $sp, $sp, 4		# idem
	sw $t1, ($sp)
	addi $sp, $sp, 4		# voglio resettare N per il secondo ramo
	sw $a0, ($sp)
	
	beq $a0, 2, two
	beq $a0, 1, one
	
	subi $a0, $a0, 1		# N-1
	jal fib			# F(N-1)
	move $t0, $v0
	
	lw $a0, ($sp)		# Ricarico N
	
	subi $a0, $a0, 2		# N-2
	jal fib			# F(N-2)
	move $t1, $v0
	
	add $v0, $t0, $t1		# F(N-2) + F(N-1)
	
	lw $a0, ($sp)		# Ricarico N	
	subi $sp, $sp, 4
	lw $t1, ($sp)
	subi $sp, $sp, 4		# pop di t1
	lw $t0, ($sp)		
	subi $sp, $sp, 4		# pop di t0 (ci sono dati importanti nei rami superiori)
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
	
two:
	addi $v0, $zero, 1
	
	subi $sp, $sp, 4		# pop di t1	
	subi $sp, $sp, 4		# pop di t0 (ci sono dati importanti nei rami superiori)
	
	subi $sp, $sp, 4
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra

one: 
	addi $v0, $zero, 0 
	
	subi $sp, $sp, 4		# pop di t1		
	subi $sp, $sp, 4		# pop di t0 (ci sono dati importanti nei rami superiori)
	
	subi $sp, $sp, 4
	lw $ra, ($sp)
	subi $sp, $sp, 4
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
