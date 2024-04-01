# Assembly-Tetris
## Instruction and Summary

1. Milestones:

    Milestone 1:

    -   Drawing the walls of the playing area

    -   Drawing the background grid to show alignment of blocks

    -   Drawing the first tetromino

    Milestone 2:

    -   Moving the tetromino in response to keyboard input (rotate (W),
        left (A), right (D), drop (S)) has been implemented by updating
        current piece

    -   Re-painting the screen to visualize movement

    -   Quit the game by pressing Q

    Milestone 3:

    -   Prevent moving across the walls (collision)

    -   Prevent moving below the floor

    -   Collide with pre-existing blocks

    -   Clearing complete lines

    Milestones 4 & 5: (6 Easy & 1 Hard)

    -   Easy:

        -   1\. Gravity: Blocks fall at a consistent speed

        -   3\. Losing or pressing 'q' brings player to game over
            screen, pressing 'r' on this screen restarts a new game

        -   4\. Sound effects for rotating , dropping and game over

        -   5\. Pause the game on pressing 'p', continue by pressing 'p'
            again

        -   10\. Display next piece coming up

        -   12\. Each tetromino type is a different colour

    -   Hard:

        -   2\. Full set of tetrominoes

3.  How to view the game:

    1.  Pixel Unit Width/Height: 1

    2.  Screen Width: 256

    3.  Screen Height: 256

    4.  Bitmap Address: 0x10008000 (\$gp)
  
    5.  Compatible with MARS and Saturn assemblers for MIPS Assebmly

## How to Play:

Game Summary:

-   A classic game of Tetris

-   Controls: Rotate (w), Move left (a), Move right (d), Drop piece (s),
    Quit (q), Pause (p), Retry (r).

-   Internal play area: 20 blocks tall by 10 blocks wide

-   Current block moves down due to gravity

-   Preview upcoming piece on the right of the play grid

-   Pause the game by pressing (p)

-   If the new block cannot spawn, due to overlapping with existing
    blocks, a game over screen appears. Press (r) to retry

## GitHub

The code is available at the github repository:
[GitHub](https://github.com/Arnnav-A/Assembly-Tetris). We used this
repository to collaborate, keep track of progress and previous versions
along with managing contributions from both teammates.

## Code Organization

The code in
[tetris.asm](https://github.com/Arnnav-A/Assembly-Tetris/blob/main/tetris.asm)
is written in the Assembly language, specifically for a MIPS Assembly
processor. The program uses 2 MMIO components (Memory-Mapped I/O) to
interact with the bitmap display and the keyboard. The code is divided
into the following two blocks.

### Data

This contains the immutable and mutable data used throughout the code.
It has:

-   Immutable Data:

    -   Padding for the bitmap array

    -   Addresses for the MMIO components

    -   An array of default pieces that can be spawned

    -   All pieces that can exist, including rotations. Each piece
        contains information for its next rotation, the block offsets it
        contains and its main and outline colors

-   Mutable Data:

    -   Current piece being controlled, its type and location

    -   The grid state representing which block is filled in the grid

### Text

This set of instructions is divided into the following sections:

-   Drawing the play grid

-   Drawing the play borders (walls and floor)

-   Drawing the starting default piece

-   Game loop:

    -   Sleep

    -   Listen for inputs

    -   Check for collision

    -   Update current piece by overwriting in memory

    -   Check and clear complete rows

    -   Repeat

-   Helper functions for drawing and collision detecting.

-   Loops for pause and game over
