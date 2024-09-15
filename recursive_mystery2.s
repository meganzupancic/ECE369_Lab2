# Exercise 3
# Max Score: 12 points
#
# students: Megan Zupancic and Annie Thiel
# Percent Effort: 50%, 50%
#
.data	
list1:		.word		3, 9, -1, 0, 6, 5, -4, -7, -8,  
list2:		.word		9, 5, 0, 3, -4, 5, 6, -7, 8, 9, 
.text
.globl	tomato
tomato: 
addi	$sp, $sp, -8       
addi	$t0, $a0, -1       
sw  	$t0, 0($sp)        
sw  	$ra, 4($sp)        
bne 	$a0, $zero, orange   
li  	$v0, 0             
addi	$sp, $sp, 8        
jr 	$ra                  

orange:   
add  $a0, $0, $t0            
jal   tomato 
lw    $t0, 0($sp)  
sll	$t1, $t0, 2  
add   $t1, $t1, $a1     
lw    $t2, 0($t1)
slt   $t3, $t2, $a2
bne   $t3, $0, carrot      
add   $v0, $v0, $t2 

carrot:    
lw    $ra, 4($sp)                
addi 	$sp, $sp, 8        
jr 	$ra                      
########################################################################
.globl	test
test:	
addi	$sp, $sp, -4	# Make space on stack
sw	$ra, 0($sp)		# Save return address
jal	tomato		# call function
lw	$ra, 0($sp)		# Restore return address
addi	$sp, $sp, 4		# Restore stack pointer
jr 	$ra			# Return
########################################################################
# main function starts here                                            #
.globl main
main:	addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)		# Save return address
	la	$a1, list2	
	li	$a0, 8
      li    $a2, 5		
	jal	test		
# What is the value of $v0 at this point? (v0)= 19 in hexadecimal (25 in decimal)       #
	la	$a1, list1	
	li	$a0, 13		
	jal	test		
# What is the value of $v0 at this point?	(v0) = 22 in hexadecimal (34 in decimal)      #
# What does this code compute? Your answer HERE: The loop goes through list2 first and does the following: 
# First the tomato function makes space for 8 words in the stack. Then the orange
# function puts the first 8 value from list2 and their correspodning addressess into the stack. Also in the orange function,
# for each value, if the value >= 5 then it is added to a running sum in $v0. The same process then occurrs with list1, however, 
# &a0 is now 13 which then causes tomato to create 13 spaces in the stack and orange then fills those spaces with every value and its 
# corresponding address from list1 then the first 4 values and their corresponding address from list2, since list1 only has 9 values.
# The sum in $v0 is calculated the same way. 
# 

return:	
li	$v0, 0		# Return value
	lw	$ra, 0($sp)		# Restore return address
	addi	$sp, $sp, 4		# Restore stack pointer
	jr 	$ra			# Return	
