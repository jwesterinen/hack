// This file contains the display subroutines of the stdlib:
//   - ClearDisplay
//   - Getsd
//   - Printsd


// void ClearDisplay()
//   Clear the display by zeroing out the numerals and blanking the sign.
//   Args: none
//   Return: none
//
//   Stack on entry:
//     SP-> retaddr

(ClearDisplay)
    @0                  // blank the sign display and zero the 3 digits
    D=A
    @16384              //   0x4000 = 16384 -- display 1  (SCREEN)
    M=D
    @16385              //   0x4001 = 16385 -- display 2
    M=D
    @16386              //   0x4002 = 16386 -- display 3
    M=D
    @18
    D=A
    @16387              //   0x4003 = 16387 -- display 4
    M=D
(ClearDisplay_return)
    @SP                 // pop the return address from the stack and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(ClearDisplay_end)    

// int Getsd()
//   Convert the 3-digit display with sign to an integer and return it.
//   Args: none
//   Return: the value on the display
//
//   Stack on entry:
//          value       (SP+1) [return value]
//     SP-> retaddr

(Getsd)
    @SP                 // init the result to 0
    A=M+1
    M=0
    
    @16384              // store the display digits
    D=M
    @Getsd_d1
    M=D
    @16385
    D=M
    @Getsd_d2
    M=D
    @16386
    D=M
    @Getsd_d3
    M=D    
    @18                 // no way to enter a neg number so it's always blank, i.e positive                     
    D=A
    @Getsd_sign
    M=D
    
(Getsd_d3_loop)
    @Getsd_d3           // add the number of 100's in d3 to the result
    D=M
    @Getsd_d2_loop
    D;JEQ
    @100
    D=A
    @SP
    A=M+1
    M=M+D
    @Getsd_d3
    M=M-1
    @Getsd_d3_loop
    0;JMP
    
(Getsd_d2_loop)
    @Getsd_d2           // add the number of 10's in d2 to the result
    D=M
    @Getsd_d1_loop
    D;JEQ
    @10
    D=A
    @SP
    A=M+1
    M=M+D
    @Getsd_d2
    M=M-1
    @Getsd_d2_loop
    0;JMP
    
(Getsd_d1_loop)
    @Getsd_d1           // add d1 to the result and put it in D
    D=M
    @SP
    A=M+1
    D=M+D               // return the value in D

(Getsd_return)    
    @SP                 // return by popping the return address from the stack
    M=M-1
    A=M+1
    A=M
    0;JMP
(Getsd_end)    

// TODO: change to result on the stack
// Convert the 4-digit display to an integer in D
(Getd)
    @Getd_value         // init the value to 0
    M=0
    
    @16384              // store the display digits
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
    
(Getd_d4_loop)
    @Getd_d4            // add the number of 1000's in d4 to the result
    D=M
    @Getd_d3_loop
    D;JEQ
    @1000
    D=A
    @Getd_value
    M=M+D
    @Getd_d4
    M=M-1
    @Getd_d4_loop
    0;JMP
    
(Getd_d3_loop)
    @Getd_d3            // add the number of 100's in d3 to the result
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
    
(Getd_d2_loop)
    @Getd_d2           // add the number of 10's in d2 to the result
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
    
(Getd_d1_loop)
    @Getd_d1           // add d1 to the result and put it in D
    D=M
    @Getd_value
    D=M+D

(Getd_return)    
    @SP                 // return by popping the return address from the stack
    M=M-1
    A=M+1
    A=M
    0;JMP
(Getd_end)    

// TODO: change to result on the stack
// Convert the 4-hextet display to an integer in D
(Geth)
    @Geth_value         // init the value to 0
    M=0
    
    @16384              // store the display digits
    D=M
    @Geth_d1
    M=D
    @16385
    D=M
    @Geth_d2
    M=D
    @16386
    D=M
    @Geth_d3
    M=D
    @16387
    D=M
    @Geth_d4
    M=D
    
(Geth_d4_loop)
    @Geth_d4            // add the number of 0x1000's in d4 to the result
    D=M
    @Geth_d3_loop
    D;JEQ
    @4096
    D=A
    @Geth_value
    M=M+D
    @Geth_d4
    M=M-1
    @Geth_d4_loop
    0;JMP
    
(Geth_d3_loop)
    @Geth_d3            // add the number of 0x100's in d3 to the result
    D=M
    @Geth_d2_loop
    D;JEQ
    @256
    D=A
    @Geth_value
    M=M+D
    @Geth_d3
    M=M-1
    @Geth_d3_loop
    0;JMP
    
(Geth_d2_loop)
    @Geth_d2            // add the number of 0x10's in d2 to the result
    D=M
    @Geth_d1_loop
    D;JEQ
    @16
    D=A
    @Geth_value
    M=M+D
    @Geth_d2
    M=M-1
    @Geth_d2_loop
    0;JMP
    
(Geth_d1_loop)
    @Geth_d1            // add d1 to the result and put it in D
    D=M
    @Geth_value
    D=M+D

(Geth_return)    
    @SP                 // return by popping the return address from the stack
    M=M-1
    A=M+1
    A=M
    0;JMP
(Geth_end)    

// void Printsd(value)
//   Display the 16-bit integer value as 3 digits and a sign.  The range of 
//   value is -999 to 999.  If value is outside of the allowable range, "----"
//   is displayed.
//   Args:
//     value: the integer value to display
//   Return: none
//
//   Stack on entry:
//     SP-> value
//          retaddr      (SP-1)

(Printsd)
    @SP                 // check for overflow (D <= -1000 | 1000 <= D)
    A=M
    M=D
    @CheckOFNeg
    D;JLT
(Printsd_CheckOFPos)    
    @1000               // check for positive overflow
    D=D-A
    @Printsd_NoOverflow
    D;JLT
    @Printsd_Overflow
    0;JMP    
(CheckOFNeg)    
    @1000               // check for negative overflow
    D=D+A
    @Printsd_NoOverflow
    D;JGT
    
(Printsd_Overflow)    
    @16                 // display "----"  
    D=A
    @Printsd_d1
    M=D
    @Printsd_d2
    M=D
    @Printsd_d3
    M=D
    @Printsd_sign
    M=D
    @Printsd_Display_Digits
    0;JMP
    
(Printsd_NoOverflow)      
    @Printsd_d1         // init the digit values to 0
    M=0
    @Printsd_d2
    M=0
    @Printsd_d3
    M=0    
    @18                 // init the sign to a blank
    D=A
    @Printsd_sign
    M=D
    
    @SP                 // if the value is negative negate it and set the negative sign
    A=M
    D=M
    @Printsd_d3_loop
    D;JGE
    @SP
    A=M
    M=-D
    @16
    D=A
    @Printsd_sign
    M=D
    
(Printsd_d3_loop)       // calculate the number of 100's
    @SP
    A=M
    D=M 
    @100
    D=D-A
    @Printsd_d2_loop
    D;JLT
    @SP
    A=M
    M=D
    @Printsd_d3
    M=M+1
    @Printsd_d3_loop
    0;JMP
    
(Printsd_d2_loop)       // calculate the number of 10's
    @SP
    A=M
    D=M
    @10
    D=D-A
    @Printsd_d1_loop
    D;JLT
    @SP
    A=M
    M=D
    @Printsd_d2
    M=M+1
    @Printsd_d2_loop
    0;JMP
    
(Printsd_d1_loop)       // d1 is the remainder
    @SP
    A=M
    D=M
    @Printsd_d1
    M=D
    
(Printsd_Display_Digits)
    @Printsd_d1
    D=M
    @16384
    M=D
    @Printsd_d2
    D=M
    @16385
    M=D
    @Printsd_d3
    D=M
    @16386
    M=D
        
    @Printsd_sign       // set the sign in d4 @ 0x4003
    D=M
    @16387
    M=D

(Printsd_return)    
    @SP
    M=M-1               // pop the parameter from the stack
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(Printsd_end)    

// TODO: !!!UNTESTED!!!
// void Printd(value)
//   Display the given 16-bit integer as 4 digits
//   Args:
//     1: value to print
//   Return: none

(Printd)
    @SP                 // pop arg1 into local var
    M=M-1
    A=M+1
    D=M
    @Printd_value
    M=D

    @Printd_CheckOFNeg  // check for overflow (D <= -10000 | 10000 <= D)
    D;JLT
(Printd_CheckOFPos)    
    @10000              // check for positive overflow
    D=D-A
    @Printd_Overflow
    D;JLE
    @Printd_NoOverflow
    0;JMP    
(Printd_CheckOFNeg)    
    @1000               // check for negative overflow
    D=D+A
    @Printd_NoOverflow
    D;JGT
    
(Printd_Overflow)    
    @16                 // display "----"  
    D=A
    @Printd_d1
    M=D
    @Printd_d2
    M=D
    @Printd_d3
    M=D
    @Printd_sign
    M=D
    @Printd_Display_Digits
    0;JMP
    
(Printd_NoOverflow)      
    @Printd_d1         // init the digit values to 0
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
    @SP                 // pop the return address from the stack and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(Printd_end)    

// TODO: !!!UNTESTED!!!
// void Printh(value)
//   Display the given 16-bit integer as 4 hextets
//   Args:
//     1: value to print
//   Return: none

(Printh)
    @SP                 // pop arg1 into local var
    M=M-1
    A=M+1
    D=M
    @Printh_value
    M=D

    @Printh_d1         // init the digit values to 0
    M=0
    @Printh_d2
    M=0
    @Printh_d3
    M=0    
    @Printh_d4
    M=0
    
(Printh_d4_loop)       // calculate the number of 0x1000's
    @Printh_value
    D=M 
    @4096
    D=D-A
    @Printh_d3_loop
    D;JLT
    @Printh_value
    M=D
    @Printh_d4
    M=M+1
    @Printh_d4_loop
    0;JMP
    
(Printh_d3_loop)       // calculate the number of 0x100's
    @Printh_value
    D=M 
    @256
    D=D-A
    @Printh_d2_loop
    D;JLT
    @Printh_value
    M=D
    @Printh_d3
    M=M+1
    @Printh_d3_loop
    0;JMP
    
(Printh_d2_loop)       // calculate the number of 0x10's
    @Printh_value
    D=M
    @16
    D=D-A
    @Printh_d1_loop
    D;JLT
    @Printh_value
    M=D
    @Printh_d2
    M=M+1
    @Printh_d2_loop
    0;JMP
    
(Printh_d1_loop)       // d1 is the remainder
    @Printh_value
    D=M
    @Printh_d1
    M=D
    
(Printh_Display_Digits)
    @Printh_d1
    D=M
    @16384
    M=D
    @Printh_d2
    D=M
    @16385
    M=D
    @Printh_d3
    D=M
    @16386
    M=D
    @Printh_d4
    D=M
    @16387
    M=D

(Printh_return)    
    @SP                 // pop the return address from the stack and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(Printh_end)    

// void AppendNum3(value)
//   Shift in the given value to the display into the LS digit.
//   Args:
//     value: value to shift in
//   Return: none
//
//   Stack on entry:
//     SP-> value
//          retaddr      (SP-1)

(AppendNum3)    
    @16385              // left shift the new value into the frame buffer (at 0x4000-0x4002)
    D=M
    @16386
    M=D
    @16384
    D=M
    @16385
    M=D
    @SP
    A=M
    D=M
    @16384
    M=D

(AppendNum3_Return)    
    @SP
    M=M-1               // pop the parameter
    M=M-1               // pop the return address and return
    A=M+1
    A=M
    0;JMP
(AppendNum3_End)    

