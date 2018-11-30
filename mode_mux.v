`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 12:10:17 AM
// Design Name: 
// Module Name: mode_mux
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


module mode_mux(
    input s,
    input r,
    input clk,
    input [1:0] mode,
    input [7:0] preval,
    output [6:0] seg
    );
    
    reg [3:0] AN0, AN1, AN2, AN3;
    wire slow_clk;
    reg en = 0;             //enable
    reg [6:0] sseg;
    reg [3:0] an_var;
    reg dp_var;
    //reg edge_clk = 0;
    
    always @ (*)
    begin
    if (s)
       en = ~en;
    end
    
    reg r_var_ff; // reset flipflop button for the signal
    reg r_var = 1; //reset the signal
    
    always @ (*)
    begin
    r_var_ff <= r_var; // reset signal equals button flipflop
       if (r)          // reset button flipflop is 1 and reset is 0
           r_var = ~r_var;
    end
    
    always @(posedge slow_clk) 
    begin
    case(mode) 
    
    2'b00 : 
    if (r_var == 1) 
       begin
       AN0 = 4'b0000;
       AN1 = 4'b0000;
       AN2 = 4'b0000;
       AN3 = 4'b0000;
       end
       else if (en == 1)
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
         
    2'b01 : 
    if (r_var == 1)
       begin
       AN0 = 4'b0000;
       AN1 = 4'b0000;
       if (preval[3:0] >= 4'b1001)
           AN2 <=  4'b1001;
       else 
           AN2 <= preval[3:0];       // digit ones place - 7 seg an2
       if (preval[7:4] >= 4'b1001)
           AN3 <= 4'b1001;
       else 
           AN3 <= preval[7:4];      // digit tens place - 7 seg an3
       end
    else if(en == 1)
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
              
    2'b10 :  
    if (r_var == 1) 
       begin
       AN0 = 4'b1001;
       AN1 = 4'b1001;
       AN2 = 4'b1001;
       AN3 = 4'b1001;
       end
       else if (en == 1)
       begin
           if (AN0 == 0)
           begin
           AN0 <= 9;
               if (AN1 == 0)
               begin
               AN1 <= 9;
                   if (AN2 == 0)
                   begin 
                   AN2 <= 9;
                       if (AN3 == 0)
                       begin
                       AN3 <= 0; AN2 <= 0; AN1 <= 0; AN0 <= 0;
                       end
                       else 
                       AN3 = AN3 - 1;
                       end
                   else 
                   AN2 = AN2 - 1;
                   end
               else
               AN1 = AN1 - 1;
               end
          else 
          AN0 = AN0 - 1; 
          end
    
    2'b11 : 
    if (r_var == 1)
       begin
       AN0 = 4'b1001;
       AN1 = 4'b1001;
       if (preval[3:0] >= 4'b1001)
           AN2 <=  4'b1001;
       else 
           AN2 <= preval[3:0];       // digit ones place - 7 seg an2
       if (preval[7:4] >= 4'b1001)
           AN3 <= 4'b1001;
       else 
           AN3 <= preval[7:4];      // digit tens place - 7 seg an3
       end 
       else if (en == 1)
               begin
                   if (AN0 == 0)
                   begin
                   AN0 <= 9;
                       if (AN1 == 0)
                       begin
                       AN1 <= 9;
                           if (AN2 == 0)
                           begin 
                           AN2 <= 9;
                               if (AN3 == 0)
                               begin
                               AN3 <= 0; AN2 <= 0; AN1 <= 0; AN0 <= 0;
                               end
                               else 
                               AN3 = AN3 - 1;
                               end
                           else 
                           AN2 = AN2 - 1;
                           end
                       else
                       AN1 = AN1 - 1;
                       end
                  else 
                  AN0 = AN0 - 1; 
                  end
       endcase
       end 
endmodule
