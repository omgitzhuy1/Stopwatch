`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 04:07:20 PM
// Design Name: 
// Module Name: hexto7segment
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


module hexto7segment(
        input [3:0] hex,
        output reg [6:0] seg,
        output dp
        );
        
        always @(*)
        case (seg)
            4'b0000 : seg = 7'b0000001;
            4'b0001 : seg = 7'b1001111;
            4'b0010 : seg = 7'b0010010;
            4'b0011 : seg = 7'b0000110;
            4'b0100 : seg = 7'b1001100;
            4'b0101 : seg = 7'b0100100;
            4'b0110 : seg = 7'b0100000;
            4'b0111 : seg = 7'b0001111;
            4'b1000 : seg = 7'b0000000;
            4'b1001 : seg = 7'b0000100;
            default : seg = 7'b0000001;
            endcase
            assign dp = 4'b1011; // turn on AN2 decimal pt
      
endmodule
