// getd test

    @16384          // init display to contain 1111
    M=1
    @16385
    M=1
    @16386
    M=1
    @16387
    M=1

    @R1             // get the value from the display and store in D
    D=A
    @returnAddr
    M=D
    @Getd
    0;JMP
(R1)
    
    @2222           // add 2222 to the value
    D=D+A
    @value
    M=D

    @R2             // print the value (should be 3333)
    D=A
    @returnAddr
    M=D
    @value
    D=M
    @Printd
    0;JMP
(R2)
    
(END)
    @END
    0;JMP
    

// subroutines
    
// Convert the 4-digit display to an integer in D
(Getd)
    @Getd_value
    M=0

    @16384          // store the display digits
    D=M
    @Getd_d1
    M=D
    @16385
    D=M
    @Getd_d2
    M=D
    @16386
    D=M
    @Getd_d3
    M=D
    @16387
    D=M
    @Getd_d4
    M=D
    
(Getd_d4_loop)      // add the number of 1000's in d4 to the result
    @Getd_d4
    D=M
    @Getd_d3_loop   // go on to the next digit if no more 1000's
    D;JEQ
    @1000           // add 1000 to the value
    D=A
    @Getd_value
    M=M+D
    @Getd_d4        // dec the number of 1000's
    M=M-1
    @Getd_d4_loop
    0;JMP

(Getd_d3_loop)      // add the number of 100's in d3 to the result
    @Getd_d3
    D=M
    @Getd_d2_loop
    D;JEQ
    @100
    D=A
    @Getd_value
    M=M+D
    @Getd_d3
    M=M-1
    @Getd_d3_loop
    0;JMP
    
(Getd_d2_loop)      // add the number of 10's in d2 to the result
    @Getd_d2
    D=M
    @Getd_d1_loop
    D;JEQ
    @10
    D=A
    @Getd_value
    M=M+D
    @Getd_d2
    M=M-1
    @Getd_d2_loop
    0;JMP
    
(Getd_d1_loop)      // add d1 to the result and put it in D
    @Getd_d1
    D=M
    @Getd_value
    D=M+D

(Getd_return)    
    @returnAddr     // return
    A=M
    0;JMP
(Getd_end)    

    
// Display the 16-bit integer value in the D reg as 4 digits    
(Printd)
    @Printd_value
    M=D
    
    @Printd_d1         // init the digit values
    M=0
    @Printd_d2
    M=0
    @Printd_d3
    M=0
    @Printd_d4
    M=0

(Printd_d4_loop)       // calculate the number of 1000's
    @Printd_value
    D=M
    @1000
    D=D-A
    @Printd_d3_loop
    D;JLT
    @Printd_value
    M=D
    @Printd_d4
    M=M+1
    @Printd_d4_loop
    0;JMP

(Printd_d3_loop)       // calculate the number of 100's
    @Printd_value
    D=M 
    @100
    D=D-A
    @Printd_d2_loop
    D;JLT
    @Printd_value
    M=D
    @Printd_d3
    M=M+1
    @Printd_d3_loop
    0;JMP
    
(Printd_d2_loop)       // calculate the number of 10's
    @Printd_value
    D=M
    @10
    D=D-A
    @Printd_d1_loop
    D;JLT
    @Printd_value
    M=D
    @Printd_d2
    M=M+1
    @Printd_d2_loop
    0;JMP
    
(Printd_d1_loop)       // d1 is the remainder
    @Printd_value
    D=M
    @Printd_d1
    M=D
    
(Printd_Display_Digits)
    @Printd_d1
    D=M
    @16384
    M=D
    @Printd_d2
    D=M
    @16385
    M=D
    @Printd_d3
    D=M
    @16386
    M=D
    @Printd_d4
    D=M
    @16387
    M=D
    
(Printd_return)    
    @returnAddr         // return
    A=M
    0;JMP
(Printd_end)    

