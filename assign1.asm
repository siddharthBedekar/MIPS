#2.9
sll $t3, $s3, 2 #multiply i by four (since each word is 4 bytes)
sll $t4, $s4, 2 #multiply j by four

add $t1, $t3, $s6 #(4*i + base_Address_A) = (address of A[i]) -> $t1
lw $t1, 0($t1) #load A[i] into $t1
add $t5, $t1, $zero #$t5 = A[i]

add $t2, $t4, $s6 #(4*j + base_Address_A) = (address of A[j]) -> $t2
lw $t2, 0($t2) #load A[j] into $t2
add $t5, $t2, $t5 #t5 = A[i] + A[j]

sw $t5, 32($s7) #store the final value into B[8]
