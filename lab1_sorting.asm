.data
N: .word 0

enterN: .asciiz "Enter N:"

.text
li $v0, 4 #print
la $a0, enterN #store N into $a0
syscall
li $v0, 5 #ask for N and store in $v0
syscall
sw $v0, N #store into address of N

#allocate memory for array
sll $a0 $t0 2 #store N*4 into $a0
li  $v0, 9 #allocate N*4 bytes in memory
syscall 
move $t9, $v0 #store address of array into $t9

move $t2, $t9 #move address of ar[i] into $t2
lw $t0, N #load N into $t0 as an iterator (also the number we are storing)
createList:
	addi $t0, $t0, -1 #subtractact 1 from iterator
	sw $t0, 0($t2) #store the value of the i into ar[i]
	addi $t2, $t2, 4 #i += 1
	beq $zero, $t0, setupInitialValues #done if i == 0
	b createList

setupInitialValues:
	lw $s0, N #s0 is the iterator for outer loop (i)
	srl $s0, $s0, 1 # $s0 = N/2 

	move $s1, $t9  #s1 ==> address iterator for evenSort
	lw $t0,N #load N into $t0
	addi $t0, $t0, -2 # t0 = N-2
	move $s3, $t0 #counter j = N-2
	sll $t0, $t0, 2  # t0 = 4*(N-2)
	add $s1, $s1, $t0 # addr(a[j])+ 4*(N-2) = a[N-2]
	
	move $s2, $t9   #s2 ==> address for oddSort a[
	lw $t0,N #load N into $t0
	addi $t0, $t0, -3 # t0 = N-3
	sll $t0, $t0, 2  # t0 = 4*(N-3)	
	add $s2, $s2, $t0 #addr(a[j])+ 4*(N-3) = a[N-3]
	b beginSort
	  
beginSort:
	oddSort:
		move $t0, $s1 #t0 = address of a[j]
		addi $t0, $t0, 4 # t0 = address of a[j+1]
		lw $t1,0($s1) #load a[j] 
		lw $t2,0($t0) #load a[j+1] 
		blt $t1, $t2, noswap #jump to noswap if a[j] < a[j+1]
		
		#swapping
		sw $t2, 0($s1)
		sw $t1, 4($s1)
	noswap:
		addi $s1, $s1, -8 #decrement address by 2
		addi $s3, $s3, -1 #j=j-2
		bge $s3, $zero, oddSort


done: 	li $v0,10	#end of code
	syscall

