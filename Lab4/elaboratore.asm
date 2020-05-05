
	.data
o1: 		.asciiz "Inserisci il primo Operando: "
o2: 		.asciiz "Inserisci il secondo Operando: "
operator: 	.asciiz "Inserisci l'Operatore: "
result: 	.asciiz "\nRisultato: "
resto: 	.asciiz "\nResto: "
errore: 	.asciiz "Errore!"
op_buffer: 	.word 0,0,0
	.text
	.globl main

main:
	li $v0, 4
	la $a0, o1
	syscall
	li $v0, 5
	syscall
	move $s0, $v0		# operando 1 in S0
	
	li $v0, 4
	la $a0, o2
	syscall
	li $v0, 5
	syscall
	move $s1, $v0		# operando 2 in S1
	
	li $v0, 4
	la $a0, operator
	syscall
	li $v0, 5
	syscall		
	move $s2, $v0		# operatore in S2
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal elaboratore		# salta a procedura

	move $t0, $v0		# salva risultato elaboratore
	
	li $v0, 4
	la $a0, result		# stampa stringa per risultato
	syscall
	move $a0, $t0
	li $v0, 1
	syscall			# stampa risultato
	
	bne $a2, 4, no_resto	# se non è divisione, salta la stampa del resto
	li $v0, 4
	la $a0, resto		# stampa stringa per resto
	syscall
	move $a0, $v1
	li $v0, 1
	syscall			# stampa resto
	
no_resto: 
	j exit
	
elaboratore: 
	beq $a2, 1, ad
	beq $a2, 2, su
	beq $a2, 3, mu
	beq $a2, 4, dv
	
	li $v0, 4
	la $a0, errore
	syscall
	j exit

dv: 
	div $a0, $a1
	mfhi $v1
	mflo $v0
	j re

mu: 
	mul $v0, $a0, $a1
	j re
	
su: 
	sub $v0, $a0, $a1
	j re
	
ad: 
	add $v0, $a0, $a1
	j re
	
re: 
	jr $ra			# torna a main
	
exit: 
	li $v0, 10
	syscall			# esci 