`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2018 04:11:15 PM
// Design Name: 
// Module Name: time_mux_state_machine
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


module time_mux_state_machine(
    input clk,
    input s,
    input r,
    input [3:0] AN0,
    input [3:0] AN1,
    input [3:0] AN2,
    input [3:0] AN3,
    output reg [3:0] an,
    output reg [6:0] sseg
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(*) begin
    case(state) //State transitions
        2'b00 : next_state = 2'b01;
        2'b01 : next_state = 2'b10;
        2'b10 : next_state = 2'b11;
        2'b11 : next_state = 2'b00;
        endcase
    end
    
    always @(*) begin
    case(state) //Multiplexer
        2'b00 : sseg = AN0;
        2'b01 : sseg = AN1; 
        2'b10 : sseg = AN2;// if (mode == 2'b00) sseg = AN2; else if(mode == preval[3:0]);
        2'b11 : sseg = AN3;// if (mode == 2'b00) sseg = AN2; else if(mode == preval[7:4]);
    endcase
    
    case(state) //Decoder
        2'b00 : an = 4'b1110;
        2'b01 : an = 4'b1101;
        2'b10 : an = 4'b1011;
        2'b11 : an = 4'b0111;
    endcase
    end
   
    always @(posedge clk or posedge r) begin
        if(r) 
            state <= 2'b00;
        else 
            state <= next_state;
    end
endmodule    
