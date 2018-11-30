`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 07:13:09 PM
// Design Name: 
// Module Name: en_display
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


module en_display(
    input clk,
    output en_AN0,
    output en_AN1,
    output en_AN2,
    output en_AN3,
    output dp
    );
    
    reg [3:0] variable = 4'b0111;
    reg decimal = 1'b0;
    reg [16:0] reset = 0;
    
    assign en_AN0 = variable[3];    //assign an0 digit to 0 so turn on an0
    assign en_AN1 = variable[2];    //assign an1 digit to 1, so turn off an1
    assign en_AN2 = variable[1];    //assign an2 digit to 1, so turn off an2
    assign en_AN3 = variable[0];    //assign an3 digit to 1, so turn off an3
    assign dp = decimal;            //assign decimal pt to 0, so turn on dp
    reg resetclk = 0;               //
    reg resetCLK;
    
    always @ (posedge clk)          //this loop will produce resetclk since resetclk*reset = main clock
        begin        
        if (reset < 100000)         //about 2^17 bits since register reset is declared as [16:0]
            begin
            reset <= reset + 1;
            end
        else
            begin
            reset <= 0;             //restart reset counter 
            resetclk <= ~resetclk;  //resetclk signal is flipped when reset is greater than 100000
            end
        end 
    
    always @ (posedge resetclk) 
        begin
        variable <= {variable[0],variable[3:1]};  //shifted the variable to enable each digit 
        if (variable[2] == 0)                     
            decimal = 1'b0;
        else
            decimal = 1'b1;
        end
        
endmodule
