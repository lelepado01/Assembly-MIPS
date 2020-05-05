
	.text
	.globl main
	
main:
	addi $s1, $zero, 1
	addi $s2, $zero, 2
	addi $s3, $zero, 3
	addi $s4, $zero, 4
	add $t0, $s1, $s2
	sub $t1, $s3, $s4
	add $s0, $t0, $t1