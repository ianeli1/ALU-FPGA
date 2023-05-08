`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 04:20:49 PM
// Design Name: 
// Module Name: Divisor
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


module Divisor(
    input [7:0] dividend,
    input [7:0] divisor,
    output [7:0] quotient
);
    wire [7:0] temp_result [7:0];
    wire [7:0] temp_concat [7:0];
    
    genvar i;
    generate
        for (i=0; i < 8; i = i+1) begin
            assign temp_concat[i] = {quotient[i:0], dividend[7:i]};
            assign temp_result[i] = (temp_concat[i] >= divisor) ? (temp_concat[i] - divisor) : temp_concat[i];
            assign quotient[i] = (temp_concat[i] >= divisor) ? 1'b1 : 1'b0;
        end
    endgenerate

//  wire [7:0] temp_result0, temp_result1, temp_result2, temp_result3;
//  wire [7:0] temp_result4, temp_result5, temp_result6, temp_result7;

//  assign temp_result0 = (dividend >= divisor) ? (dividend - divisor) : dividend;
//  assign quotient[0] = (dividend >= divisor) ? 1'b1 : 1'b0;

//  assign temp_result1 = (temp_result0 >= divisor) ? (temp_result0 - divisor) : temp_result0;
//  assign quotient[1] = (temp_result0 >= divisor) ? 1'b1 : 1'b0;
  
//  assign temp_result2 = (temp_result1 >= divisor) ? (temp_result1 - divisor) : temp_result1;
//  assign quotient[2] = (temp_result1 >= divisor) ? 1'b1 : 1'b0;
  
//  assign temp_result3 = (temp_result2 >= divisor) ? (temp_result2 - divisor) : temp_result2;
//  assign quotient[3] = (temp_result2 >= divisor) ? 1'b1 : 1'b0;
  
//  assign temp_result4 = (temp_result3 >= divisor) ? (temp_result3 - divisor) : temp_result3;
//  assign quotient[4] = (temp_result3 >= divisor) ? 1'b1 : 1'b0;
  
//  assign temp_result5 = (temp_result4 >= divisor) ? (temp_result4 - divisor) : temp_result4;
//  assign quotient[5] = (temp_result4 >= divisor) ? 1'b1 : 1'b0;
  
//  assign temp_result6 = (temp_result5 >= divisor) ? (temp_result5 - divisor) : temp_result5;
//  assign quotient[6] = (temp_result5 >= divisor) ? 1'b1 : 1'b0;
  
//  assign temp_result7 = (temp_result6 >= divisor) ? (temp_result6 - divisor) : temp_result6;
//  assign quotient[7] = (temp_result6 >= divisor) ? 1'b1 : 1'b0;

endmodule