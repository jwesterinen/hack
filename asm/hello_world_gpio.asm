// test program for GPIO - blink an external LED connected to the GPIO pin

    @R1                 // set GPIO dirction to out (-1)
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    D=-1
    @SP
    M=M+1
    A=M
    M=D
    @SetGpioDir
    0;JMP
(R1)
    
    @state              // init state to off
    M=0
    
(Loop)
    @R2                 // set the current state of the LED via SetGpio(state)
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
    @SetGpio
    0;JMP
(R2)
    @R3                 // delay 1/5 sec
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @200
    D=A
    @SP
    M=M+1
    A=M
    M=D
    @DelayMs
    0;JMP
(R3)
    @state              // toggle GPIO state
    M=!M
    @Loop
    0;JMP    

(END)
@END
0;JMP

