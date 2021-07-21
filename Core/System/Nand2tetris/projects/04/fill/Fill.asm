// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.


// Pseudo code
// LOOP:
//     if @24576 != 0:
//     pixel = 1
//     goto LOOP

(LOOP)
    @SCREEN
    D=A
    @pixel
    M=D
    
    @KBD
    D=M
    @BLACKEN
    D; JGT
    
    @color
    M=0
    @FILLING
    0; JMP
    
    (BLACKEN)
        @color
        M=-1;
    
    (FILLING)
        @color
        D=M
        
        @pixel
        A=M
        M=D
        
        @pixel
        M=M+1
        D=M
        
        @KBD
        D=D-A
        
        @FILLING
        D; JLT
        
@LOOP
0; JMP
