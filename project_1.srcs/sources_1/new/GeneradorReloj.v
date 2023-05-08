`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 04:02:45 PM
// Design Name: 
// Module Name: GeneradorReloj
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


module GeneradorReloj(
    input main_clk, //100MHz Basys3 clock
    output reg out_clk
    );
    
    reg [13:0] counter;
    
    always @(posedge main_clk) begin
        if(counter == 13'b1010001101001) begin //100,000 / 9600
            out_clk <= ~out_clk;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule