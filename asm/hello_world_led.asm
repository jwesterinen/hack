// test program for LED - blink the LED

    @state              // init LED to on
    M=-1
    
(Loop)
    @R1                 // set the current state of the LED via SetLed(state)
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
(R1)
    @R2                 // delay 1/5 sec
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
(R2)
    @state              // toggle LED state
    M=!M
    @Loop
    0;JMP    

(END)
@END
0;JMP

