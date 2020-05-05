
	.data
input:.asciiz "Inserisci Valore: "
out: 	.asciiz "Risultato: "
	.text
	.globl main
	
main:
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
		
	move $a0, $s0
	move $a1, $s1
		
	jal prodotto_s		# prodotto_s(3, 3), dove a1 è un counter
	move $s2, $v0		# sposto risultato del prodotto
	
	j exit

somma: 
	add $v0, $a0, $a1 		# somma args
	jr $ra
	
prodotto_s: 
	addi $sp, $sp, 4			# sp++
	sw $ra, ($sp)			# salvo ra in stack
	addi $sp, $sp, 4			# sp++
	sw $a1, ($sp)			# salvo counter in stack
	
	beqz $a1, end 			# if counter == 0 -> end
						# else ->
	move $a1, $t3
	jal somma
	move $t3, $v0			# output della somma in v0
	
	lw $a1, ($sp)			# ricarico il counter in $a1
	subi $sp, $sp, 4			# sp--
	subi $a1, $a1, 1			# counter--
	
	jal prodotto_s			
	
	lw $ra, ($sp)
	subi $sp, $sp, 4
	jr $ra
	
end: 
	subi $sp, $sp, 4			# ho due campi prima del return address (acc e counter)
	lw $ra, ($sp)			# che ho salvato a inizio procedura
	subi $sp, $sp, 4
	move $v0, $t3			# sposto risultato in v0 da convenzione
	jr $ra

exit: 
	li $v0, 4
	la $a0, out
	syscall
	
	move $a0, $s2
	li $v0, 1
	syscall

	li $v0, 10
	syscall