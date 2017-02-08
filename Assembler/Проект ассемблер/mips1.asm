.data

# Stores the name of the file the user entered
Filename: .space 52

# Number of notes in the song to be played
NumberOfNotes: .space 4

# Size of memory which needs to be allocated on the heap
SizeOfHeap: .space 4

# Number of channels
NumberOfChannels: .space 4

# Used for displaying messages to the user
PleaseChooseASong: .asciiz "Please type the name of the file you wish to play:"
PlayAnotherSong: .asciiz "Would you like to play another song?"
ErrorMessage: .asciiz "Song not found!"

# Characters used for removing new line from the end of the entered string
NewLine: .ascii "\n"
NullTerminator: .ascii "\0"

# MIPS code begins here
.text 

# Jump straight to the beginning of the program
j EntryPoint 

# This is called from EntryPoint
BeginSong:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Set up a counter of how many notes we have played. $t0 contains our counter, $t1 is ntoes to play
	li $t0, 0
	lw $t1, NumberOfNotes

	# This loops around over and over and over and over until the song has finished playing
	NotePlayingLoop:

		jal LoadNote
		jal PlayNote

		# Add one to the counter
		addiu $t0, $t0, 1

		# If a note's duration is 0 it means we have reached the end of the file
		bne $t0, $t1, NotePlayingLoop 

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# This is called from BeginSong
LoadNote:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Load the note
	lw $a0, 0($s2) # The note's pitch
	lw $a2, 4($s2) # The note's channel
	lw $a3, 8($s2) # The note's volume
	lw $a1, 12($s2) # The note's duration
	lw $t3, 16($s2) # How long to wait until we play the next note

	# Increase the memory address ready for next time we have to read the note
	addi $s2, $s2, 20

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# This is called from BeginSong
PlayNote:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Load the correct syscall
	li $v0, 37

	# Note data is loaded in LoadNote, so just syscall
	syscall

	# Sleep until the next note should be played
	li $v0, 32 # syscall 32
	move $a0, $t3 # We stored how long to sleep for in $t3 when we loaded the note
	syscall

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# Called from EntryPoint
StoreInMemory:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Open the file
	li $v0, 13 # Syscall
	la $a0, Filename # Name of file to read from
	li $a1, 0 # Set it to read from the file
	li $a2, 0 # Ignored apparantly
	syscall

	# If the file does not exist then display an error box
	bltz $v0, DisplayErrorBox

	# If it gets here it means the file has succesfully opened. Store the file descriptor in $s3
	move $s3, $v0

	# Read in the first 4 bytes (The total amount of memory needed to be stored on the heap), store it at label SizeOfHeap
	li $v0, 14
	move $a0, $s3
	la $a1, SizeOfHeap
	li $a2, 4
	syscall

	# Allocate the amount of heap memory we just read
	li $v0, 9
	lw $a0, SizeOfHeap
	syscall
	move $s2, $v0

	# Read in the next 4 bytes (The number of notes in the file), store this at label NumberOfNotes
	li $v0, 14
	move $a0, $s3
	la $a1, NumberOfNotes
	li $a2, 4
	syscall

	
	# Read in the next byte (Number of channels to be used), and store it label NumberOfChannels
	li $v0, 14
	move $a0, $s3
	la $a1, NumberOfChannels
	li $a2, 1
	syscall

	# We need to always keep a copy of where the memory we've been allocated actually starts
	# Somake a copy of it in $t7 and then use that to fill memory up with our information
	move $t7, $s2

	# Loop around and read all the channels in. $t1 is a counter of how many times we have looped, $t0 is number of times to loop
	lb $t0, NumberOfChannels
	move $t1, $0

	ReadInChannelData:
		
		# Set up syscall 14, it will read in a single byte
		li $v0, 14
		move $a0, $s3
		la $a1, 0($t7)
		li $a2, 1
		syscall
		
		# Add one to the counter
		addiu $t1, $t1, 1

		# Add 4 to the memory address, it reads in a byte from the file but stores it in a word. Easier for reading it back and debugging purposes.
		addiu $t7, $t7, 4
		
		# Loop back around if we haven't read all files
		bne $t1, $t0, ReadInChannelData

	# Loop around all note data. $t1 is a counter of how many times we have looped, $t0 is the number of notes
	lw $t0, NumberOfNotes
	move $t1, $0
	
	ReadInNoteData:
		
		# First 3 bytes is Pitch, Channel & Velocity. Loop around 3 times reading in a single byte and store it in a word.
		# $t2 is our counter, $t3 is how many times we need to loop around (3)
		li $t2, 0
		li $t3, 3

		ReadFirst3Bytes:

			li $v0, 14
			move $a0, $s3
			la $a1, 0($t7)
			li $a2, 1
			syscall

			addiu $t7, $t7, 4

			addiu $t2, $t2, 1
			
			bne $t2, $t3, ReadFirst3Bytes

		# The next two half words are Duration and Sleep Time. Loop around to read them in and store them both in their own word space
		# $t2 is our counter, $t3 is how many times to loop around (2)
		li $t2, 0
		li $t3, 2

		ReadNext4Bytes:

			li $v0, 14
			move $a0, $s3
			la $a1, 0($t7)
			li $a2, 2
			syscall

			addiu $t7, $t7, 4

			addiu $t2, $t2, 1

			bne $t2, $t3, ReadNext4Bytes

		# We have read in all the information for one note, increase a counter
		addiu $t1, $t1, 1
	
		# If we still have to read more notes then loop back around, otherwise carry on with the sub routine
		bne $t1, $t0, ReadInNoteData

	# Close the file
	li $v0, 16
	move $a0, $s3
	syscall

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# Called from EntryPoint
LoadChannels:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Load the first number into $t0
	lb $t0, NumberOfChannels

	# Set up a counter to count how many channels we've done
	li $t1, 0

	# Keep a copy of where our data starts
	move $s4, $s2

	LoadChannelLoop:

		# Set the syscall up to add an instrument in a channel
		li $v0, 38
		
		# We're loading into whatever our channel counter is currently at
		move $a0, $t1

		# Instrument is the word we're currently pointing at
		lw $a1, 0($s2) 

		# Increase to the next memory address
		addi $s2, $s2, 4

		# Increase a counter of how many times we have set up a channel
		addiu $t1, $t1, 1

		# Do it
		syscall

		# If we haven't loaded all of the channels then loop back around
		bne $t0, $t1, LoadChannelLoop 

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# Called from EntryPoint
ReceiveInput:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Show a dialog box for the user to enter their file name
	li $v0, 54
	la $a0, PleaseChooseASong
	la $a1, Filename
	li $a2, 50
	syscall

	# Cancel was chosen, just go to the end of the program
	beq $a1, -2, End
	
	# No string entered, display an error message
	beq $a1, -3, DisplayErrorBox

	# We need to remove the '\n' from the end of the string
	# Load the address of the file name before going into the recursive loop
	la $t4, Filename
	jal CheckForNewLineCharacter

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# Checks for a new line character in a string and replaces it with a null terminator
CheckForNewLineCharacter:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Load the current character of the string the user entered
	lb $t5, 0($t4)

	# Load the character of a new line into $t6
	lb $t6, NewLine

	# Compare the two, if they are the same it means we have found the one that needs replacing. Jump to the replacement code
	beq $t5, $t6, ReplaceCharacter

	# Else add a byte to the memory address
	addiu $t4, $t4, 1

	# Loop back around and check again
	j CheckForNewLineCharacter

	# Replace the character of where we are at (a '\n') with a '\0'
	ReplaceCharacter:

		# Load the null terminator character into memory
		lb $t6, NullTerminator

		# Replace the new line character with the null terminator
		sb $t6, 0($t4)

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# Called from various points. When finished, it jumps straight back to getting the user to enter a file name
DisplayErrorBox:

	# Syscall 55 is displaying of an error message
	li $v0, 55
	la $a0, ErrorMessage
	li $a1, 2
	syscall

	# If we get into here it means we have just jumped out of somewhere else, so we have to decrease the stack as it will no longer be used
	addiu $sp, $sp, 4

	# We will go straight to the EntryPoint of the program again, because that is where it gets the user to enter the file name
	j EntryPoint

PlayNewSong:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $v0, 50
	la $a0, PlayAnotherSong

	syscall

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

# Erase memory
EraseUsedMemory:

	# Add a byte to the stack pointer and store the return address there
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# $t0 used as a counter, number of channels + (number of notes * 5) is how many times we need to loop around
	li $t0, 0
	lw $t1, NumberOfChannels
	lw $t2, NumberOfNotes
	mulo $t2, $t2, 5
	add $t1, $t1, $t2

	# Here we write over all our previously stored information with zeros
	LoopAndErase:

		sw $0, 0($s4)
		addiu $s4, $s4, 4
		addiu $t0, $t0, 1
		
		bne $t0, $t1, LoopAndErase

	# Get the return address from the stack and decrease the pointer
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Jump to the address we just loaded
	jr $ra

EntryPoint:

	# Get user to enter what file we are going to play
	jal ReceiveInput

	# Read the information from the file into memory and keep the register in s2
	jal StoreInMemory

	# Load up the correct instruments into the channels for syscall 37
	jal LoadChannels

	# Play the song
	jal BeginSong

	# Clear up what we have used. Mainly because if the user plays a second song it stops data which was stored previously from messing up the current song to be played
	jal EraseUsedMemory

	# Ask user if they would like to play another song
	jal PlayNewSong

	# Check if the user wanted to play a new song
	# If the user selected "Yes" to PlayNewSong, go all the way back to the top of EntryPoint and do it all again, otherwise it will jump to End
	beqz $a0, EntryPoint

	j End

End:
# End of program