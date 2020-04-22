// This file contains the system subroutines of the stdlib:
//   - ResetSys
//   - DelayMs


// void ResetSys()
//   Reset the call and expression stacks.
//   Args: none
//   Return: none
//
//   Stack on entry:
//     SP-> retaddr

(ResetSys)
    @256                // init the call stack pointer
    D=A
    @SP
    M=D
    @512                // init the expression stack pointer
    D=A
    @EP
    M=D
    @768                // init the base pointer
    D=A
    @BP
    M=D
(ResetSys_return)
    @SP                 // pop the return address from the stack and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(ResetSys_end)


// void DelayMs(ms)
//   Delay the given number of mSec.
//   Args:
//     ms: the number of mSec to delay
//   Return: none
//
//   Stack on entry:
//     SP-> ms
//          retaddr (SP-1)

(DelayMs)
    @SP                 // exit if ms count is 0
    A=M
    D=M
    @DelayMs_return
    D;JEQ 
    @SP                 // decrement ms count
    A=M
    M=M-1 
    @8000               // number of cycles for one ms           
    D=A
(DelayMs_L2)
    @DelayMs_L2        // delay the specified number of ms
    D=D-1;JGT 
    @DelayMs
    0;JMP   
(DelayMs_return)    
    @SP
    M=M-1               // pop the parameter
    M=M-1               // pop the return address and return
    A=M+1
    A=M
    0;JMP
(DelayMs_end)    

