	.data
datalen:
	.word	0x10	# 16
data:
	.word	0xffff7e81 #0
	.word	0x00000001 #1
	.word	0x00000002 #2
	.word	0xffff0001 #3
	.word	0x00000000 #4
	.word	0x00000001 #5
	.word	0xffffffff #6
	.word	0x00000000 #7
	.word	0xe3456687 #8
	.word	0xa001aa88 #9
	.word	0xf0e159ea #10
	.word	0x9152137b #11
	.word	0xaab385a1 #12
	.word	0x31093c54 #13
	.word	0x42102f37 #14
	.word	0x00ee655b #15
	
	.word 0x0
	
	#Rubber ducky troubleshooting, förklara för dig själv vid varje rad vad som ska hända
		
sort_alg:	.asciiz	"Sorting the array with the sorting algorithm 'Insertion Sort'...\n \n"
NL:		.asciiz	"\n"

.text 

main:

lw	$t7, datalen # get size of list




#sort start
la	$a0, NL
li	$v0, 4
	syscall	
la	$a0, sort_alg
li	$v0, 4
	syscall	

move	$t0, $0
add	$s1, $0, 4 #the address J
add	$s0, $0, 0 #the address I

sort:
bgt	$t0, $t7, print
lw	$t1, data($s1) #j
lw	$t2, data($s0) #i

move	$t4, $s0 #
move	$t3, $s1 #temp value of the J and I address I can change without affecting the main loop

add	$s0, $s0, 4
add	$s1, $s1, 4
add	$t0, $t0, 1 #increasing the values so it goes through the entire array

compare:
bltz	$t4, place #if the address is below zero, it'll place the current value in the bottom
bge	$t1, $t2, place # if the value to the right is bigger, then it'll move on to the next item

sw	$t2, data($t3) #move the bigger numbers forward and keep going until it hits a smaller number
sub	$t3, $t3, 4
sub	$t4, $t4, 4
lw	$t2, data($t4)
j compare

place:
sw	$t1, data($t3) #safety measure if the address goes below 0 or if the current value doesn't need to move
j sort

move	$t1, $0
move	$t2, $0
print:


beq	$t1, $t7, exit_loop #loop to print out the array
mul	$t2, $t1, 4
lw	$a0, data($t2)
li	$v0, 1
	syscall
	
la	$a0, NL
li	$v0, 4
	syscall
		
add	$t1, $t1, 1
j print
exit_loop:
#sort stop



ori	$v0, $0, 10
	syscall
	
