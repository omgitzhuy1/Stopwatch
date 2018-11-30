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

// For Mode 01
module up_counter_preval(
    input clk,
    input [3:0] preval_2,
    input [3:0] preval_3,
    input s,
    input r, 
    output [3:0] an
    );
    
    reg [3:0] count;
   
    always @ (posedge clk or posedge r)
        begin
        if (r) 
            count = 4'b0000;
        else
            if (count == 4'b1001) 
                count = 4'b0000; 
            else
                count = count + 1'b1;   
        end
        assign an = count;
endmodule