# Exercise 3
# Max Score: 12 points
#
# students: Megan Zupancic and Annie Thiel
# Percent Effort: 50%, 50%
#
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
move  $a0, $t0   # moves $t0 into $a0         
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
# Write your answer HERE: 

#The tomato function first adjusts the stack pointer and decrements it by 8 because each word it 4 bytes long, so the stack pointer is pointing
#two words down from the top of the stack.
#One first iteration, t0 is stored as 8 (8 is the argument passed into the function stored in a1).
#The content of t0 is now stored in the stack.
#We then store the return address into the stack (this return address is the address after we call tomato from main). The address is stored with an offset 
#of 4 so that it is above the value of t0 in the stack. It is at the very beginning of the stack.
#Now, we will check if the value at a0 = 0; if it is not equal, the condition is satisfied so it jumps to the orange function.
#Once in the orange function, the value at a0 will be stored in t0.
#We will then call the tomato function again (and the address of the [lw] line is stored in ra)
#We will then adjust the stack again by opening 2 new spaces.
#Decrement t0 by 1.
#Repeat this process of the tomato and orange function until a0 = 0 (it will iterate 9 times). Once this occurs, we DO NOT GO TO ORANGE, but rather 
#continue in the tomato function.
#We will then load the stack pointer upwards 2 words, which points to [lw] location and jump to that location.
#0 is written into the t0 register.
#t1 = t1*4 -> t1 now stores the address of the first element of the array (and the stack pointer is pointing to that first element).
#The content of that address is read and the value is written into the t2 register.
#v0 becomes 3 on the first iteration.
#We now load the return address (which offsets 4 everytime we loop so that we can get to a new element in the array). AKA, the values that were stored 
#in the stack that are decretments by 1 help us access the values in the array by multiplying number by 4 to find offset
#Adjust the stack up by 2 words, so we go up the stack
#v0 = v0 + t2 ... v0 is continually updated (it is the sum of the array) untill we get to the top of the stack.
#Once we get to the top of the stack, we read the return address that jumps us back to the main function (because the return address in at the top of 
#the stack which calls back to the main)
