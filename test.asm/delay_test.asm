// test program for DelayMs

    D=0
    @value
    M=D
    
(Loop)
    @R1                 // write the next value
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @value
    D=M
    @SP
    M=M+1
    A=M
    M=D
    @Printsd
    0;JMP
(R1)

    @R2                 // delay 1/2 sec
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @500
    D=A
    @SP
    M=M+1
    A=M
    M=D
    @DelayMs
    0;JMP
(R2)
    @value
    M=M+1
    @Loop
    0;JMP    

(END)
@END
0;JMP

