`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 04:09:43 PM
// Design Name: 
// Module Name: clk_div_disp
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


module clk_div_an0(
    input clk,
    input reset,
    output slow_clk
    );
    
    reg [18:0] COUNT;      //.01 sec
    
    assign slow_clk=COUNT[18];  
    
    always @(posedge clk)
    begin 
    if (reset)
        COUNT = 0;
    else 
        COUNT = COUNT + 1;
    end
endmodule