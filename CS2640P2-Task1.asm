#Program 2: Practice with Conditionals and Loops
#CS2640.02 12PM
#Names: Andy Quach and Matthew Pena
#Date: 11/6/24
#Task 1: Write a program that will return a letter grade given a Decimal int from the user.
#Include the following: 
#	a user menu 
#	main label loop label, and an exit label
#	Continue and exit prompts
#	Invalid input handling (not just an error message; reprompt until user input is valid)

.data
menu: .asciiz "\n--------Main Menu--------\n(1)Get Letter Grade\n(2)Exit Program\nPlease select an option number: "
gradePrompt: .asciiz "\nEnter a grade as an integer: "
reprompt: .asciiz "\nWould you like to enter another score?\nYes(Y)  No(N)\nEnter 'Y' or 'N' for your selection: "
errorHandle: .asciiz "Invalid Option. Please try again.\n"
errorHandle2: .asciiz "\n\nChoose either 'Y' or 'N'. Be mindful of capitalization.\n"
exitPrompt: .asciiz "Exiting Program..."
resultA: .asciiz "The letter grade is: A\n-------------------------"
resultB: .asciiz "The letter grade is: B\n-------------------------"
resultC: .asciiz "The letter grade is: C\n-------------------------"
resultD: .asciiz "The letter grade is: D\n-------------------------"
resultF: .asciiz "The letter grade is: F\n-------------------------"
invalidScore: .asciiz "\nThe letter grade must be an integer greater than 0. Please try again."

#ASCII Value for Y - 89
#ASCII Value for N - 78

.text
#Required Label
main:
	#Initialize $s1 and $s2 to 'Y' and 'N' ASCII values, respectively
	li $s0, 89
	li $s1, 78

	#Print menu prompt
	li $v0, 4
	la $a0, menu
	syscall
	
	#Get user input
	li $v0, 5
	syscall
	
	#Store user input
	move $t0, $v0
	
	beq $t0, 1, letterGrade
	beq $t0, 2, exit
	
	#Invalid option; reprompt
	li $v0, 4
	la $a0, errorHandle
	syscall
	
	bgt $t0, 2, main
	blt $t0, 1, main
	
letterGrade:
	#Print letter grade prompt
	li $v0, 4
	la $a0, gradePrompt
	syscall
	
	#Get user input
	li $v0, 5
	syscall
	
	#Store letter grade
	move $s2, $v0
	
	#Branch to letter grade based on user input
	bge $s2, 90, LabelA
	bge $s2, 80, LabelB
	bge $s2, 70, LabelC
	bge $s2, 60, LabelD
	bge $s2, 0, LabelF
	
	#Error Handling - Score less than 0
	li $v0, 4
	la $a0, invalidScore
	syscall
	
	#Jump to letterGrade label to try again
	j letterGrade
	
LabelA:
	#Print letter grade
	li $v0, 4
	la $a0, resultA
	syscall
	
	#Jump to reprompt loop
	j loop

LabelB:
	#Print letter grade
	li $v0, 4
	la $a0, resultB
	syscall
	
	#Jump to reprompt loop
	j loop

LabelC:
	#Print letter grade
	li $v0, 4
	la $a0, resultC
	syscall
	
	#Jump to reprompt loop
	j loop

LabelD:
	#Print letter grade
	li $v0, 4
	la $a0, resultD
	syscall
	
	#Jump to reprompt loop
	j loop
	
LabelF:
	#Print letter grade
	li $v0, 4
	la $a0, resultF
	syscall
	
	#Jump to reprompt loop
	j loop

#Required Label
loop:
	#Reprompt user for new score
	li $v0, 4
	la $a0, reprompt
	syscall
	
	#Get Selection from user
	li $v0, 12
	syscall
	
	#Store user input
	move $t1, $v0
	
	#Loop back to branch based off of user input 
	beq $t1, $s0, letterGrade
	beq $t1, $s1, main

	#If user input is not 'Y' or 'N', branch to error label
	bne $t1, $s0, error
	bne $t1, $s1, error

error:
	#Invalid option; reprompt for 'Y' or 'N'
	li $v0, 4
	la $a0, errorHandle2
	syscall
	
	#Jump back to reprompt loop
	j loop

#Required Label
exit:
	#Print Exit Prompt
	li $v0, 4
	la $a0, exitPrompt
	syscall
	
	#Exit Program
	li $v0, 10
	syscall
	

	