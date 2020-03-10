// Add 1 + ... + 100
// Note: uses the printdec subroutine guts without calling it

    @i
    M=1
    @sum
    M=0
(LOOP)
    @i
    D=M
    @100
    D=D-A
    @PRINT_RESULT
    D;JGT
    @i
    D=M
    @sum
    M=D+M
    @i
    M=M+1
    @LOOP
    0;JMP
    
(PRINT_RESULT)  
    @sum
    D=M
      
(Printdec)
    @Printdec_value
    M=D
    
    @Printdec_d1         // init the digit values
    M=0
    @Printdec_d2
    M=0
    @Printdec_d3
    M=0
    @Printdec_d4
    M=0

(Printdec_d4_loop)       // calculate the number of 4096's
    @Printdec_value
    D=M
    @1000
    D=D-A
    @Printdec_d3_loop
    D;JLT
    @Printdec_value
    M=D
    @d4
    M=M+1
    @Printdec_d4_loop
    0;JMP

(Printdec_d3_loop)       // calculate the number of 256's
    @Printdec_value
    D=M 
    @100
    D=D-A
    @Printdec_d2_loop
    D;JLT
    @Printdec_value
    M=D
    @d3
    M=M+1
    @Printdec_d3_loop
    0;JMP
    
(Printdec_d2_loop)       // calculate the number of 16's
    @Printdec_value
    D=M
    @10
    D=D-A
    @Printdec_d1_loop
    D;JLT
    @Printdec_value
    M=D
    @d2
    M=M+1
    @Printdec_d2_loop
    0;JMP
    
(Printdec_d1_loop)       // d1 is the remainder
    @Printdec_value
    D=M
    @Printdec_d1
    M=D
    
(Printdec_print_hextets)  
    @SCREEN             // init the cursor to the beginning of the screen
    D=A
    @Printdec_cursor
    M=D
    
    @d1                 // display the d1 in hextet 1
    D=M
    @Printdec_cursor
    A=M
    M=D
    
    @d2                 // display d2 in hextet 2
    D=M
    @Printdec_cursor
    M=M+1
    A=M
    M=D
    
    @d3                 // display d3 in hextet 3
    D=M
    @Printdec_cursor
    M=M+1
    A=M
    M=D
    
    @d4                 // display d4 in hextet 4
    D=M
    @Printdec_cursor
    M=M+1
    A=M
    M=D    
(PrintdecEnd)
    
(END)
    @END
    0;JMP

