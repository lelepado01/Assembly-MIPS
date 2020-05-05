
	.data
arr: 		.word 0,0,0,0,0,0
input_str: 	.asciiz "Inserisci un valore: "
input_par: 	.asciiz "Inserisci il parametro k (0 o 1): "
out_str: 	.asciiz "Risultato: "
	.text
	.globl main
	
main:
	addi $s0, $zero, 6		# arr length
	addi $t1, $zero, 4		# arr element offset
	addi $t0, $zero, 0		# arr counter
	la $s1, arr				# base address of array
input_loop:
	li $v0, 4
	la $a0, input_str
	syscall
	li $v0, 5
	syscall				# ask for input -> res in $v0
	
	mul $t2, $t1, $t0			# element_offset = 4*counter
	add $t2, $t2, $s1			# arr[counter]
	sw $v0, ($t2)			# arr[counter] = input
	
	addi $t0, $t0, 1			# counter++
	bne $t0, $s0, input_loop	# if counter != arr len -> keep asking input
	
	li $v0, 4
	la $a0, input_par
	syscall
	li $v0, 5
	syscall
	move $a1, $v0			# arg2 = parametro k
	move $a0, $s1			# arg1 = base address of array
	
	jal P	
	move $s2, $v0			# move result to s2
	
	li $v0, 4
	la $a0, out_str
	syscall				# print_str
	li $v0, 1
	move $a0, $s2 
	syscall				#print res
	
	j exit
	
P: 
	li $v0, 0				# REG per somma
	# sommo sempre i pari 
	addi $t0, $zero, 0		# counter
	addi $t1, $zero, 4		# array offset
loop1: 
	mul $t2, $t1, $t0			# arr[counter]
	add $t3, $t2, $a0
	lw $t3, ($t3)
	
	add $v0, $v0, $t3			# somma += element
	addi $t0, $t0, 2			# counter += 2 (solo pari)
	
	bgt $s0, $t0, loop1		# if counter >= len -> stop loop
	
	beq $a1, 1, ret			# if k == 1 -> fine
	# sommo i dispari
	addi $t0, $zero, 1		# counter
loop2: 
	mul $t2, $t1, $t0			# arr[counter]
	add $t3, $t2, $a0
	lw $t3, ($t3)
	
	add $v0, $v0, $t3			# somma += element
	addi $t0, $t0, 2			# counter += 2 (solo dispari)
	
	bgt $s0, $t0, loop2		# if counter >= len -> stop loop
	
ret: 
	jr $ra
	
exit: 
	li $v0, 10
	syscall
	
