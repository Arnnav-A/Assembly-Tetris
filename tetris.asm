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
    li $t0, 0x181818       # set the color (outline) to black
    li $t1, 0x000000       # set the color (solid) to dark grey
    li $t2, 80             # set the y-coordinate to 72
    li $t3, 40             # set the x-coordinate to 40
    
    li $s0, 0              # set the current number of iterations of inner_grid_x to 0
    li $s1, 0              # set the current number of iterations of middle_grid_y to 0
    li $s2, 0              # set the current number of iterations of outer_grid_z to 0
    li $s3, 10              # set the maximum number of iterations of inner_grid_x to 5
    li $s4, 20             # set the maximum number of iterations of middle_grid_y to 11
    li $s5, 40             # set the current starting x-coordinate to 36
    
    outer_grid_z:
    middle_grid_y:
    inner_grid_x:
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t0, 0($sp)              # push the color (outline) onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t1, 0($sp)              # push the color (solid) onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t2, 0($sp)              # push the y-coordinate onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t3, 0($sp)              # push the x-coordinate onto the stack
        jal draw_block              # draw the current block of the grid
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t0, 0($sp)              # storing colour (outline) back in $t0
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t1, 0($sp)              # storing colour (solid) back in $t0
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t2, 0($sp)              # storing coordinate y back in $t2
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t3, 0($sp)              # storing coordinate x back in $t3
        addi $sp, $sp, 16           # move the stack pointer back to the beginning
        addi $t3, $t3, 8           # move the x-coordinate to the next block of the grid
        addi $s0, $s0, 1            # add 1 to the number of iterations of inner_grid_x
        beq $s0, $s3, end_grid_x    # after 5 iterations, end the inner_grid_x loop
        j inner_grid_x              # go back to the beginning of the inner_grid_x loop
    end_grid_x:
        addi $t2, $t2, 8           # move the y-coordinate to the next row (however, skip one row)
        addi $s0, $zero, 0          # set the number of iterations of inner_grid_x loop back to 0
        add $t3, $zero, $s5         # set the x-coordinate back to its starting point
        addi $s1, $s1, 1            # add 1 to the number of iterations of middle_grid_y
        beq $s1, $s4, end_grid_y    # after 11/10 iterations, end the middle_grid_y loop
        j middle_grid_y             # go back to the beggining of the middle_grid_y loop
    end_grid_y:
    
    # Print the walls
    li $t0, 0x93725E       # set the colour (outline) to light brown 
    li $t1, 0xA48370       # set the colour (solid) to lighter brown
    li $t2, 80             # set the y-coordinate to 80
    li $t3, 32             # set the x-coordinate to 32
    li $s0, 0              # set the current number of iterations of border_v to 0
    li $s1, 0              # set the current number of iterations of n_border_v to 0
    li $s2, 80             # set the current starting y-coordinate to 80
    
n_border_v:
border_v:
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t0, 0($sp)              # push the color (outline) onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t1, 0($sp)              # push the color (solid) onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t2, 0($sp)              # push the y-coordinate onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t3, 0($sp)              # push the x-coordinate onto the stack
        jal draw_block              # draw the current block of the border
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t0, 0($sp)              # storing colour (outline) back in $t0
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t1, 0($sp)              # storing colour (solid) back in $t1
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t2, 0($sp)              # storing coordinate y back in $t2
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t3, 0($sp)              # storing coordinate x back in $t3
        addi $sp, $sp, 16           # move the stack pointer back to the beginning
        addi $t2, $t2, 8            # move the y-coordinate to the next block of the border
        addi $s0, $s0, 1            # add 1 to the number of iterations of border_v
        beq, $s0, 21, end_border_v  # after 21 iterations, end the border_v loop
        j border_v                  # go back to the beginning of the border_v loop
end_border_v:
        addi $t3, $t3, 88               # move the x-coordinate to the next column
        addi $s0, $zero, 0              # set the current number of iterations of border_v back to 0
        add $t2, $zero, $s2             # set the y-coordinate back to its starting point
        addi $s1, $s1, 1                # add 1 to the number of iterations of n_border_v
        beq $s1, 2, end_n_border_v      # after 2 iterations, end the n_border_v loop
        j n_border_v                    # go back to the beginning of the n_border_v loop
end_n_border_v:

    li $t2, 240            # set the y-coordinate to 240
    li $t3, 40             # set the x-coordinate to 40
    li $s0, 0              # set the current number of iterations of border_x to 0

border_h:
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t0, 0($sp)              # push the color (outline) onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t1, 0($sp)              # push the color (solid) onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t2, 0($sp)              # push the y-coordinate onto the stack
        addi $sp, $sp, -4           # move the stack pointer one word
        sw $t3, 0($sp)              # push the x-coordinate onto the stack
        jal draw_block              # draw the current block of the border
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t0, 0($sp)              # storing colour (outline) back in $t0
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t1, 0($sp)              # storing colour (solid) back in $t1
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t2, 0($sp)              # storing coordinate y back in $t2
        addi $sp, $sp, -4           # move the stack pointer one word
        lw $t3, 0($sp)              # storing coordinate x back in $t3
        addi $sp, $sp, 16           # move the stack pointer back to the beginning    
        addi $t3, $t3, 8            # move the x-coordinate to the next block of the border
        addi $s0, $s0, 1            # add 1 to the number of iterations of border_v
        beq $s0, 10, end_border_h  # after 10 iterations, end the border_x loop
        j border_h                  # go back to the beginning of the border_x loop
end_border_h:

# draw the current piece as the starting block

game_loop:

	# 1a. Check if key has been pressed
    lw $t0, ADDR_KBRD           # load the address of the keyboard
    lw $t1, 0($t0)              # load the first word of the keyboard
    beq $t1, 1, keyboard_input  # If first word 1, key is pressed
    b game_loop                 # If first word 0, key is not pressed

    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    b game_loop

j draw_block_end

draw_block: # draw_block(outline, solid, y-coordinate, x-coordinate)
    # - $a0 stores coordinate x
    # - $a1 stores coordinate y
    # - $a2 stores colour (solid)
    # - $a3 stores colour (outline)
    # - $t0 stores the current address
    # - $t1 stores the inner loop iteration
    # - $t2 stores the outer loop iteration
    # - $t3 stores the dimensions (both height and width) of the block
    # - $t4 stores the address of the first pixel in the current row 
    
    # Reading inputs from the stack
    lw $a0, 0($sp)      # storing coordinate x in $a0
    addi $sp, $sp, 4    # move the stack pointer one word
    lw $a1, 0($sp)      # storing coordinate y in $a1
    addi $sp, $sp, 4    # move the stack pointer one word
    lw $a2, 0($sp)      # storing colour (solid) in $a2
    addi $sp, $sp, 4    # move the stack pointer one word
    lw $a3, 0($sp)      # storing colour (outline) in $a3
    addi $sp, $sp, 4    # move the stack pointer one word
    
    # Setting "local variables"
    lw $t0, ADDR_DSPL       # first, store the initial address of the bitmap
    addi $t1, $zero, 0      # set $t1 to 0
    addi $t2, $zero, 0      # set $t2 to 0
    addi $t3, $zero, 8      # set $t3 to 0
    sll $t4, $a0, 2         # get coordinate x in bytes
    add $t0, $t4, $t0       # add to the current position
    sll $t4, $a1, 10        # get coordinate y in bytes
    add $t0, $t4, $t0       # add to the current position
    addi $t4, $t0, 0        # store the address of the first pixel in the first row
    
    # Drawing block
outer_y:
inner_x:
    beq $t1, 0, outline         # if its the first column, print the outline (jump to outline)
    beq $t1, 7, outline         # if its the last column, print the outline (jump to outline)
    beq $t2, 0, outline         # if its the first row, print the outline (jump to outline)
    beq $t2, 7, outline         # if its the last row, print the outline (jump to outline)
    sw $a2, 0($t0)              # printing current pixel (solid)
    j end_outline               # if its solid, skip outline
    outline:
    sw $a3, 0($t0)              # printin the current pixel (outline)
    end_outline:
    addi $t0, $t0, 4            # going to the next pixel
    addi $t1, $t1, 1            # one more inner loop iteration finished
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
    jr $ra                      # return to where the function was called

draw_block_end:

