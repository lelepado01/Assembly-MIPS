
	.data
	
	.text
	.globl max
	
# a0 contiene il primo operando 
# a1 contiene il secondo operando
# v0 contiene max{a0, a1}
	
max: 
	addi $sp, $sp, 4
	sw $ra, 0($sp)
	
	bge $a0, $a1, else
	
	move $v0, $a1
	j ret
	
else: 
	move $v0, $a0

ret: 	
	lw $ra, 0($sp)
	addi $sp, $sp, -4
	
	jr $ra