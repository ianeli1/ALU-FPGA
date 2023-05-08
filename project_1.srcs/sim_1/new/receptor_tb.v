`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2023 10:53:40 PM
// Design Name: 
// Module Name: receptor_tb
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


module receptor_tb();
    
    reg clk;
    reg reset;
    reg tx;
    wire [23:0] received_data;
    wire ready;
    wire busy;
    wire [4:0] counter;
    
    Receptor receptor (
        .clk(clk),
        .reset(reset),
        .rx(tx),
        .ready(ready),
        .data(received_data),
        .busy(busy),
        .counter_out(counter)
    );
    
    // Clock generation
    always begin
        #5 clk = ~clk;
    end
    
    // Message generation
    task send_uart_byte(input [7:0] byte);
        integer i;
        begin
            tx = 1'b0; // Start bit
            #10;
            for (i = 0; i < 8; i = i + 1) begin
                tx = byte[i];
                #10;
            end
            tx = 1'b1; // Stop bit
            #10;
        end
    endtask
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        tx = 1'b1;
    
        // Apply reset
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
    
        // Send the message
        send_uart_byte(8'd0);
        send_uart_byte(8'd14);
        send_uart_byte(8'd22);
    
        // Wait for READY
        @(posedge ready);
        $display("Received data: %h", received_data);
        $finish;
    end
endmodule
