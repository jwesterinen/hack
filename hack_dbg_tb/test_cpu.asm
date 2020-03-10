// test computation
        
    @9029   // 0x2345
    D=A     // D = 0x2345
    @4660   // A = 0x1234
    
    M=0     // 0x0000
    M=1     // 0x0001
    M=-1    // 0xffff
    M=D     // 0x2345
    M=A     // 0x1234
    M=!D    // 0xdcba
    M=!A    // 0xedcb
    M=-D    // 0xdcbb
    M=-A    // 0xedcc
    M=D+1   // 0x2346
    M=A+1   // 0x1235
    M=D-1   // 0x2344
    M=A-1   // 0x1233
    M=D+A   // 0x3579
    M=D-A   // 0x1111
    M=A-D   // 0xeeef
    M=D&A   // 0x0204
    M=D|A   // 0x3375
    M=A     // 0x1234
    M=!M    // 0xedcb
    M=-M    // 0x1235
    M=M+1   // 0x1236
    M=M-1   // 0x1235
    M=D+M   // 0x357a
    M=D-M   // 0xedcb
    M=M-D   // 0xca86
    M=D&M   // 0x0204
    M=D|M   // 0x2345

    // test destinations
        
    M=1     // write 0x0001 to 0x1234
    M=D     // write 0x2345 to 0x1234
    MD=1    // write 0x0001 to 0x1234, D = 0x0001
    M=D     // write 0x0001 to 0x1234
    A=M     // A = 0x0001
    M=A     // write 0x0001 to 0x0001
    
    @17767  // D = 0x4567
    D=A
    @13398  // A = 0x3456
    M=D    
    AM=M    // write 4567 to 3456, A = 0x4567
    M=A     // write 4567 to 4567
    
    @22136  // A = 0x5678
    M=D     // write 0x4567 to 0x5678
    AD=M    // A = 0x4567, D = 0x4567
    
    @26505  // A = 0x6789
    M=D     // write 0x4567 to 0x6789
    AMD=M   // write 0x4567 to 0x4567, A = 0x4567, D = 0x4567

    // test jumping
 
 (TEST_JLT)
    D=-1
    @TEST_JLE1
    D;JLT
    @0
    0;JMP
(TEST_JLE1)    
    @TEST_JEQ
    D;JLE        
    @0
    0;JMP
    D=0
(TEST_JEQ)    
    @TEST_JGE1
    D;JEQ
    @0
    0;JMP
(TEST_JGE1)    
    @TEST_JLE2
    D;JGE
    @0
    0;JMP
(TEST_JLE2)    
    @TEST_JGT
    D;JLE        
    @0
    0;JMP
    D=1
(TEST_JGT)    
    @TEST_JGE2
    D;JGT
    @0
    0;JMP
(TEST_JGE2)    
    @TEST_JNE
    D;JGE
    @0
    0;JMP
(TEST_JNE)    
    @TEST_JMP
    D;JNE
    @0
    0;JMP
(TEST_JMP)    
    @END
    0;JMP
    @0
    0;JMP
(END)    
    @END
    0;JMP
    
    
