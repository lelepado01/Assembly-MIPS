		.data
input: 	.asciiz "Inserisci un dato: "
label1:	.asciiz "Branch called address 1 (tutti uguali)"
label2: 	.asciiz "Branch called address 2 (tutti diversi)"
label3: 	.asciiz "Branch called address 3 (casi misti)"
		.text
		.globl main

main:
	li $v0, 4
	la $a0, input
	syscall			# print_str
	li $v0, 5
	syscall			#read_int
	move $s0, $v0		# A = S0

	li $v0, 4
	la $a0, input
	syscall			# print_str
	li $v0, 5
	syscall			#read_int
	move $s1, $v0		# B = S1
	
	li $v0, 4
	la $a0, input
	syscall			# print_str
	li $v0, 5
	syscall			#read_int
	move $s2, $v0		# C = S2
	
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2 
	
	jal branch3equal
	j exit
	
	
addr1: 
	li $v0, 4
	la $a0, label1
	syscall
	
	j ret

addr2: 
	li $v0, 4
	la $a0, label2
	syscall
	
	j ret

addr3: 
	li $v0, 4
	la $a0, label3
	syscall
	
	j ret

branch3equal:
	bne $a0, $a1, zero	# A != B ? 
	bne $a0, $a2, else	# A != C ? 
	j addr1			# caso in cui tutti sono uguali
	
zero:
	beq $a1, $a2, else	# B = C ? 
	beq $a0, $a2, else	# A = C ? 
	j addr2			# caso in cui sono tutti diversi
else: 
	j addr3			# qualunque altro caso
	
ret:
	jr $ra			# ritorno dalla procedura

exit: 
	li $v0, 10
	syscall