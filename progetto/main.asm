	.data

out_max:
	.asciiz "Risultato della fold left con MAX: "
out_add:
	.asciiz "Risulato della flod left con ADD: "
out_mult: 
	.asciiz "Risultato della fold left con MULT: "

array: 	.word 1,20,3,4

	.text
	
	.globl main
	
	
main: 
	la $a0, array		# indirizzo base dell'array
	li $a1, 1		# 0 = addizione, 1 = max, 2 = mult 	(IMP: con MULT l'accumulatore deve essere 1)
	li $a2, 0		# valore iniziale dell'accumulatore
	li $a3, 4		# len array

	addi $sp, $sp, 4
	sw $a1, 0($sp)

	jal foldl
	move $s0, $v0
	
	lw $t0, 0($sp)		# questo è il codice dell'operazione -> lo uso per capire quale stringa stampare
	addi $sp, $sp, -4
	beq $t0, 1, print_max
	beq $t0, 2, print_mult
	
	la $a0, out_add
	j print
			
print_max:
	la $a0, out_max
	j print
	
print_mult: 
	la $a0, out_mult
	j print

print:
	li $v0, 4
	syscall

	move $a0, $s0		# print risultato
	li $v0, 1
	syscall
	
	li $v0, 10 
	syscall
