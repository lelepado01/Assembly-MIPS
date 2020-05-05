
	.data
N:	.asciiz "Inserisci N: "
V: 	.asciiz "Insersci V: "
br: .asciiz "<break>"
	.text
	.globl main

main: 
	li $v0, 4			# print_string
	la $a0, N
	syscall
	li $v0, 5			# read_int
	syscall
	move $s0, $v0		# s0 = N
	
	li $v0, 4			# print_string
	la $a0, V
	syscall
	li $v0, 5			# read_int
	syscall
	move $s1, $v0		# s1 = V
	
	add $s2 $s1, $zero	# s2 = sum
	li $t0, 1			# i = t0 = 1
loop: 
	beq $t0, $s0, exit	# if counter == N -> exit
	
	mul $t1, $t0, $t0		# i * i 
	div $t1, $s1		# i^2 % V
	mfhi $t2			# prendo resto
	bne $t2, $zero, else	# if  i^2 % V == 0 -> break
					# else -> else
	li $v0, 4
	la $a0, br
	syscall
	j exit 
	
else: 
	add $s2, $s2, $t1		# sum += i^2
	addi $t0, $t0, 1		# counter ++
	j loop			# fine for loop
	
exit: 
	li $v0, 1
	move $a0, $s2		# print_int sum
	syscall
	
	li $v0, 10
	syscall
	
	
	