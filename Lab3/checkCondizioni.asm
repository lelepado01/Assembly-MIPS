
	.data
a:	.asciiz "Inserisci a: "
b: 	.asciiz "Inserisci b: "
c: 	.asciiz "Inserisci c: "
errore: .asciiz "Errore!"
	.text
	.globl main
	
main:
	li $v0, 4			# print_string
	la $a0, a
	syscall
	li $v0, 5			# read_int
	syscall
	move $s0, $v0		# s0 = a
	
	li $v0, 4			# print_string
	la $a0, b
	syscall
	li $v0, 5			# read_int
	syscall
	move $s1, $v0		# s1 = b
	
	li $v0, 4			# print_string
	la $a0, c
	syscall
	li $v0, 5			# read_int
	syscall
	move $s2, $v0		# s2 = c
	
	
	beq $s2, $zero, else	# if c == 0 -> else
	blt $s0, $s1, else	# if a < b -> else 
	
	add $t0, $s0, $s1		# a + b
	mul $a0, $t0, $s2		# c * (a + b)
	
	li $v0, 1			# print_int
	syscall
	
	j exit 

else: 
	li $v0, 4			# print_string
	la $a0, errore
	syscall

exit: 
	li $v0, 10
	syscall
	