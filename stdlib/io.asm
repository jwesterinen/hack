// void SetLed(state)
//   Turn the LED on or off
//   Args:
//     state: the state to set the LED (on=-1, off=0)
//   Return: none
//
//   Stack on entry:
//     SP-> retaddr
//          state   (SP-1)

(SetLed) 
    @SP                 // write the state value to the LED
    A=M-1
    D=M 
    @28672
    M=D
(SetLed_return)    
    @SP
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(SetLed_end)    


// void FlashLed(number, duration)
//   Flash the LED the given number of times at the given duration.
//   Args:
//     number: the number of times to flash the LED
//     duration: the length of the flash in mSec
//   Return: none
//
//   Stack frame after setup (use BP to access arguments):
//     SP-> retaddr
//          number      (SP-1)
//          duration    (SP-2)

(FlashLed)              // preamble: setup the stack frame 
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

(FlashLed_Loop)
    @BP                 // if (number > 0) flash the LED
    A=M-1
    D=M
    @FlashLed_return
    D;JEQ
    @BP                 // decrement the number of times to flash
    A=M-1
    M=M-1
    
    @28672              // turn LED on and delay for the given duration
    M=-1
    @FlashLed_R1        // push the return addr
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @BP                 // push the duration from the stack (BP-2)
    A=M-1
    A=A-1
    D=M
    @SP
    M=M+1
    A=M
    M=D
    @DelayMs
    0;JMP
(FlashLed_R1)
    @28672              // turn LED off and delay for the given duration
    M=0
    @FlashLed_R2        // push the retur addr
    D=A
    @SP
    M=M+1               
    A=M
    M=D
    @BP                 // push the duration from the stack (BP-2)
    A=M-1
    A=A-1
    D=M
    @SP
    M=M+1
    A=M
    M=D
    @DelayMs
    0;JMP
(FlashLed_R2)
    @FlashLed_Loop      // loop back to next flash
    0;JMP

(FlashLed_return) 
    @BP                 // move BP to SP
    D=M
    @SP
    M=D    
    @SP                 // restore old BP
    A=M
    D=M
    @BP
    M=D        
    @SP                 // pop the 2 parameters from the stack
    M=M-1
    M=M-1
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(FlashLed_end)    


// void SetGpioDir(dir)
//   Set the direction of the GPIO.
//   Args:
//     dir: the direction to set the GPIO (out=-1, in=0)
//   Return: none
//
//   Stack frame:
//     SP-> retaddr
//          dir     (SP-1)

(SetGpioDir) 
    @SP                 // write the direction value of the GPIO pin
    A=M-1
    D=M 
    @28674
    M=D
(SetGpioDir_return)    
    @SP
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(SetGpioDir_end)    


// void SetGpio(state)
//   Set the state of the GPIO ouput.
//   Args:
//     state: the state to set the GPIO output (on=-1, off=0)
//   Return: none
//
//   Stack frame:
//     SP-> retaddr
//          state   (SP-1)

(SetGpio) 
    @SP                 // write the state value to the LED
    A=M-1
    D=M 
    @28673
    M=D
(SetGpio_return)    
    @SP
    M=M-1               // pop the return address from the stack and return
    A=M+1
    A=M
    0;JMP
(SetGpio_end)    


// int GetGpio()
//   Get the current state of the GPIO input.
//   Args: none
//   Return: the state of the GPIO input (on=-1, off=0)
//
//   Stack frame:
//     SP-> retaddr

(GetGpio) 
    @28673              // put the GPIO value into global retval
    D=M
    @retval
    M=D
(GetGpio_return)    
    @SP                 // pop the return address and return
    M=M-1
    A=M+1
    A=M
    0;JMP
(GetGpio_end)    

