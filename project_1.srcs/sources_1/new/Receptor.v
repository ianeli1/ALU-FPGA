`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 03:35:46 PM
// Design Name: 
// Module Name: Receptor
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


module Receptor(
    input clk,
    input reset,
    input rx,
    output reg ready,
    output reg [23:0]data, //3 bytes
    output reg busy,
    output [4:0] counter_out
    );
    
    //counter from 0 - 30
    reg [4:0] counter = 5'd0;
    
    assign counter_out = counter;
    
    always @(posedge clk) begin
        if(reset) begin
            counter = 5'd0;
            data = 24'd0; 
            busy = 0;
            ready = 0;
        end
    
        if(!busy && !rx) begin
            busy = 1;
            ready = 0;
            counter = 5'd0;
        end
        
        if(busy) begin
            counter = counter + 1;
            case(counter)
                5'd0: ; //idle
                5'd1, 5'd11, 5'd21: ;//start bit
                5'd10, 5'd20, 5'd30: ;//stop bit
                default: begin //data bits
                    if(counter >= 5'd2 && counter <= 5'd9)
                        data[counter - 5'd2] <= rx;
                    else if(counter >= 5'd12 && counter <= 5'd19)
                        data[counter - 5'd4] <= rx;
                    else if (counter >= 5'd22 && counter <= 5'd29)
                        data[counter - 5'd6] <= rx;
                end
            endcase
            
            if(counter >= 5'd30) begin
            busy <= 0;
            ready <= 1;
            counter <= 0;
        end
        end
    end
    
//    always @(posedge clk) begin
//        if(reset) begin
//            ready <= 0;
//            data <= 8'd0;
//            counter <= 4'd0;
//            busy <= 0;
//        end else begin
//            if(counter == 0 && !rx && !busy) begin
//                busy <= 1;
//            end
            
//            if(busy) begin
//                data[counter] <= rx;
//                counter <= counter + 1;
//            end
            
//            if(counter == 31) begin
//                counter <= 0;
//                busy <= 0;
//            end
//        end
//    end
    
endmodule