// test program for GPIO input - set the LED to the value of a switch connected to the GPIO pin

    @R1                 // set GPIO dirction to in (0)
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    D=0
    @SP
    M=M+1
    A=M
    M=D
    @SetGpioDir
    0;JMP
(R1)
        
(Loop)
    @R2                 // read the GPIO value
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @GetGpio
    0;JMP
(R2)
    @state
    M=D
        
    @R3                 // write the GPIO value to the LED
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @state
    D=M
    @SP
    M=M+1
    A=M
    M=D
    @SetLed
    0;JMP
(R3)    
    @Loop
    0;JMP    

(END)
@END
0;JMP

