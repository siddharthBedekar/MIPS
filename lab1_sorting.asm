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
	lw $t0, N  #t0 ==> iterator for beginSort; 
	srl $t0, $t0, 1 #divide by 2
	lw $t1, N  #t1 ==> iterator for oddSort
	addi $t1, $t1, -2 #odd starts at N-2
	lw $t2, N   #t2 ==> iterator for evenSort
	addi $t2, $t2, -3 #even starts at N-3
	b beginSort
	  
beginSort:
	




done: 	li $v0,10	#end of code
	syscall