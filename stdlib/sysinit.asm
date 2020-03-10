// This file contains the code that must be prepended to any program in order
// use the call stack, expression stack, or set up a stack frame.


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

