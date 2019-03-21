.data
m1: .asciiz "Enter number A: "
m2: .asciiz "Enter number B: "
n1: .word 0
n2: .word 0
answer: .word 0
.text

li $v0, 4 #OS print
la $a0,m1 #print m1
syscall
li $v0, 6 #read float - stored in $v0
syscall
swc1 $f0, n1 #store into memory address of n1

li $v0, 4 #OS print
la $a0,m2 #print m2
syscall
li $v0, 6 #read float - stored in $v0
syscall
swc1 $f0, n2 #store into memory address of n2

lw $a0, n1 #store parameters
lw $a1, n2
jal fl_mult #function call

mtc1 $v0, $f12
li $v0, 2 #OS print result
syscall

li $v0,10  #end of code
syscall

#float mult code
fl_mult: 
andi $t0, $a0, 0x7F800000 #extract exponents for a
andi $t1, $a1, 0x7F800000 #extract exponents for b
srl $t0, $t0, 23 #shift right 23 bits for a
srl $t1, $t1, 23 #shift right 23 bits for b
addi $t1, $t1, -127 #remove bias for one

andi $t2, $a0, 0x007FFFFF #extract fraction a
andi $t3, $a1, 0x007FFFFF #extract fraction b
ori $t2, $t2, 0x00800000 #add implicit 1 to a 
ori $t3, $t3, 0x00800000 #add implicit 1 to b 
srl $t2,$t2,8 #shift to make 16 bits
srl $t3,$t3,8#shift to make 16 bits

#integer multiplication
i_mult: li $t4, 1  #mask = 00...001
      move $t5, $0  #result
      move $t6, $0  #will hold result of (mask)&($t2)


loop: beq $t3, $zero, im_done   #done if multiplier is 0
      and $t6, $t4, $t3      #apply mask
      beq $t6, 1, im_add   #add if 1
      beq $t6, 0, im_shift      #dont add if 0

im_add:  addu $t5, $t5, $t2     #add to get product

im_shift: 
      sll $t2, $t2, 1    #shift multA left
      srl $t3, $t3, 1    #shift multB right
      j loop


im_done:
li $t3, 0 #count shifts
adjustPos:
srl $t5, $t5, 1
ori $t2, $t5, 0x00FFFFFF #mask for checking MSB position
addi $t3, $t3, 1
beq $t2, 0x00FFFFFF, noshift
bne $t2, 0x00FFFFFF, adjustPos 

noshift:
add $t7, $t0, $t1 #add the exponents
add $t7, $t7, $t3 #add shifts
subi $t7,$t7,7
sll $t7, $t7, 23 #place exponent in correct position
andi $t7, $t7, 0x7F800000

andi $t5, $t5, 0x007FFFFF #remove implicit 1
or $t7, $t7, $t5 #place fraction into final answer

xor $t8, $a0, $a1 #sign
andi $t8, $t8, 0x80000000 #remove all other values except sign
or $t7, $t7, $t8  #place correct sign
move $v0, $t7

jr $ra
