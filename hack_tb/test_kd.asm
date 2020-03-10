    // while (1)
    //     if (kbd != 0)
    //         display = kbd;
    
(LOOP)      // while (1)
    @KBD    //     if (kbd != 0)
    D=M
    @NEXT
    D;JEQ
    @SCREEN //         display = kbd;
    M=D
(NEXT)
    @LOOP
    0;JMP
