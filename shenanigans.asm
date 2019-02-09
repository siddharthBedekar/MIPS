andi $t0, $t0, 0x0001F800 #AND $t0 with mask to store only bits[16:11]
sll $t0, $t0, 15 #shift left to line up with bits [31:26]

andi $t1, $t1, 0x03FFFFFF #clear bits [31:26]
or $t1, $t0, $t1 #use OR to copy bits[31:26] in and leave the others the same
