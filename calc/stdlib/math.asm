// This file contains the math subroutines of the stdlib:
//   - Multiply
//   - Divide


// int Multiply(multiplier, multiplicand)
//   Return the product of the multiplicand and multiplier
//   Args:
//     multiplicand: number to add to itself multiplier times
//     multiplier: number of times multiplicand is added to itself
//   Return: product
//
//   Stack on entry:
//          product      (SP+1) [return value]
//     SP-> multiplier
//          multiplicand (SP-1)
//          retaddr      (SP-2)

(Multiply)
    @SP                 // init product
    A=M+1
    M=0
    
    @Mult_negate_prod   // init negate product flag to false
    M=0    
    @SP                 // check for a negative multiplier
    A=M
    D=M
    @Mult_L1
    D;JGE
    @Mult_negate_prod   // set the negate product flag to true
    M=!M
    @SP                 // negate the multiplier
    A=M
    M=-M
    
(Mult_L1)
    @SP                 // add the multiplicand to itself multiplier times
    A=M
    D=M                 // multiplier in D
    @Mult_L2
    D;JLE 
    @SP
    A=M
    M=M-1               // decrement multiplier, i.e. number of times to add multiplicand to itself
    A=A-1
    D=M
    @SP
    A=M+1
    M=M+D
    @Mult_L1
    0;JMP
    
(Mult_L2)    
    @Mult_negate_prod   // negate the product if the flag is set
    D=M
    @Multiply_return
    D;JEQ
    @SP
    A=M+1
    M=-M
    
(Multiply_return)
    @SP                 // return the product in D
    A=M+1
    D=M
    @SP
    M=M-1               // pop 2 args from the stack
    M=M-1
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(Multiply_end)


// int Divide(dividend, divisor)
//   Return the quotient, dividend/divisor.
//   Args:
//     dividend: the number divided by the divisor
//     divisor: the number with which to divide the dividend
//   Return: quotient
//
//   Stack on entry:
//          quotient    (SP+1) [return value]
//     SP-> dividend
//          divisor     (SP-1)
//          retaddr     (SP-2)

(Divide)
    @SP                 // init quotient
    A=M+1
    M=0
    
    @SP                 // check for divide by zero
    A=M-1
    D=M
    @Div_CheckNeg
    D;JNE
    @1000               // if so set quotient to out of range number (1000)
    D=A
    @SP
    A=M+1
    M=D
    @Divide_return
    0;JMP

(Div_CheckNeg)
    @Div_neg1           // check for neg dividend
    M=0    
    @SP
    A=M
    D=M
    @Divide_L2
    D;JGE
    @Div_neg1           // if so set flag to true and negate
    M=!M
    @SP
    A=M
    M=-M
(Divide_L2) 
    @Div_neg2           // check for neg divisor   
    M=0
    @SP
    A=M-1
    D=M
    @Divide_L1
    D;JGE
    @Div_neg2           // if so set flag to true and negate
    M=!M
    @SP
    A=M-1
    M=-M
   
(Divide_L1)
    @SP                 // stop when divisor > dividend
    A=M
    D=M                 // dividend in D
    A=A-1               // divisor in M
    D=D-M
    @Div_FixupSign
    D;JLT
    @SP                 // subtract divisor from current dividend until 0
    A=M-1
    D=M                 // divisor in D
    A=A+1               // dividend in M
    M=M-D               // reduce dividend by divisor
    @SP
    A=M+1
    M=M+1    
    @Divide_L1
    0;JMP
    
(Div_FixupSign)
    @Div_neg2           // if ((a & !b) | (!a & b)) negate quotient
    D=!M                // !b
    @Div_neg1
    D=D&M               // !b & a
    @Div_negate
    D;JNE
    @Div_neg1
    D=!M                // !a
    @Div_neg2
    D=D&M               // !a & b
    @Divide_return
    D;JEQ
(Div_negate)
    @SP
    A=M+1
    M=-M    

(Divide_return)    
    @SP                 // return the quotient in D
    A=M+1
    D=M
    @SP
    M=M-1               // pop the 2 parameters from the stack
    M=M-1
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(Divide_end)

