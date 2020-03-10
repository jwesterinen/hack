    @4660   // 0x1234
    D=A
    @16384  // 0x4000, display
    M=D     // write 0x1234 to display
    @24576  // 0x6000, keyboard
    D=M
    @16384  // 0x4000, display
    M=D     // write keyboard to display

