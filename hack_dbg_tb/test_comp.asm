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


