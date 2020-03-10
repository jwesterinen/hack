// calc -- A simple, 4-function RPN calculator
//
//  Test case 1 -- nominal usage
//   Enter      Display
//   2           002
//   <enter>     002
//   3           003
//   +           005
//   8           008
//   -          -003
//   4           004
//   *          -012
//   3           003
//   /          -004
//   10          010
//   +           006
//   2           002
//   /           003
//
//  Test case 2 -- non-trivial expression, (11+5)/(6+2) = 2
//   <clr> 11 <enter> 5 + 6 <enter> 2 + /  should display 2
//


(Main)
    @isNewEntry         // set the new entry flag to true
    M=-1

    @R1                 // clear display
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @ClearDisplay
    0;JMP
(R1)    

(GetNextKey)
    @R2                 // keyValue = ReadKey()
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @ReadKey
    0;JMP
(R2)        
    @keyValue
    M=D
    
    @26                 // if (decimal key)
    D=D-A               //   get the rest of the entry
    @GetEntry
    D;JLT
    @isNewEntry         // else if (operation key && !isNewEntry)
    D=M                 //   push the entry then perform the operation
    @PushEntry
    D;JEQ
    @PerformOperation   // else 
    0;JMP               //   directly perform the operation

(GetEntry)    
    @15                 // mask off bit 4 (with 0x000f) to convert the keycode to an integer
    D=A
    @keyValue
    M=M&D
    
    @isNewEntry         // clear the display if this is a new entry, e.g. isNewEntry is true
    D=M
    @R3
    D;JEQ
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @ClearDisplay
    0;JMP
(R3)    
    
(AppendNewValue)
    @isNewEntry         // set the new entry flag to false
    M=0
    
    @R4                 // call AppendNum3(value) to rotate the new value into the display 
    D=A
    @SP                 // push retaddr
    M=M+1               
    A=M
    M=D
    @keyValue
    D=M
    @SP                 // push the new value
    M=M+1
    A=M
    M=D
    @AppendNum3
    0;JMP
(R4)
    
    @GetNextKey         // loop back to get another key
    0;JMP

(PushEntry)
    @R5                 // push the displayed value onto the expression stack
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @Getsd
    0;JMP
(R5) 
    @EP
    M=M+1
    A=M
    M=D

(PerformOperation)    
    @keyValue           // for "Enter" key go on to get the next entry
    D=M
    @26
    D=D-A
    @GetNextEntry
    D;JEQ    
    
    @keyValue           // for "Clr" key perform Clear routine
    D=M
    @30
    D=D-A
    @Clear
    D;JEQ    
    
    @keyValue           // for "+" key perform Add routine
    D=M
    @27
    D=D-A
    @Add
    D;JEQ    
    
    @keyValue           // for "-" key perform Subtract routine
    D=M
    @28
    D=D-A
    @Subtract
    D;JEQ    
    
    @keyValue           // for "*" key perform Subtract routine
    D=M
    @29
    D=D-A
    @Mult
    D;JEQ    
    
    @keyValue           // for "/" key perform Subtract routine
    D=M
    @31
    D=D-A
    @Div
    D;JEQ    
    
(Clear)
    @R6                 // reset the system and jump to Main()
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @ResetSys
    0;JMP
(R6)    
    @Main               // restart the program
    0;JMP

(Add)
    @EP                 // pop an addend into D
    M=M-1
    A=M+1
    D=M
    A=A-1               // store the sum of D and TOS into TOS
    M=M+D
    @PrintResult
    0;JMP

(Subtract)
    @EP                 // pop the subtrahend into D
    M=M-1
    A=M+1
    D=M
    A=A-1
    M=M-D               // store the difference between the subtrahend and dimenuend into TOS
    @PrintResult
    0;JMP

(Mult)
    @R7                 // push return address
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @EP                 // pop the multiplicand from Estack
    M=M-1
    A=M+1
    D=M
    @SP                 // push the multiplicand onto call stack
    M=M+1
    A=M
    M=D    
    @EP                 // pop the multiplier from Estack
    M=M-1
    A=M+1
    D=M
    @SP                 // push the multiplier onto call stack
    M=M+1
    A=M
    M=D
    @Multiply           // call Multiply()
    0;JMP
(R7)    
    @EP                 // push the returned product onto the Estack
    M=M+1
    A=M
    M=D
    @PrintResult
    0;JMP

(Div)
    @R8                 // push return address
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @EP                 // pop the divisor from Estack
    M=M-1
    A=M+1
    D=M
    @SP                 // push the divisor onto call stack
    M=M+1
    A=M
    M=D    
    @EP                 // pop the dividend from Estack
    M=M-1
    A=M+1
    D=M
    @SP                 // push the dividend onto call stack
    M=M+1
    A=M
    M=D
    @Divide             // call Divide()
    0;JMP
(R8)    
    @EP                 // push the returned quotient onto the Estack
    M=M+1
    A=M
    M=D
    @PrintResult
    0;JMP

(PrintResult)      
    @R9                 // push return address
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @EP                 // push value to print
    A=M
    D=M
    @SP
    M=M+1
    A=M
    M=D
    @Printsd            // jump to Printsd
    0;JMP
(R9)    
    
(GetNextEntry)    
    @isNewEntry         // set the new entry flag to true
    M=-1
    @GetNextKey         // loop back to get another entry
    0;JMP

(END)
    @END
    0;JMP


// subroutines


