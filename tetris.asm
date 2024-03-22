################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Arnnav Aggarwal, 1008567310
# Student 2: Nicolas Dias Martins, 1009286648
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       1
# - Unit height in pixels:      1
# - Display width in pixels:    256
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# Putting padding into data section
.byte 0x00: 229376
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.
main:
    # Initialize the game
    
    # Print the grid
    li $t0, 0x181818       # Set the color to daek grey
    li $t1, 0              # Set the y-coordinate to 0
    li $t2, 0              # Set the x-coordinate to 0
    li $s0, 0
    li $s1, 0
    li $s2, 0
    li $s3, 16
    li $s4, 2
    li $s5, 0
    
    outer_grid_z:
    outer_grid_y:
    inner_grid_x:
        addi $sp, $sp, -4       # move the stack pointer one word
        sw $t0, 0($sp)          # push the color onto the stack
        addi $sp, $sp, -4       # move the stack pointer one word
        sw $t1, 0($sp)          # push the y-coordinate onto the stack
        addi $sp, $sp, -4       # move the stack pointer one word
        sw $t2, 0($sp)          # push the x-coordinate onto the stack
        jal draw_block          # draw the current block
        addi $sp, $sp, -4
        lw $t0, 0($sp)          # storing colour back in $t0
        addi $sp, $sp, -4    
        lw $t1, 0($sp)          # storing coordinate y back in $t1
        addi $sp, $sp, -4
        lw $t2, 0($sp)          # storing coordinate x back in $t2
        addi $sp, $sp, 12
        addi $t2, $t2, 16
        addi $s0, $s0, 1
        beq $s0, $s3, end_grid_x
        j inner_grid_x
    end_grid_x:
        addi $t1, $t1, 16
        addi $s0, $zero, 0
        add $t2, $zero, $s5
        addi $s1, $s1, 1 
        beq $s1, $s3, end_grid_y
        j outer_grid_y
    end_grid_y:
        addi $t1, $zero, 8
        addi $t2, $zero, 8
        addi $s0, $zero, 0
        addi $s1, $zero, 0
        addi $s5, $zero, 8
        addi $2, $s1, 1
        beq $s2, $s4, end_grid_z
        j outer_grid_z
    end_grid_z:

game_loop:
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    b game_loop

j draw_block_end

draw_block:
    # - $a0 stores coordinate x
    # - $a1 stores coordinate y
    # - $a2 stores colour
    # - $t0 stores the current address
    # - $t1 stores the inner loop iteration
    # - $t2 stores the outer loop iteration
    # - $t3 stores the dimensions (both height and width) of the block
    # - $t4 stores the address of the first pixel in the current row
    
    # Reading inputs from the stack
    lw $a0, 0($sp)      # storing coordinate x in $a0
    addi $sp, $sp, 4    
    lw $a1, 0($sp)      # storing coordinate y in $a1
    addi $sp, $sp, 4
    lw $a2, 0($sp)      # storing colour in $a2
    addi $sp, $sp, 4
    
    # Setting "local variables"
    lw $t0, ADDR_DSPL       # first, store the initial address of the bitmap
    addi $t1, $zero, 0
    addi $t2, $zero, 0
    addi $t3, $zero, 8
    sll $t4, $a0, 2         # get coordinate x in bytes
    add $t0, $t4, $t0       # add to the current position
    sll $t4, $a1, 10        # get coordinate y in bytes
    add $t0, $t4, $t0       # add to the current position
    addi $t4, $t0, 0        # store the address of the first pixel in the first row
    
    # Drawing block
outer_y:
inner_x:
    sw $a2, 0($t0)              # printing current pixel
    addi $t0, $t0, 4            # going to the next pixel
    addi $t1, $t1, 1            # one more iner loop iteration finished
    beq $t1, $t3, end_x         # ends the inner loop when all 8 pixels (in a row) were drawn
    j inner_x                   # jumps to the next iteration of the inner loop
end_x:
    addi $t1, $zero, 0          # sets inner loop iteration to 0
    addi $t4, $t4, 1024         # sets t4 the first pixel of the next row
    addi $t0, $t4, 0            # set the current to the first pixel of the next row 
    addi $t2, $t2, 1            # one more outer loop iteration finished
    beq $t2, $t3, end_y         # ends the outer loop when all 64 pixels were drawn
    j outer_y                   # jumps to the next iteration of the outer loop
end_y:
    jr $ra # return to where the function was called

draw_block_end: