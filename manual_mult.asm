.data
prompt1: .asciiz "Please enter the first signed (decimal) integer: "
prompt2: .asciiz "Please enter the second signed (decimal) integer: "
result_msg: .asciiz "The result of these two 16-bit integers\' multiplication is: "
.text
.globl main
main:
      li $v0, 4        #print prompt
      la $a0, prompt1
      syscall

      li $v0, 5        #read multiplicand 
      syscall
      move $s0, $v0

      li $v0, 4        #print prompt
      la $a0, prompt2
      syscall

      li $v0, 5      #read multiplier
      syscall
      move $s1, $v0

Mult: ori $t0,$zero,1  #mask
      move $s3, $0    #initialize the result register
      move $t1, $0


loop: beq $s1, $zero, exit  #if the multiplier is 0 then finished
      and $t1, $t0, $s1      #mask
      beq $t1, 1, mult_add   
      beq $t1, 0, shift

mult_add:  addu $s3, $s3, $s0     #add to get product

shift: 
      sll $s0, $s0, 1    #shift multiplicand left
      srl $s1, $s1, 1    #shift multiplier right

      j loop

exit:
      li $v0, 1            #input result
      move $a0, $s3
      syscall

      li $v0, 10        #exit
      syscall
