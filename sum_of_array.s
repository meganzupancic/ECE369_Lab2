# Exercise 
# 'sum_of_array.s' - This program performs the sum of the array
#  Max Score: 5 points
#
# Students: Megan Zupancic, Annie Thiel
#
#
# Insert your answers below each question:-
# 1(a) What is the address location of the first element of the array, X.
#      [10010000] 
#
# 1(b) What is the address location of the last element (element 7) of the array, X.
#      [10010020]
#      
# 2.   What are the values at location 'SUM' as the program executes?
#      0, 1
#      At the beginning 'SUM' is initialized to zero, but then it does not update again until after the loop when the running sum stored in $s1 is stored in 'SUM' as 1.
#      Therefore, 'SUM' is only updating at the beginning and then at the end after the loop.
#
# 3.   Traverse the program in single-step mode. Write down the intermediate 
#      values stored in register $s1 as the program progresses.
#      0, fffffffe, fffffffa, 1
#
# 4.   What is the purpose of register $t0 in this program?
#      $t0 temporarily holds the address of the current element.
#
#
.data                   	# Put Global Data here
N:      .word 3 		# 'N' is the address which contains the loop count, 5
X:      .word -2, -4, 7 	# 'X' is the address of the 1st element in the array to be added
SUM:    .word 0			# 'SUM' is the address that stores the final sum
str:    .asciiz "The sum of the array is = " 

.text				# Put program here 
.globl main			# globally define 'main' 

main: 
    lw      $s0, N		# load loop counter from the address location 'N' and stores into register $s0 
    la      $t0, X		# load the address of X and stores into register $t0 
    and     $s1, $s1, $zero	# performs 'AND' operation between $s1 and $zero, and stores the result into register $s1

loop: 
    lw      $t1, 0($t0)		# load the next value from address location, X+4 into register $t1
    addu     $s1, $s1, $t1	# add the next value to the running sum
    addi    $t0, $t0, 4 	# increment to the next address
    addi    $s0, $s0, -1	# decrement the loop counter 
    bne     $0, $s0, loop	# loop back to label 'loop' when $0 is not equal to $s0
    sw      $s1, SUM 		# store the final total sum into address location 'SUM'
    li      $v0, 10 		# syscall to exit cleanly from main only 
    syscall			# this ends execution 

.end
