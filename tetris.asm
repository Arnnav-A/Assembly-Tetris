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

# The addresses of possible starting pieces
pieces_array:
    .word O_piece
    .word I_piece_vertical
    .word S_piece_horizontal
    .word Z_piece_horizontal
    .word L_piece_default
    .word J_piece_default
    .word T_piece_default

# The pieces of the Tetris game
O_piece:
    .word O_piece # stores the address of the next rotation of the O piece
    .word 0, 0, 8, 0, 0, 8, 8, 8 # stores the coordinates of the O piece
    .word 0x00FFFF00 # stores the color of the O piece
    .word 0x00999900 # stores the outline color of the O piece

I_piece_vertical:
    .word I_piece_horizontal # stores the address of the next rotation of the I piece
    .word 0, 0, 0, 8, 0, 16, 0, 24 # stores the coordinates of the I piece
    .word 0x0000FFFF # stores the color of the I piece
    .word 0x00009999 # stores the outline color of the I piece
I_piece_horizontal:
    .word I_piece_vertical # stores the address of the next rotation of the I piece
    .word 0, 0, 8, 0, 16, 0, 24, 0 # stores the coordinates of the I piece
    .word 0x0000FFFF # stores the color of the I piece
    .word 0x00009999 # stores the outline color of the I piece

S_piece_horizontal:
    .word S_piece_vertical # stores the address of the next rotation of the S piece
    .word 8, 0, 16, 0, 0, 8, 8, 8 # stores the coordinates of the S piece
    .word 0x00FF0000 # stores the color of the S piece
    .word 0x00990000 # stores the outline color of the S piece
S_piece_vertical:
    .word S_piece_horizontal # stores the address of the next rotation of the S piece
    .word 0, 0, 0, 8, 8, 8, 8, 16 # stores the coordinates of the S piece
    .word 0x00FF0000 # stores the color of the S piece
    .word 0x00990000 # stores the outline color of the S piece

Z_piece_horizontal:
    .word Z_piece_vertical # stores the address of the next rotation of the Z piece
    .word 0, 0, 8, 0, 8, 8, 16, 8 # stores the coordinates of the Z piece
    .word 0x0000FF00 # stores the color of the Z piece
    .word 0x00009900 # stores the outline color of the Z piece
Z_piece_vertical:
    .word Z_piece_horizontal # stores the address of the next rotation of the Z piece
    .word 8, 0, 0, 8, 8, 8, 0, 16 # stores the coordinates of the Z piece
    .word 0x0000FF00 # stores the color of the Z piece
    .word 0x00009900 # stores the outline color of the Z piece

L_piece_default:
    .word L_piece_90 # stores the address of the next rotation of the L piece
    .word 0, 0, 0, 8, 0, 16, 8, 16 # stores the coordinates of the L piece
    .word 0x00FF9933 # stores the color of the L piece
    .word 0x00995522 # stores the outline color of the L piece
L_piece_90:
    .word L_piece_180 # stores the address of the next rotation of the L piece
    .word 0, 0, 8, 0, 16, 0, 0, 8 # stores the coordinates of the L piece
    .word 0x00FF9933 # stores the color of the L piece
    .word 0x00995522 # stores the outline color of the L piece
L_piece_180:
    .word L_piece_270 # stores the address of the next rotation of the L piece
    .word 0, 0, 8, 0, 8, 8, 8, 16 # stores the coordinates of the L piece
    .word 0x00FF9933 # stores the color of the L piece
    .word 0x00995522 # stores the outline color of the L piece
L_piece_270:
    .word L_piece_default # stores the address of the next rotation of the L piece
    .word 0, 8, 8, 8, 16, 8, 16, 0 # stores the coordinates of the L piece
    .word 0x00FF9933 # stores the color of the L piece
    .word 0x00995522 # stores the outline color of the L piece

J_piece_default:
    .word J_piece_90 # stores the address of the next rotation of the J piece
    .word 8, 0, 8, 8, 8, 16, 0, 16 # stores the coordinates of the J piece
    .word 0x00FF00FF # stores the color of the J piece
    .word 0x00990099 # stores the outline color of the J piece
J_piece_90:
    .word J_piece_180 # stores the address of the next rotation of the J piece
    .word 0, 0, 0, 8, 8, 8, 16, 8 # stores the coordinates of the J piece
    .word 0x00FF00FF # stores the color of the J piece
    .word 0x00990099 # stores the outline color of the J piece
J_piece_180:
    .word J_piece_270 # stores the address of the next rotation of the J piece
    .word 0, 0, 0, 8, 0, 16, 8, 0 # stores the coordinates of the J piece
    .word 0x00FF00FF # stores the color of the J piece
    .word 0x00990099 # stores the outline color of the J piece
J_piece_270:
    .word J_piece_default # stores the address of the next rotation of the J piece
    .word 0, 0, 8, 0, 16, 0, 16, 8 # stores the coordinates of the J piece
    .word 0x00FF00FF # stores the color of the J piece
    .word 0x00990099 # stores the outline color of the J piece

T_piece_default:
    .word T_piece_90 # stores the address of the next rotation of the T piece
    .word 0, 0, 8, 0, 16, 0, 8, 8 # stores the coordinates of the T piece
    .word 0x000000FF # stores the color of the T piece
    .word 0x00000099 # stores the outline color of the T piece
T_piece_90:
    .word T_piece_180 # stores the address of the next rotation of the T piece
    .word 8, 0, 8, 8, 8, 16, 0, 8 # stores the coordinates of the T piece
    .word 0x000000FF # stores the color of the T piece
    .word 0x00000099 # stores the outline color of the T piece
T_piece_180:
    .word T_piece_270 # stores the address of the next rotation of the T piece
    .word 0, 8, 8, 8, 16, 8, 8, 0 # stores the coordinates of the T piece
    .word 0x000000FF # stores the color of the T piece
    .word 0x00000099 # stores the outline color of the T piece
T_piece_270:
    .word T_piece_default # stores the address of the next rotation of the T piece
    .word 0, 0, 0, 8, 0, 16, 8, 8 # stores the coordinates of the T piece
    .word 0x000000FF # stores the color of the T piece
    .word 0x00000099 # stores the outline color of the T piece

##############################################################################
# Mutable Data
##############################################################################

# The current piece of the Tetris game
current_piece:
    .word S_piece_horizontal # stores the address of the current piece
    .word 72, 80 # stores the coordinates of the top left corner of the current piece

# Array of the grid (including the walls), 0 is empty, 1 is filled
# for collision detection
grid_state:
    .byte 0: 240    # 20 by 12 grid
    .byte 1: 12     # bottom floor

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
    li $t2, 80             # set the y-coordinate to 80
    li $t3, 40             # set the x-coordinate to 40

    li $s0, 0              # set the current number of iterations of inner_grid_x to 0
    li $s1, 0              # set the current number of iterations of middle_grid_y to 0
    li $s2, 0              # set the current number of iterations of outer_grid_z to 0
    li $s3, 10             # set the maximum number of iterations of inner_grid_x to 10
    li $s4, 20             # set the maximum number of iterations of middle_grid_y to 20
    li $s5, 40             # set the current starting x-coordinate to 40

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
        addi $t3, $t3, 8            # move the x-coordinate to the next block of the grid
        addi $s0, $s0, 1            # add 1 to the number of iterations of inner_grid_x
        beq $s0, $s3, end_grid_x    # after 5 iterations, end the inner_grid_x loop
        j inner_grid_x              # go back to the beginning of the inner_grid_x loop
    end_grid_x:
        addi $t2, $t2, 8            # move the y-coordinate to the next row (however, skip one row)
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
        beq $s0, 10, end_border_h   # after 10 iterations, end the border_x loop
        j border_h                  # go back to the beginning of the border_x loop
end_border_h:

# set left and right wall collision in grid_state
la $t0, grid_state                  # load the address of the grid_state, first left wall
li $t2, 20                          # number of iterations, same as height of the walls
li $t3, 0                           # loop counter
li $t4, 1                           # set the value of the wall (filled)

wall_collision_loop:
sb $t4, 0($t0)                      # set the left wall to filled
sb $t4, 11($t0)                     # set the right wall to filled
addi $t0, $t0, 12                   # move to the next row
addi $t3, $t3, 1                    # increment the loop counter
beq $t3, $t2, wall_collision_end    # end the loop when all rows are filled
j wall_collision_loop               # go back to the beginning of the loop
wall_collision_end:

# draw the current piece as the starting block
li $a0, 1           # if 1, draw current
jal make_current

game_loop:

	li $v0, 32
	li $a0, 10
    syscall                     # delay the game loop by 10 ms

	# 1a. Check if key has been pressed
    lw $t0, ADDR_KBRD           # load the address of the keyboard
    lw $t1, 0($t0)              # load the first word of the keyboard
    beq $t1, 1, keyboard_input  # If first word 1, key is pressed
    b game_loop                 # If first word 0, key is not pressed

    # 1b. Check which key has been pressed
    keyboard_input:
        lw $t1, 4($t0)              # load the second word of the keyboard
        beq $t1, 0x77, handle_w     # If second word is 0x77, key is 'w'
        beq $t1, 0x61, handle_a     # If second word is 0x61, key is 'a'
        beq $t1, 0x73, handle_s     # If second word is 0x73, key is 's'
        beq $t1, 0x64, handle_d     # If second word is 0x64, key is 'd'
        beq $t1, 0x71, game_over    # If second word is 0x71, key is 'q'
        beq $t1, 0x70, pause        # If second word is 0x70, key is 'p'
        b game_loop                 # Invalid key, go back to the game loop

    # 2a. Check for collisions and update the current piece
        handle_w:
            # erase the current piece
            li $a0, 0                  # if 0, erase current
            jal make_current

            lw $t0, current_piece      # load the address of the current piece
            lw $t0, 0($t0)             # load the address of the next rotation
            sw $t0, current_piece      # update the current piece

            # check for collision
            jal handle_collision
            beq $v0, 0, rotate_sound    # if 0, no collision, go to the end of the handle block

            # rotate current 3 times to go back to normal
            lw $t0, current_piece      # load the address of the current piece
            lw $t0, 0($t0)             # load the address of the next rotation
            sw $t0, current_piece      # update the current piece

            lw $t0, current_piece      # load the address of the current piece
            lw $t0, 0($t0)             # load the address of the next rotation
            sw $t0, current_piece      # update the current piece

            lw $t0, current_piece      # load the address of the current piece
            lw $t0, 0($t0)             # load the address of the next rotation
            sw $t0, current_piece      # update the current piece

            # if rotated successfully, play sound effect
            rotate_sound:
            li $a0, 80                 # pitch
            li $a1, 500                # duration
            li $a2, 0                  # instrument
            li $a3, 80                 # volume
            li $v0, 31                 # async sound
            syscall

            b handle_end               # go to the end of the handle block

        handle_a:
            # erase the current piece
            li $a0, 0                  # if 0, erase current
            jal make_current

            # move current to the left
            la $t0, current_piece      # load the address of the current piece
            lw $t1, 4($t0)             # load the x-coordinate of the current piece
            addi $t1, $t1, -8          # move the current piece to the left
            sw $t1, 4($t0)             # update the x-coordinate of the current piece

            # check for collision
            jal handle_collision
            beq $v0, 0, handle_end    # if 0, no collision, go to the end of the handle block

            # move current to the right
            la $t0, current_piece      # load the address of the current piece
            lw $t1, 4($t0)             # load the x-coordinate of the current piece
            addi $t1, $t1, 8           # move the current piece to the right
            sw $t1, 4($t0)             # update the x-coordinate of the current piece

            b handle_end               # go to the end of the handle block

        handle_s:
            # erase the current piece
            li $a0, 0                  # if 0, erase current
            jal make_current

            # move down until collides

            move_down:

            # check for collision
            jal handle_collision
            beq $v0, 1, move_down_end  # if 1, there is collision, go to the end of move down

            la $t0, current_piece      # load the address of the current piece
            lw $t1, 8($t0)             # load the y-coordinate of the current piece
            addi $t1, $t1, 8           # move the current piece down
            sw $t1, 8($t0)             # update the y-coordinate of the current piece
            b move_down                # go back to the beginning of move down

            move_down_end:

            # move current piece up
            la $t0, current_piece      # load the address of the current piece
            lw $t1, 8($t0)             # load the y-coordinate of the current piece
            addi $t1, $t1, -8          # move the current piece up
            sw $t1, 8($t0)             # update the y-coordinate of the current piece

            # if moved down successfully, play sound effect
            li $a0, 40                 # pitch
            li $a1, 250                # duration
            li $a2, 25                 # instrument
            li $a3, 80                 # volume
            li $v0, 31                 # async sound
            syscall

            # update the grid state
            jal freeze_current         # update grid state
            # draw the current piece
            li $a0, 1           # if 1, draw current
            jal make_current

            # generate new random piece
            li $v0, 42                 # load 42 into $v0
            li $a0, 0                  # load 0 into $a0, default random number generator
            li $a1, 7                  # load 7 into $a1, upper bound of the random number
            syscall                    # generate a random number 0 through 6
            # now $a0 stores the random number

            la $t0, pieces_array       # load the address of the pieces_array
            sll $t1, $a0, 2            # get the offset of the random piece
            add $t0, $t0, $t1          # add the offset to the address of the pieces_array
            lw $t0, 0($t0)             # load the address of the random piece
            sw $t0, current_piece      # update the current piece
            la $t0, current_piece      # load the address of the current piece
            li $t1, 72                 # set $t1 to 72
            sw $t1, 4($t0)             # set the x-coordinate of the current piece to 72
            li $t1, 80                 # set $t1 to 80
            sw $t1, 8($t0)             # set the y-coordinate of the current piece to 80

            b handle_end               # go to the end of the handle block

        handle_d:
            # erase the current piece
            li $a0, 0                  # if 0, erase current
            jal make_current

            la $t0, current_piece      # load the address of the current piece
            lw $t1, 4($t0)             # load the x-coordinate of the current piece
            addi $t1, $t1, 8           # move the current piece to the right
            sw $t1, 4($t0)             # update the x-coordinate of the current piece

            # check for collision
            jal handle_collision
            beq $v0, 0, handle_end     # if 0, no collision, go to the end of the handle block

            # move current to the left
            la $t0, current_piece      # load the address of the current piece
            lw $t1, 4($t0)             # load the x-coordinate of the current piece
            addi $t1, $t1, -8          # move the current piece to the left
            sw $t1, 4($t0)             # update the x-coordinate of the current piece
            b handle_end               # go to the end of the handle block


        handle_end:

	# 3. Draw the current piece
	li $a0, 1                          # if 1, draw current
    jal make_current
    # 4. Go back to the game loop
    b game_loop

j end

pause:

li $a3, 0xFFFFFF
# Draw P
li $a0, 143
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 143
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 149
li $a1, 217
li $a2, 8
jal draw_vertical
li $a0, 143
li $a1, 223
li $a2, 8
jal draw_horizontal

# Draw A
li $a0, 155
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 155
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 161
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 155
li $a1, 223
li $a2, 8
jal draw_horizontal

# Print U
li $a0, 168
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 168
li $a1, 231
li $a2, 8
jal draw_horizontal
li $a0, 174
li $a1, 217
li $a2, 16
jal draw_vertical

# Print S
li $a0, 181
li $a1, 217
li $a2, 8
jal draw_vertical
li $a0, 181
li $a1, 231
li $a2, 8
jal draw_horizontal
li $a0, 187
li $a1, 225
li $a2, 8
jal draw_vertical
li $a0, 181
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 181
li $a1, 224
li $a2, 8
jal draw_horizontal

# Print E
li $a0, 193
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 193
li $a1, 231
li $a2, 8
jal draw_horizontal
li $a0, 193
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 193
li $a1, 224
li $a2, 8
jal draw_horizontal

# Print D
li $a0, 205
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 205
li $a1, 231
li $a2, 6
jal draw_horizontal
li $a0, 205
li $a1, 217
li $a2, 6
jal draw_horizontal
li $a0, 211
li $a1, 219
li $a2, 12
jal draw_vertical


# pause loop that listens for next press of 'p'
pause_loop:

    # delay the pause loop by 10 ms
    li $v0, 32
    li $a0, 10
    syscall

    lw $t0, ADDR_KBRD           # load the address of the keyboard
    lw $t1, 0($t0)              # load the first word of the keyboard
    beq $t1, 0, pause_loop      # If first word 0, key is not pressed
    lw $t1, 4($t0)              # load the second word of the keyboard
    beq $t1, 0x70, end_pause    # If second word is 0x70, key is 'p', go back to game loop
    b pause_loop                # If second word is not 0x70, key is not 'p', go back to pause loop
    
end_pause:

li $a0, 1
jal clear
b game_loop

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

j end

make_current: # make_current(erase_or_delete)
    # - $a0 stores whether the current piece should be erased (0) or drawn (1)
    # - $s0 stores the current piece
    # - $s1 stores the address of the current piece
    # - $s2 stores the outline colour
    # - $s3 stores the solid colour
    # - $s4 stores the inital y-coordinate
    # - $s5 stores the initial x-coordinate
    # - $s6 stores the current y-coordinate
    # - $s7 stores the current x-coordinate

    # Reading "inputs" from memory
    la $s0, current_piece       # store the current piece
    lw $s1, 0($s0)              # store the address of the current piece
    beq $a0, 0, erase           # if $a0 is 0, jump to erase
    lw $s2, 40($s1)             # set the colour (outline) as the colour of the current piece
    lw $s3, 36($s1)             # set the colour (solid) as the colour of the current piece
    j end_erase                 # skip erase
    erase:
    li $s2, 0x181818            # set the colour (outline) as dark grey
    li $s3, 0x000000            # set the colour (solid) as black
    end_erase:
    lw $s4, 8($s0)              # store the initial y-coordinate
    lw $s5, 4($s0)              # store the initial x-coordinate

    addi $s1, $s1, 4            # sets $s1 to the beginning of the piece's first x-coordinate

    # Print first block
    lw $s6, 4($s1)
    add $s6, $s6, $s4            # sets y-coordinate of the first block
    lw $s7, 0($s1)
    add $s7, $s7, $s5            # sets x-coordinate of the first block
    addi $s1, $s1, 8             # moves $s1 to the next x-coordinate

    addi $sp, $sp, -4            # move the stack pointer one word
    sw $ra, 0($sp)               # push the return address onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s2, 0($sp)               # push the color (outline) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s3, 0($sp)               # push the color (solid) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s6, 0($sp)               # push the y-coordinate onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s7, 0($sp)               # push the x-coordinate onto the stack
    jal draw_block               # draw the current block of the grid
    lw $ra, 0($sp)               # pop the return address from the stack

    # Print second block
    lw $s6, 4($s1)
    add $s6, $s6, $s4            # sets y-coordinate of the second block
    lw $s7, 0($s1)
    add $s7, $s7, $s5            # sets x-coordinate of the second block
    addi $s1, $s1, 8             # moves $s1 to the next x-coordinate

    sw $ra, 0($sp)               # push the return address onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s2, 0($sp)               # push the color (outline) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s3, 0($sp)               # push the color (solid) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s6, 0($sp)               # push the y-coordinate onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s7, 0($sp)               # push the x-coordinate onto the stack
    jal draw_block               # draw the current block of the grid
    lw $ra, 0($sp)               # pop the return address from the stack

    # Print third block
    lw $s6, 4($s1)
    add $s6, $s6, $s4            # sets y-coordinate of the third block
    lw $s7, 0($s1)
    add $s7, $s7, $s5            # sets x-coordinate of the third block
    addi $s1, $s1, 8             # moves $s1 to the next x-coordinate

    sw $ra, 0($sp)               # push the return address onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s2, 0($sp)               # push the color (outline) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s3, 0($sp)               # push the color (solid) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s6, 0($sp)               # push the y-coordinate onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s7, 0($sp)               # push the x-coordinate onto the stack
    jal draw_block               # draw the current block of the grid
    lw $ra, 0($sp)               # pop the return address from the stack

    # Print forth block
    lw $s6, 4($s1)
    add $s6, $s6, $s4            # sets y-coordinate of the forth block
    lw $s7, 0($s1)
    add $s7, $s7, $s5            # sets x-coordinate of the forth block
    addi $s1, $s1, 8             # moves $s1 to the next x-coordinate

    sw $ra, 0($sp)               # push the return address onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s2, 0($sp)               # push the color (outline) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s3, 0($sp)               # push the color (solid) onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s6, 0($sp)               # push the y-coordinate onto the stack
    addi $sp, $sp, -4            # move the stack pointer one word
    sw $s7, 0($sp)               # push the x-coordinate onto the stack
    jal draw_block               # draw the current block of the grid
    lw $ra, 0($sp)               # pop the return address from the stack

    jr $ra                       # return to where the function was called

end_make_current:

j end

handle_collision: # handle_collision() -> collide_or_not
    # - $a0 stores the address of the current piece
    # - $s0 stores the address of the current piece
    # - $s1 stores the new y-coordinate of the piece
    # - $s2 stores the new x-coordinate of the piece
    # - $s3 stores the current y-coordinate of a block
    # - $s4 stores the current x-coordinate of a block
    # - $s5 stores the collision grid state
    # - $s6 stores the current value of an address of the collision grid state
    # - $s7 stores 12 (for multiplication)
    # - $v0 (return value) is 0 if there are no collisions and 1 if there is at least 1 collision

   # Reading "inputs" from memory - piece
    li $s7, 12
    la $a0, current_piece       # store the address of the current piece
    lw $s0, 0($a0)              # store the address of the current piece
    lw $s1, 8($a0)              # store the new y-coordinate
    addi $s1, $s1, -80
    srl $s1, $s1, 3
    mult $s1, $s7
    mflo $s1
    lw $s2, 4($a0)              # store the new x-coordinate
    addi $s2, $s2, -32
    srl $s2, $s2, 3

    # Reading "inputs" from memory - grid state
    la $s5, grid_state           # store address of the grid_state

    addi $s0, $s0, 4             # sets $s0 to the beginning of the piece's first x-coordinate
    li $v0, 0                    # sets $v0 (return value) to be 0 by default

    # Checking for first block
    lw $s3, 4($s0)
    srl $s3, $s3, 3              # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3              # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    lb $s6, 0($s5)
    beq $s6, 1, found_collision
    addi $s0, $s0, 8             # moves $s0 to the next x-coordinate

    la $s5, grid_state           # store the grid_state
    # Checking for second block
    lw $s3, 4($s0)
    srl $s3, $s3, 3              # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3              # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    lb $s6, 0($s5)
    beq $s6, 1, found_collision
    addi $s0, $s0, 8             # moves $s0 to the next x-coordinate

    la $s5, grid_state           # store the grid_state
    # Checking for third block
    lw $s3, 4($s0)
    srl $s3, $s3, 3              # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3              # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    lb $s6, 0($s5)
    beq $s6, 1, found_collision
    addi $s0, $s0, 8             # moves $s0 to the next x-coordinate

    la $s5, grid_state           # store the grid_state
    # Checking for forth block
    lw $s3, 4($s0)
    srl $s3, $s3, 3              # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3              # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    lb $s6, 0($s5)
    beq $s6, 1, found_collision

    j collision_checked          # if we get to the end of the checks, no collisions were found, so jump to collision_checked

    found_collision:
    addi $v0, $v0, 1             # if a collision is found, set $v0 (return value) to 1
    collision_checked:

    jr $ra                       # return to where the function was called

end_handle_colision:

j end

freeze_current:
   # Reading "inputs" from memory - piece
    li $s6, 1
    li $s7, 12
    la $a0, current_piece       # store the address of the current piece
    lw $s0, 0($a0)              # store the address of the current piece
    lw $s1, 8($a0)              # store the new y-coordinate
    addi $s1, $s1, -80
    srl $s1, $s1, 3
    mult $s1, $s7
    mflo $s1
    lw $s2, 4($a0)              # store the new x-coordinate
    addi $s2, $s2, -32
    srl $s2, $s2, 3

    # Reading "inputs" from memory - grid state
    la $s5, grid_state          # store address of the grid_state

    addi $s0, $s0, 4            # sets $s0 to the beginning of the piece's first x-coordinate
    li $v0, 0                   # sets $v0 (return value) to be 0 by default

    # Checking for first block
    lw $s3, 4($s0)
    srl $s3, $s3, 3             # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3             # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    sb $s6, 0($s5)
    addi $s0, $s0, 8            # moves $s0 to the next x-coordinate

    la $s5, grid_state          # store the grid_state
    # Checking for second block
    lw $s3, 4($s0)
    srl $s3, $s3, 3             # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3             # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    sb $s6, 0($s5)
    addi $s0, $s0, 8            # moves $s0 to the next x-coordinate

    la $s5, grid_state          # store the grid_state
    # Checking for third block
    lw $s3, 4($s0)
    srl $s3, $s3, 3             # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3             # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    sb $s6, 0($s5)
    addi $s0, $s0, 8            # moves $s0 to the next x-coordinate

    la $s5, grid_state          # store the grid_state
    # Checking for forth block
    lw $s3, 4($s0)
    srl $s3, $s3, 3             # sets y-coordinate of the first block
    lw $s4, 0($s0)
    srl $s4, $s4, 3             # sets x-coordinate of the first block
    mult $s3, $s7
    mflo $s3
    add $s3, $s3, $s1
    add $s4, $s4, $s2
    add $s5, $s5, $s4
    add $s5, $s5, $s3
    sb $s6, 0($s5)

    jr $ra                      # return to where the function was called

end_freeze_current:

j end

draw_vertical:
    
    lw $s2, ADDR_DSPL
    li $s1, 0
    sll $a0, $a0, 2
    sll $a1, $a1, 10
    add $s2, $s2, $a0
    add $s2, $s2, $a1
    
    print_vertical:
    sw $a3, 0($s2)
    sw $a3, 4($s2)
    addi $s1, $s1, 1
    beq $s1, $a2, end_print_vertical
    addi $s2, $s2, 1024
    j print_vertical
    end_print_vertical:
    
    jr $ra
    
end_draw_vertical:

j end

draw_horizontal:

    lw $s2, ADDR_DSPL
    li $s1, 0
    sll $a0, $a0, 2
    sll $a1, $a1, 10
    add $s2, $s2, $a0
    add $s2, $s2, $a1
    
    print_horizontal:
    sw $a3, 0($s2)
    sw $a3, 1024($s2)
    addi $s1, $s1, 1
    beq $s1, $a2, end_print_horizontal
    addi $s2, $s2, 4
    j print_horizontal
    end_print_horizontal:
    
    jr $ra

end_draw_horizontal:

j end

clear:

li $s0, 0
lw $s1, ADDR_DSPL
li $s2, 0x000000
li $s3, 65536
beq $a0, 0, clear_all
beq $a0, 1, clear_pause

clear_all:
sw $s2, 0($s1)
addi $s1, $s1, 4
addi $s0, $s0, 1
beq $s0, $s3, go_back_clear
j clear_all

clear_pause: 
sw $ra, 0($sp)               # push the return address onto the stack
li $a3, 0x000000
# Draw P
li $a0, 143
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 143
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 149
li $a1, 217
li $a2, 8
jal draw_vertical
li $a0, 143
li $a1, 223
li $a2, 8
jal draw_horizontal

# Draw A
li $a0, 155
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 155
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 161
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 155
li $a1, 223
li $a2, 8
jal draw_horizontal

# Print U
li $a0, 168
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 168
li $a1, 231
li $a2, 8
jal draw_horizontal
li $a0, 174
li $a1, 217
li $a2, 16
jal draw_vertical

# Print S
li $a0, 181
li $a1, 217
li $a2, 8
jal draw_vertical
li $a0, 181
li $a1, 231
li $a2, 8
jal draw_horizontal
li $a0, 187
li $a1, 225
li $a2, 8
jal draw_vertical
li $a0, 181
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 181
li $a1, 224
li $a2, 8
jal draw_horizontal

# Print E
li $a0, 193
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 193
li $a1, 231
li $a2, 8
jal draw_horizontal
li $a0, 193
li $a1, 217
li $a2, 8
jal draw_horizontal
li $a0, 193
li $a1, 224
li $a2, 8
jal draw_horizontal

# Print D
li $a0, 205
li $a1, 217
li $a2, 16
jal draw_vertical
li $a0, 205
li $a1, 231
li $a2, 6
jal draw_horizontal
li $a0, 205
li $a1, 217
li $a2, 6
jal draw_horizontal
li $a0, 211
li $a1, 219
li $a2, 12
jal draw_vertical
lw $ra, 0($sp)               # pop the return address from the stack

go_back_clear:
jr $ra

end_clear:

j end

clear_grid:
    # Reading "inputs" from memory - grid state
    la $a0, grid_state           # store address of the grid_state
    
    li $a1, 0
    li $a2, 0

    clear_grid_loop:
    sb $a2, 0($a0)
    addi $a1, $a1, 1
    addi $a0, $a0, 1
    beq $a1, 240, end_clear_grid_loop
    j clear_grid_loop
    end_clear_grid_loop:
    
    jr $ra


end_clear_grid:

j end

game_over:

li $a0, 0
jal clear

li $a3, 0xFFFFFF
# Print G
li $a0, 20
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 20
li $a1, 142
li $a2, 16
jal draw_horizontal
li $a0, 20
li $a1, 112
li $a2, 16
jal draw_horizontal
li $a0, 34
li $a1, 128
li $a2, 16
jal draw_vertical

# Print A
li $a0, 45
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 45
li $a1, 112
li $a2, 16
jal draw_horizontal
li $a0, 45
li $a1, 128
li $a2, 16
jal draw_horizontal
li $a0, 59
li $a1, 112
li $a2, 32
jal draw_vertical

# Draw M
li $a0, 71
li $a1, 114
li $a2, 30
jal draw_vertical
li $a0, 73
li $a1, 112
li $a2, 12
jal draw_horizontal
li $a0, 78
li $a1, 112
li $a2, 16
jal draw_vertical
li $a0, 85
li $a1, 114
li $a2, 30
jal draw_vertical

# Draw E
li $a0, 97
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 97
li $a1, 112
li $a2, 16
jal draw_horizontal
li $a0, 97
li $a1, 128
li $a2, 16
jal draw_horizontal
li $a0, 97
li $a1, 142
li $a2, 16
jal draw_horizontal

# Print O
li $a0, 140
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 140
li $a1, 112
li $a2, 16
jal draw_horizontal
li $a0, 156
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 140
li $a1, 142
li $a2, 16
jal draw_horizontal

# Print V
li $a0, 168
li $a1, 112
li $a2, 30
jal draw_vertical
li $a0, 184
li $a1, 112
li $a2, 30
jal draw_vertical
li $a0, 170
li $a1, 142
li $a2, 14
jal draw_horizontal

# Print E
li $a0, 196
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 196
li $a1, 112
li $a2, 16
jal draw_horizontal
li $a0, 196
li $a1, 128
li $a2, 16
jal draw_horizontal
li $a0, 196
li $a1, 142
li $a2, 16
jal draw_horizontal

# Print R
li $a0, 220
li $a1, 112
li $a2, 32
jal draw_vertical
li $a0, 220
li $a1, 112
li $a2, 16
jal draw_horizontal

retry_loop:

    # delay the retry loop by 10 ms
    li $v0, 32
    li $a0, 10
    syscall

    lw $t0, ADDR_KBRD           # load the address of the keyboard
    lw $t1, 0($t0)              # load the first word of the keyboard
    beq $t1, 0, retry_loop      # If first word 0, key is not pressed
    lw $t1, 4($t0)              # load the second word of the keyboard
    beq $t1, 0x72, end_retry    # If second word is 0x72, key is 'r', go back to game loop
    b retry_loop                # If second word is not 0x72, key is not 'r', go back to retry loop
    
end_retry:
li $a0, 0
jal clear_grid
jal clear
b main

end_game_over:

end: