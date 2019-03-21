li $t2, 7 #multiplicand
li $t3, 5#multiplier

Mult: li $t4, 1  #mask = 00...001
      move $t5, $0  #result
      move $t6, $0  #will hold result of (mask)&($t2)


loop: beq $t3, $zero, done  #if the multiplier is 0 then finished
      and $t6, $t4, $t3      #mask
      beq $t6, 1, mult_add   
      beq $t6, 0, shift

mult_add:  addu $t5, $t5, $t2     #add to get product

shift: 
      sll $t2, $t2, 1    #shift multA left
      srl $t3, $t3, 1    #shift multB right
      j loop

done:
