`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 04:04:19 PM
// Design Name: 
// Module Name: Stopwatch
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


module Stopwatch(
    input s,
    input r,
    input clk,
    output reg [3:0] an,
    output [6:0] seg,
    output dp
    );

    reg [3:0] AN0, AN1, AN2, AN3;
    integer en = 0; 
    wire slow_clk;

    always @ (posedge clk or posedge r)
    begin
    if (s)     //enable to control s
        begin
        if (~en)
            en = 1;
        else 
            en = 0;
        end
    if (r)
        begin
        AN0 <= 0;
        AN1 <= 0;
        AN2 <= 0;
        AN3 <= 0;
        end
    else if(clk && en)
        begin
           if (AN0 == 9)
           begin
           AN0 <= 0;
               if (AN1 == 9)
               begin
               AN1 <= 0;
                   if (AN2 == 9)
                   begin 
                   AN2 <= 0;
                       if (AN3 == 9)
                       begin
                       AN3 <= 9; AN2 <= 9; AN1 <= 9; AN0 <= 9;
                       end
                       else 
                       AN3 = AN3 + 1;
                       end
                   else 
                   AN2 = AN2 + 1;
                   end
               else
               AN1 = AN1 + 1;
               end
          else 
          AN0 = AN0 + 1; 
          end
       end
    
// 

    localparam X = 18;  // 18 bit , 10ms or the AN0 clockspeed count
    reg [X-1:0] count;
    
    always @(posedge clk)
        begin
        if (r)
            count <= 0;
        else 
            count <= count + 1;
        end
        
    reg dp_var;
    reg [6:0] sseg;

    always @(*)
        begin
        case(count[X-1:X-2])     //using only the 2 MSB's of the counter 
        2'b00:
        begin
        dp_var = 1'b1;
        sseg = AN0;
        an = 4'b1110;
        end
        
        2'b01:
        begin
        dp_var = 1'b1;
        sseg = AN1;
        an = 4'b1101;
        end
        
        2'b10:
        begin
        dp_var = 1'b0;
        sseg = AN2;
        an = 4'b1011;
        end
        
        2'b11:
        begin 
        dp_var = 1'b1;
        sseg = AN3;
        an = 4'b0111;
        end
        
        endcase
    end   
    reg [6:0] sseg_var;   // 7 bit register to hold the binary value of each input given
    always @ (*)
        begin
        case (sseg_var)
        4'b0000 : sseg_var = 7'b0000001;
        4'b0001 : sseg_var = 7'b1001111;
        4'b0010 : sseg_var = 7'b0010010;
        4'b0011 : sseg_var = 7'b0000110;
        4'b0100 : sseg_var = 7'b1001100;
        4'b0101 : sseg_var = 7'b0100100;
        4'b0110 : sseg_var = 7'b0100000;
        4'b0111 : sseg_var = 7'b0001111;
        4'b1000 : sseg_var = 7'b0000000;
        4'b1001 : sseg_var = 7'b0000100;
        default : sseg_var = 7'b0000001;  
        endcase
        end
        assign seg = sseg_var;    //concatenate the outputs to the sseg var
        assign dp = dp_var;
 
endmodule
