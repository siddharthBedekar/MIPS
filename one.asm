.data
hello: .asciiz "Hola !"



.text
li $v0,4	#li for constants, 4 = print string
la $a0,hello	#la for variables; a0 holds arguments
syscall

li $v0,10 #end of code
syscall
