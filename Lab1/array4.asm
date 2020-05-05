
	.data
# A: 	.word 0, 4, 8, 12

# oppure:

A:	.space 4
	.text
	.globl main
	
main:
	addi $t0, $zero, 4
	addi $t1, $zero, 8
	addi $t2, $zero, 12
	
	la $s0, A 			# carico address dell'array
	sw $zero,($s0)
	sw $t0, 4($s0)
	sw $t1, 8($s0)
	sw $t2, 12($s0)