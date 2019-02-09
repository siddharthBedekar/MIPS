.data
num1: .byte 5
num2: .word 3

.text
lw $t0,num1 #store num1 in t0
lw $t1,num2

add $t2,$t0,$t1 # store num1+num2 into $t2

li $v0,1 #print integer
move $a0,$t2 #move contents of $t2 into $a0
syscall
