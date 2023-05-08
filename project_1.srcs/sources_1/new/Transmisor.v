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
    output [4:0] counter_out
    );
    
    reg [4:0] counter = 5'd0; //0 -> 20
    reg busy = 0; //1 while sending data
    
    assign counter_out = counter;
    
    always @(posedge clk) begin
        if(send && !busy) begin 
            busy <= 1;
            counter <= 5'd0;
        end

        if(busy && (counter < 5'd20)) begin
            counter <= counter + 1;
        end else if (counter == 5'd20) begin
            counter <= 0;
            busy <= 0;
        end
    end
    
    always @(counter) begin
        case(counter)
            5'd0: tx <= 1; //idle
            5'd1: tx <= 0; //start
            5'd10: tx <= 1; //stop
            5'd11: tx <= 0; //2nd start
            5'd20: tx <= 1; //2nd stop
            default: begin
            if (counter >= 5'd12 && counter <= 5'd19)
                tx <= data[counter - 5'd12];
            else if (counter >= 5'd2 && counter <= 5'd9)
                tx <= data[counter - 5'd2];
            end
        endcase
    end
    
//    always @(posedge clk) begin        
//        if(busy) begin
//            case(counter)
//                5'd1: tx <= 0;
//                5'd10: tx <= 1;
//                5'd11: tx <= 0;
//                5'd20: begin
//                    tx <= 1;
//                    counter <= 0;
//                    busy <= 0;
//                end
//                default: begin
//                if (counter >= 5'd12 && counter <= 5'd19)
//                    tx <= data[5'd7 - (counter - 5'd12)];
//                else if (counter >= 5'd2 && counter <= 5'd9)
//                    tx <= data[5'd7 - (counter - 5'd2)];
//                end
//            endcase
//        end
        
//        if(!busy && send) begin
//            tx <= 0;
//        end else if ((!busy && !send) || counter == 5'd0) begin
//            tx <= 1;
//        end
//    end
    
endmodule
