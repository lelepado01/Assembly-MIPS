	
	.data
	
	.text
	.globl addition

# a0 contiene operando 1
# a1 contiene operando 2
# v0 contiene a0 + a1

addition: 
	addi $sp, $sp, 4
	sw $ra, 0($sp)
	
	add $v0, $a0, $a1
	
	lw $ra, 0($sp)
	addi $sp, $sp, -4
	
	jr $ra