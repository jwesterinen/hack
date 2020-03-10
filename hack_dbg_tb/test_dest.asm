// test destinations
    
    @1      // A = 1
    D=A+1   // D = 2
    M=D     // write 2 to 1
    @3      // A = 3
    MD=A+1  // write 4 to 3, D=4
    @4      // A = 4
    M=D+1   // write 5 to 4
    A=A+1   // A = 5
    M=D     // write 4 to 5
    @6      // A = 6
    AM=A+1  // write 7 to 6, A = 7
    M=D     // write 4 to 7
    @7      // A = 7
    AD=A+1  // A = 8, D=8
    M=D     // write 8 to 8
    @9      // A = 9
    AMD=A+1 // write a to 9, A = a, D = a
    M=D+1   // write b to a

