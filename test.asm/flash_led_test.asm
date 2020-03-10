// Test program to flash the LED.  Begin by flashing once then delay, then twice
// then delay, then once more then delay, ad infinitum.

    @number         // init the number of times to flash
    M=1

(LOOP)    
    @R1             // push the return address
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @200            // push the duration
    D=A
    @SP
    M=M+1
    A=M
    M=D
    @number         // push the number of times to flash
    D=M
    @SP
    M=M+1
    A=M
    M=D
    @FlashLed       // flash the LED via FlashLed(number, duration)
    0;JMP
(R1)
    @number         // increment the flash number
    M=M+1    
    
    @R2             // delay for 1 sec
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @1000
    D=A
    @SP
    M=M+1
    A=M
    M=D
    @DelayMs
    0;JMP
(R2)

    @LOOP           // flash again
    0;JMP
    
(END)
@END
0;JMP

