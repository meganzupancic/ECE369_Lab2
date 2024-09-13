# Exercise 3
# Max Score: 12 points
.data	
list1:		.word		3, 9, 1, 2, 6, 3, -4, -7, -8, 4, -2,  8, 7, 6
.text 		# list1 is an array of integers storing the given sequence of values	 
.globl	tomato
tomato: 
addi	$sp, $sp, -8     # makes room for 2 words in the stack  
addi	$t0, $a0, -1     # store (a0 - 1) into $t0 (in main a0 is set to 9) 
sw  	$t0, 0($sp)      # (a0 - 1) stored into the stack 
sw  	$ra, 4($sp)      # the return address is stored in the stack
bne 	$a0, $zero, orange   # if (a0 - 1) =/= 0, go to orange
li  	$v0, 0             
addi	$sp, $sp, 8      # pop top 2 words off stack 
jr 	$ra                  
orange:   
move  $a0, $t0            
jal   	tomato   # will loop back to tomato until a0 == 0
lw    	$t0, 0($sp)  # 1st visit to this line: t0 = -1 (ffffffff)
sll	$t1, $t0, 2  
add   	$t1, $t1, $a1     # puts address of first element of array into t1
lw    	$t2, 0($t1)       # loads the value at address t1 into t2. At first visit, the value is 3 (t2 = 3) because 3 is first element in list
add   	$v0, $v0, $t2     # possibly a sum. adds the value in t2 into v0
lw    	$ra, 4($sp)       # stores return address into stack         
addi 	$sp, $sp, 8       # pop off top 2 words from stack 
jr 	$ra               # jump to return address (jump to line 19)
# main function starts here                                            						
.globl main
main:	
    addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)	# Save return address
	la	$a1, list1	# a1 has the base address pointing to the first 
# element of the “list1” array declared in .data section above
	li	$a0, 9		# loads the immediate value into the destination register
	jal	tomato	
return:	
li	$v0, 0			# Return value
	lw	$ra, 0($sp)		# Restore return address - puts new return address into stack
	addi	$sp, $sp, 4		# Restore stack pointer  
	jr 	$ra			# Return
# Step through this code in your simulator and monitor the register values. 
# What does the tomato function do?   
# Write your answer HERE: the tomato function stores the first 9 addresses of the arrary into the stack #                
