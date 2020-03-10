// test jumping
 
(TEST_JLT)
    D=-1        // 0
    @TEST_JLE1
    D;JLT
    @FAIL
    0;JMP
(TEST_JLE1)    
    @TEST_JEQ   // 5
    D;JLE        
    @FAIL
    0;JMP
(TEST_JEQ)    
    D=0         // 9
    @TEST_JGE1
    D;JEQ
    @FAIL
    0;JMP
(TEST_JGE1)    
    @TEST_JLE2  // 14
    D;JGE
    @FAIL
    0;JMP
(TEST_JLE2)    
    @TEST_JGT   // 18
    D;JLE        
    @FAIL
    0;JMP
(TEST_JGT)    
    D=1         // 22
    @TEST_JGE2
    D;JGT
    @FAIL
    0;JMP
(TEST_JGE2)    
    @TEST_JNE   // 27
    D;JGE
    @FAIL
    0;JMP
(TEST_JNE)    
    @TEST_JMP   // 31
    D;JNE
    @FAIL
    0;JMP
(TEST_JMP)    
    @PASS       // 35
    0;JMP
    @FAIL
    0;JMP
(PASS)    
    @PASS       // 39
    0;JMP
(FAIL)
    @FAIL       // 41
    0;JMP
    
