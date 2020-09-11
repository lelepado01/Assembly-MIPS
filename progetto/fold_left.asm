	.data
	
	.text
	.globl foldl

# a0 contiene l'indirizzo base dell'array
# a1 contiene l'ID della funzione (0 = addizione, 1 = max)
# a2 contiene valore iniziale dell'accumulatore
# a3 contiene len array 
			
foldl: 
	addi $sp, $sp, 4
	sw $ra, 0($sp)

	lw $t0, 0($a0)
	
	# salvo stato per chiamata
	addi $sp, $sp, 4
	sw $a0, 0($sp)
	addi $sp, $sp, 4
	sw $a1, 0($sp)
	
	beq $a1, 1, jmp_max		# if func == MAX
	
	beq $a1, 2, jmp_mult		# if func == MULT
	
	move $a0, $t0			# operando 1 == valore in array
	move $a1, $a2			# operando 2 == accumulatore
	
	jal addition			# else ADDITION
	
	move $a2, $v0			# accumulatore diventa il risultato della chiamata
	
	lw $a1, 0($sp)
	addi $sp, $sp, -4
	lw $a0, 0($sp)
	addi $sp, $sp, -4
	
	j continue

jmp_mult: 
	move $a0, $t0
	move $a1, $a2

	jal multiplication	

	move $a2, $v0
	
	lw $a1, 0($sp)			# ripristino i registri dopo la procedura
	addi $sp, $sp, -4
	lw $a0, 0($sp)
	addi $sp, $sp, -4
	
	j continue

jmp_max: 
	move $a0, $t0			# operando 1 == valore in array
	move $a1, $a2			# operando 2 == accumulatore

	jal max	

	move $a2, $v0
	
	lw $a1, 0($sp)
	addi $sp, $sp, -4
	lw $a0, 0($sp)
	addi $sp, $sp, -4
	
	j continue
			
continue: 
	addi $a0, $a0, 4
	subi $a3, $a3, 1
	beqz $a3, ret
	
	jal foldl

ret: 					# termine dell'iterazione ricorsiva
	move $v0, $a2
	lw $ra, 0($sp)
	addi $sp, $sp, -4
	jr $ra
	

