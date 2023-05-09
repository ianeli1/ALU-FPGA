`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 06:22:11 PM
// Design Name: 
// Module Name: Transmisor
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


module Transmisor(
    input clk,
    input [15:0]data, //2 bytes
    input send, //starts sending data when 1
    output reg tx,
    output [4:0] counter_out,
    output busy_out
    );
    
    reg [4:0] counter = 5'd0; //0 -> 20
    reg busy = 0; //1 while sending data
    
    assign counter_out = counter;
    assign busy_out = busy;
    
    always @(posedge clk) begin
        if(send && !busy) begin
            busy = 1;
            counter = 5'd0;
        end
        
        if(busy) begin
            counter = counter + 1;
            case(counter)
                5'd0: tx <= 1; //idle
                5'd1, 5'd11: tx <= 0; //start bit
                5'd10, 5'd20: tx <= 1; //stop bit
                default: begin //data bits
                    if(counter >= 5'd2 && counter <= 5'd9)
                        tx <= data[counter - 5'd2];
                    else if(counter >= 5'd12 && counter <= 5'd19)
                        tx <= data[counter - 5'd4];
                end
            endcase
            
            if(counter >= 5'd20) begin
                busy <= 0;
                tx <= 1;
                counter <= 0;
            end
        end
    end
    
endmodule
