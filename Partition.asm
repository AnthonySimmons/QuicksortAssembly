#int* Partition(int *lo, int *hi)
#	int *i = lo;
#	int *j = hi;
#	if(hi - lo < 4)
#		return lo, hi;
#	int PV = *hi;	
#	j -= 4;
#	while(i <= j)
#		while(*i < PV)
#			i += 4;
#		while(*j > PV)
#			j -= 4;
#		if(i <= j)
#			swap(i, j);
#			i += 4;
#			j -= 4;
#	swap(i, hi);
#	return i, j;

#	$a0 -> lo	$a1 -> hi
#	$v0 -> i	$v1 -> j
#	$s2 -> *i	$s3 -> *j
#	$t0 -> PV	$t1 -> hi - lo
# 	$t2 -> *hi	

.globl partition
.text
partition:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $a1, 4($sp)

move $v0, $a0		# int *i = lo
move $v1, $a1		# int *j = hi
move $t2, $a1		# $t2 -> *hi

sub $t1, $a1, $a0	# $t1 -> hi - lo
bge $t1, 4, next	# if(hi - lo < 4)

lw $a1, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 8
addi $v1, $a1, 4

jr $ra			# return
next:
lw $t0, 0($a1)		# PV = *hi
addi $v1, $v1, -4	# j -= 4
BigLoop:
bgt $v0, $v1, Out	# while(i <= j)
Loop1:
lw $s2, 0($v0)		# $s2 -> *i
bge $s2, $t0, Loop2	# while(*i < PV)
addi $v0, $v0, 4	# i += 4
j Loop1

Loop2:
lw $s3, 0($v1)		# $s3 -> *j
ble $s3, $t0, Done	# while(*j > PV)
addi $v1, $v1, -4	# j -= 4
j Loop2
Done:
bgt $v0, $v1, next1	# if(i <= j)

move $a0, $v0
move $a1, $v1
jal swap		# swap(i, j)
addi $v0, $v0, 4	# i += 4
addi $v1, $v1, -4	# j -= 4
next1:
j BigLoop
Out:
move $a0, $v0		
move $a1, $t2
jal swap		# swap(i, hi)

lw $a1, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 8
addi $v1, $a1, 4

jr $ra
