//  In general, the stack frame is setup to allow access to:
//   - passed parameters
//   - return value
//   - local variables
//
//   Stack frame after setup (use BP to access arguments):
//        SP->  local varN      (BP+(N+1))
//              ...
//              local var1      (BP+2)
//              return value    (BP+1)
//        BP->  old BP
//              parameterN      (BP-1)
//              ...
//              parameter1      (BP-N)
//              retaddr         (BP-3)



(Function)
                        // preamble: setup the stack frame
    @BP                 //  - push current BP
    D=M
    @SP
    M=M+1
    A=M
    M=D
    
    @SP                 //  - move SP to BP
    D=M
    @BP
    M=D
    
    @SP
    M=M+1               //  - adjust SP to point to return value
    
    @SP
    M=M+1               //  - adjust SP to point to local variables by
    ...                 //    incrementing SP N times
    M=M+1               // 

(Function_Main)    
    @BP                 // access parameterM
    A=M-1
    A=A-1               // do this N-M times (for parameter N omit this)
    ...
    ?=M

    @BP                 // access local varM
    A=M+1
    A=A+1               // do this M times
    ...
    ?=M
    
(Function_return)    
    @BP                 // move BP to SP
    D=M
    @SP
    M=D    
    @SP                 // restore old BP
    A=M
    D=M
    @BP
    M=D
            
    @SP                 // put the return value into D -- omit this for void function
    A=M+1
    D=M 
       
    @SP
    M=M-1               // pop old BP
    M=M-1               // do this N times to pop N parameters
    ...
    M=M-1               // pop the return address and return
    A=M+1
    A=M
    0;JMP
(Function_end)    

