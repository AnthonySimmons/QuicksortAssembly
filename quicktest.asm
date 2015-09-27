.data
start: 
	.word 5, 5 4 3 2 1
	.space 40
	
	.word 5, 9 3 3 2 5
	.space 40
	
	.word 9, 2 21 4 95 0 2 56 3 11
	.space 24
	 
	.word 8, 1 1 1 8 9 8 0 6
	.space 28
	
	.word 10, 2 0 6 3 5 1 2 5 8 2
	.space 20
	
	.word 0
	.space 60

	.word 1, 1
	.space 56
	
	.word 9, 9 8 7 6 5 4 3 2 1
	.space 24
	
	.word 15, 45 0 7 94 3 53 100 2 12 98 34 2 100 0 28
	.space 0
	
	.word 12, 1 1 1 1 1 1 1 1 1 1 1 0
	.space 12

end:
# Z = 16 words = 64 bytes
.text
.globl quicktest

quicktest:
addi $sp, $sp, -4	# Save $ra
sw $ra, 0($sp)

la $a0, start		# $s0 -> index
la $t1, end
testLoop:		
bge $a0, $t1, testDone	

lw $a1, 0($a0)
addi $a0, $a0, 4
li $a2, 0

addi $sp, $sp, -12	# Save 
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $t1, 8($sp)

jal print_array_withz	# Print Unsorted

lw $a0, 0($sp)
lw $a1, 4($sp)

jal quicksort		# Sort

lw $a0, 0($sp)
lw $a1, 4($sp)

jal print_array_withz	# Print Sorted

jal endl

lw $t1, 8($sp)		# Recover
lw $a1, 4($sp)
lw $a0, 0($sp)
addi $sp, $sp, 12

addi $a0, $a0, 60
j testLoop
testDone:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
