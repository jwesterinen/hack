// This file contains the keypad subroutines of the stdlib:
//   - ReadKey


// int ReadKey()
//   Waits until a key is pressed on the keypad and released, then returns the code of the pressed key.
//   Args: none
//   Return: keycode of the key pressed
//
//   Stack on entry:
//     SP-> retaddr
//
//   The return value is written to the global variable "retval".
//

(ReadKey)
    @KBD                // get the RE_value from the kbd buffer when it becomes non-zero
    D=M
    @ReadKey
    D;JEQ       
    @retval
    M=D    

(RK_GetKeyRelease)    
    @KBD                // wait for RE_value to become 0 then return the key value
    D=M
    @RK_GetKeyRelease
    D;JNE

(RK_Return)
    @SP                 // pop the return address from the stack and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(ReadKey_End)


