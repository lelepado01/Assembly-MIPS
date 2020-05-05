	.data
arr:		.word 1,2,3,4,5,6, 134, 3, 0
min_str: 	.asciiz "\nIl minimo è: "
max_str: 	.asciiz "Il massimo è: "
	.text
	.globl main
	
main:
	la $a0, arr		# array to test
	li $a1, 9		# array len
	
	jal max		# find max
	move $s0, $v0	# S0 = MAX
	jal min		# find min
	move $s1, $v0	# S1 = MIN
	
	li $v0, 4
	la $a0, max_str
	syscall		# print_string max
	li $v0, 1
	move $a0, $s0
	syscall		# print max
	
	li $v0, 4
	la $a0, min_str
	syscall		# print_string min
	li $v0, 1
	move $a0, $s1
	syscall		# print min
	
	j exit

max:
	li $v0, -1000	# V0 = max
	li $t0, 0		# T0 = counter
	li $t1, 4		# array offset
	
loop1: 
	beq $t0, $a1, ret	# if counter == len -> return
	
	mul $t2, $t0, $t1	# off * 4
	add $t3, $t2, $a0	# array[off]
	lw $t4, ($t3)	# load array[off]
	
	ble $t4, $v0, else1	# if loaded > max -> replace
	move $v0, $t4		# replace in V0 max
else1: 				# else loop
	addi $t0, $t0, 1	# counter++
	j loop1

min:
	li $v0, 1000	# V0 = min
	li $t0, 0		# T0 = counter
	li $t1, 4		# array offset
	
loop2: 
	beq $t0, $a1, ret	# if counter == len -> return
	
	mul $t2, $t0, $t1	# off * 4
	add $t3, $t2, $a0	# array[off]
	lw $t4, ($t3)	# load array[off]
	
	bge $t4, $v0, else2	# if loaded < min -> replace
	move $v0, $t4		# replace in V0 min
else2: 				# else loop
	addi $t0, $t0, 1	# counter++
	j loop2

ret: 
	jr $ra

exit: 
	li $v0, 10
	syscall