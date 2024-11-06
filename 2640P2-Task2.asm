#Program 2: Practice with Conditionals and Loops
#CS2640.02 12PM
#Names: Andy Quach and Matthew Pena
#Date: 11/6/24
#Task 2:
#	a main label, a looping label, and an exit label
#	a loop counter
#

.data
messageX: .asciiz "Enter base number(x): "
messageY: .asciiz "Enter the exponent(y): "
result: .asciiz "Result of x to the power of y: "

.text
main:
	#print out message for x
	li $v0, 4
	la $a0, messageX
	syscall
	
	#get x from user input (x = $t0)
	li $v0, 5
	syscall
	move $t0, $v0
	
	#print message for y
	li $v0, 4
	la $a0, messageY
	syscall
	
	#get y from user input (y = $t1)
	li $v0, 5
	syscall
	move $t1, $v0
	
	#init loop counter to $t3 (to zero and we will add up in the loop)
	li $t3, 0	#using $t3 because $t2 will be used for the result
	li $t2, 1	#this sets t2 as 1 so we can multiply it later in the loop
loop:
	#loop condition
	beq $t3, $t1, exit
	
	#exponent arithmetic (x*x) for as many times as y
	mul $t2, $t2, $t0
	
	#loop counter++
	addi $t3, $t3, 1
	
	#jump back to start of loop
	j loop

#after loop ends we will print out the result	
exit:
	#printing result string
	li $v0, 4
	la $a0, result
	syscall
	
	#print $t2
	move $a0, $t2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall