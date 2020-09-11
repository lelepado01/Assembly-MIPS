
	.data
	
	.text
	.globl multiplication
	
# a0 contiene il primo operando
# a1 contiene il secondo operando
# v0 contiene a0 * a1
	
multiplication:
	addi $sp, $sp, 4
	sw $ra, 0($sp)
	
	mul $v0, $a0, $a1
	
	lw $ra, 0($sp)
	addi $sp, $sp, -4
	
	jr $ra