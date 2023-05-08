`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 04:00:08 PM
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//CLK100MHZ is the main 100MHz clock
//RsRx is the serial RX port

module main(
        input CLK100MHZ,
        input RsRx,
        input btnC,
        input btnU,
        output RsTx,
        output [15:0]LED,
        output jb_zero,
        output jb_one
    );
    
    assign jb_zero = RsRx;
    
    wire uart_clk;
    wire ready;
    wire busy;
    
    reg [15:0] data_sending = "01";
    
    assign jb_one = uart_clk;
    
    GeneradorReloj gen(.main_clk(CLK100MHZ), .out_clk(uart_clk));
    
    Receptor r(.clk(uart_clk), .reset(btnC), .rx(RsRx), .ready(ready), .data(LED), .busy(busy));
    
    Transmisor t(.clk(uart_clk), .data(data_sending), .send(btnU), .tx(RsTx), .counter_out());
endmodule