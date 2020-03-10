/******************************************************************************
*
*   4 x 4 keypad
*
*   Description:
*       Columns are driven, rows have pulldowns and are sensed.
*
*   Key Codes:
*       10 -- '0'
*       11 -- '1'
*       12 -- '2'
*       13 -- '3'
*       14 -- '4'       
*       15 -- '5'
*       16 -- '6'
*       17 -- '7'
*       18 -- '8'
*       19 -- '9'
*       1A -- <ENTR>
*       1B -- <UP>
*       1C -- <DOWN>
*       1D -- <RIGHT>
*       1E -- <CNCL>
*       1F -- <LEFT>
*       00 -- <none>
*       
******************************************************************************/

module keypad (
    input CLK,              // 16MHz clock
    input [3:0] ROWS,       // rows
    output [3:0] COLS,      // cols
    output [4:0] KEYCODE    // returned key code
);

    // scale the input clock to ~16ms
    wire CLK_16MS;
    prescaler #(.N(18)) ps2(CLK, CLK_16MS);
    
    reg [2:0] state = 0;
    reg [4:0] localKeycode = 0;
    
    initial KEYCODE <= 0;
        
    always @(posedge CLK_16MS) 
    begin
        case (state)
            0:
            begin
                COLS <= 4'b0001;
                case (ROWS)
                    4'b0001: localKeycode <= 5'h11;  // col 1 row 1
                    4'b0010: localKeycode <= 5'h14;  // col 1 row 2
                    4'b0100: localKeycode <= 5'h17;  // col 1 row 3
                    4'b1000: localKeycode <= 5'h1E;  // col 1 row 4
                    //default:
                endcase
            end
            1:
            begin
                COLS <= 4'b0010;
                case (ROWS)
                    4'b0001: localKeycode <= 5'h12;  // col 2 row 1
                    4'b0010: localKeycode <= 5'h15;  // col 2 row 2
                    4'b0100: localKeycode <= 5'h18;  // col 2 row 3
                    4'b1000: localKeycode <= 5'h10;  // col 2 row 4
                    //default:
                endcase
            end
            2:
            begin
                COLS <= 4'b0100;
                case (ROWS)
                    4'b0001: localKeycode <= 5'h13;  // col 3 row 1
                    4'b0010: localKeycode <= 5'h16;  // col 3 row 2
                    4'b0100: localKeycode <= 5'h19;  // col 3 row 3
                    4'b1000: localKeycode <= 5'h1F;  // col 3 row 4
                    //default:
                endcase
            end
            3:
            begin
                COLS <= 4'b1000;
                case (ROWS)
                    4'b0001: localKeycode <= 5'h1A;  // col 4 row 1
                    4'b0010: localKeycode <= 5'h1B;  // col 4 row 2
                    4'b0100: localKeycode <= 5'h1C;  // col 4 row 3
                    4'b1000: localKeycode <= 5'h1D;  // col 4 row 4
                    //default:
                endcase
            end
            4:
            begin
                KEYCODE <= localKeycode;
            end
            default:
            begin
                localKeycode <= 0;
            end
        endcase
        state++;
    end
    
endmodule
