.globl swap
.text

#	$a0 -> word* I		$a1 -> word* J	
swap:

lw $t6, 0($a0)	
lw $t7, 0($a1)	
sw $t6,	0($a1)
sw $t7,	0($a0)


jr $ra