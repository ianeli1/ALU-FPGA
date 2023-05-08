`timescale 1us / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2023 09:11:13 PM
// Design Name: 
// Module Name: Transmisor_tb
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


module tb_Transmisor();

    reg clk;
    reg [15:0] data;
    reg send;
    wire tx;
    wire [4:0] counter_out;
    
    // Instantiate the UART transmitter module
    Transmisor transmitter (
        .clk(clk),
        .data(data),
        .send(send),
        .tx(tx),
        .counter_out(counter_out)
    );
    
    // Clock generation
    always begin
        #52 clk = ~clk; // 9600 Hz clock, period = 104us -> 104/2 = 52us for half period
    end
    
    // Testbench stimulus
    initial begin
        clk = 0;
        send = 0;
        data = 16'b00110000_00110001;
    
        // Send the data
        @(posedge clk) send <= 1;
        @(posedge clk) ;
        @(posedge clk) send <= 0;
    
        // Check for more data transmissions
        repeat(100) @(posedge clk);
    
        // Finish the simulation
        $finish;
    end
    
    // Monitor the transmitted bits and print to the console
    initial begin
        $monitor("Time: %0dns | tx: %b | busy", $time, tx, transmitter.busy);
    end

endmodule
