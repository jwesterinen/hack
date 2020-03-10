// original KB test

    @18         // blank the display
    D=A
    @SCREEN
    M=D
    A=A+1
    M=D    
    A=A+1
    M=D    
    A=A+1
    M=D

(KBD_LOOP)      // look for a keypress
    @KBD
    D=M
    @KBD_LOOP
    D;JEQ
    
    @15         // convert keycode to a digit and display it
    D=D&A    
    @SCREEN
    M=D
    
    @KBD_LOOP
    0;JMP
    
(END)
    @END
    0;JMP
        
