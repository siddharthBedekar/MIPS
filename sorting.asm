#--------------------------------------------------
# SAMPLE SORTING Algorithm
# 
#--------------------------------------------------
#
# A[0:7] = [7, 6, ..., 1, 0]; % numbers to sort

# for (int i=N; i>0; i--) {
# for (int j=N-1; j>0; j--) {
# if ( A[j] > A[j+1] ) {
# % perform the swap
# temp = A[j+1];
# A[j+1] = A[j];
# A[j] = temp; }
# }
# }

 .data
 A: .word 7, 6, 5, 4, 3, 2, 1, 0 

 message1: .asciiz "We're done ! for N = "

 .text
 # initialize 2 main variables in the $s (saved) registers
 # variables: address A[0] and value N
 la $s0,A # $s0 has address of A[0]
 li $s1,8 # $s1 has value N (fixed)
 

 addi $t0,$t0,8 # initialize $t0, down-counter i for outer loop

 loop1:
 # we are at the top of the outer loop
 # here, we initialize variables for inner loop
 # for the inner loop, lets use the $t (temporary) registers
 addi $t4,$s0,0 # $t4 is pointer A[j], initially A[0]
 addi $t5,$s1,0 # $t5 is the down-counter j for inner loop 

 loop2:
 # we are at the top of the inner loop
 # next few lines load A[j] and A[j+1]
 # lets use the $t (temporary) registers
 lw $t1,0($t4) # $t1 has A(j)
 lw $t2,4($t4) # $t2 has A(j+1)
 sub $t3,$t1,$t2 # compute difference A(j)-A(j+1)
 bltz $t3, noswap # A(j)<A(j+1)
 sw $t1,4($t4) # store A[j] into A[j+1]
 sw $t2,0($t4) # store A[j+1] into A[j]
 noswap:
 # we are at the bottom of the inner loop
 # update variable j and pointer A[j] and repeat loop if necessary
 addi $t4,$t4,4 # increment pointer A[j]
 subi $t5,$t5,1 # decrement down-counter j
 bgtz $t5,loop2 # repeat inner loop if needed

 Done2:
 # we are at the bottom of the outer loop
 # update variable i and repeat loop if necessary
 subi $t0,$t0,1  # decrement outer loop down-counter i
 bgtz $t0, loop1 # repeat outer loop if needed

 # display done message
 li $v0,4 # tell OS to print message
 la $a0,message1
 syscall

 # display the number N
 li $v0,1       # tell OS to print an integer
 addi $a0,$s1,0 # $s1 stored the value N
 syscall

 # tell OS that we have reached end of program
 li $v0,10
 syscall
