# Exercise 2
#  Max Score: 9 points
#
# Students: Megan Zupancic, Annie Thiel
#
# 'count_occurence.a' - count the occurrences of a specific character in string 
# "str". Indexed addressing is used to access the array elements.
#  MAX Score: 15 points
# Expected Outcome:- 
# The following string will be printed on the console,
# "Count is 6"
#
# Questions:-
# 1. Briefly describe the purposes of the registers, $t0, $t1, $t2, and $t3.
#    $t0 stores the current character in 'str' at the index stored in $t1. 
#    $t1 holds the index of which character the loop is at in 'str'.
#    $t2 stores the count of occurrences of the specific character in 'str'.
#    $t3 holds the specific character that we want to count the number of occurrences of.
#
# 2. Currently, the program is stuck in an infinite loop. Make use of 
#    breakpoints to locate, and correct the error.
#    Changed the line "add $t1, $t2, 1" to "add $t1, $t1, 1"

	.text

	.globl main

main:	

	li      $t1, 0          # initialize register $t1 to '0'
	li      $t2, 0          # initialize register $t2 to '0'
	lb      $t3, char       # initialize register $t3 to 'char'

loop:

    lb      $t0, str($t1)	# fetch a character in 'str'
	beqz    $t0, strEnd	    # if a null character is fetched, exit the loop
	bne     $t0, $t3, con   # branches to 'con' if registers $t0, and $t3 are not the same
	add     $t2, $t2, 1	    # increment register $t2

con:	

    add     $t1, $t1, 1	    # increase indexing register $t1     #this is where fixed the error, changing the original line "add $t1, $t2, 1" to "add $t1, $t1, 1"
	j       loop	       	# continues the loop

strEnd:

	la      $a0, ans        # load $a0 with the address of the string, 'ans'
	li      $v0, 4	        # trap code, '4', refers to 'print_string' system call
	syscall                 # execute the system call

	move    $a0, $t2        # move the integer to print from register $t2->$a0
	li      $v0, 1	        # trap code, '1', refers to 'print_int' system call
	syscall		            # execute the system call

	la      $a0, endl	    # load $a0 with the address of the string, 'ans'
	li      $v0, 4	        # trap code, '4', refers to 'print_string' system call
	syscall                 # execute the system call

	li      $v0, 10         # terminate the program
	syscall


	.data

str:	.asciiz "abceebceebeebbacacb"
char:	.asciiz "e"
ans:	.asciiz "Count is "
endl:	.asciiz "\n"

