
#void quicksort(int *A, int length)
#	if(length > 1)
#		int *x = Partition(A, A+(4*length)-4);
#		quicksort(A, (x-A)/4);	
#		quicksort(x+4, (A+(4*length)-x-4)/4);

		
#	 |0|1|2|3|4|5|6|
#	  A	  x

#	$a0 -> A	$a1 -> length
#	$v0 -> x	$t4 -> A+length-1
#	$t3 -> 4*length

.text
.globl 	quicksort
quicksort:
addi $sp, $sp, -12	# Save $ra, *A, length
sw $ra, 0($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)

ble $a1, 1, Exit	# if(length > 1)

addi $t4, $a0, -4	# $t4 -> A-4
mul $t3, $a1, 4		# $t3 -> length * 4
add $t4, $t4, $t3	# $t4 -> A+(4*length)-4
move $a1, $t4
jal partition		# partition(A, A+(4*length)-4)
			# Now: $v0 -> x
lw $a0, 4($sp)
lw $a1, 8($sp)

addi $sp, $sp, -4
sw $v0, 0($sp)

sub $a1, $v0, $a0	# $a1 -> x-A
div $a1, $a1, 4		# $a1 -> (x-A)/4
jal quicksort		# quicksort(A, x-A)
			
lw $v0, 0($sp)
addi $sp, $sp, 4

lw $a0, 4($sp)
lw $a1, 8($sp)

mul $a1, $a1, 4		# $a1 -> 4*length
add $a1, $a0, $a1	# $a1 -> A+(4*length)
sub $a1, $a1, $v0	# $a1 -> A+(4*length)-x
addi $a1, $a1, -4	# $a1 -> A+(4*length)-x-4
div $a1, $a1, 4		# $a1 -> (A+(4*length)-x-4)/4

addi $a0, $v0, 4	# $a0 -> x+4

jal quicksort		# quicksort(x+4, A+(4*length)-x-4)

Exit:
lw $a1, 8($sp)		# Recover 
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 12
jr $ra			# return