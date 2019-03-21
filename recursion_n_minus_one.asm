li $a0, 5
jal sum

j endthis

sum:
	addi $sp, $sp, -4 #allocate room for ra
	sw, $ra, 0($sp) #store ra onto stack
	
	beq $a0, $zero, done 
	add $v0, $v0, $a0 #add n + sum(n-1)
	addi $a0, $a0, -1 #decrement n
	jal sum
	
	done:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
endthis: