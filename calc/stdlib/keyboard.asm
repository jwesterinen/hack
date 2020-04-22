// This file contains the keypad subroutines of the stdlib:
//   - ReadKey


// int ReadKey()
//   Waits until a key is pressed on the keypad and released, then returns the code of the pressed key.
//   Args: none
//   Return: keycode of the key pressed
//
//   Stack on entry:
//          keycode     (SP+1) [return value]
//     SP-> retaddr

(ReadKey)
    @KBD                // get the RE_value from the kbd buffer when it becomes non-zero
    D=M
    @ReadKey
    D;JEQ       
    @SP
    A=M+1
    M=D    

(RK_GetKeyRelease)    
    @KBD                // wait for RE_value 0 then get another key
    D=M
    @RK_GetKeyRelease
    D;JNE

(RK_Return)
    @SP                 // return the keycode into D
    A=M+1
    D=M
    @SP                 // pop the return address and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(ReadKey_End)


