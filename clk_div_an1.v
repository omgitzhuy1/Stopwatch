`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 03:35:20 PM
// Design Name: 
// Module Name: clk_div_an1
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


module clk_div_an1(
    input clk,
    input reset,
    output slow_clk
    );
    
    reg [22:0] COUNT;      //use 2 for simulation and 26 for board 
    
    assign slow_clk=COUNT[22]; //use 2 for simulation and 26 for board 
    
    always @( posedge clk)
    begin 
    if (reset)
        COUNT = 0;
    else 
        COUNT = COUNT + 1;
    end
endmodule
