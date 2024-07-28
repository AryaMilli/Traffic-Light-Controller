`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2023 08:47:31
// Design Name: 
// Module Name: traffic_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// +
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define TRUE 1'b1
`define FALSE 1'b0
`define Y2Rdelay 4
//`define R2Gdelay 2 

//define clock and clear 
 module traffic_controller(ns, ew, X, clock, clear);
output reg[1:0]ns, ew;
input X;
input clock, clear; 

//parameters are constant throughtout, don't belong to any datatype like register
parameter red=2'd0, yellow= 2'd1, green= 2'd2;
parameter s0=3'd0,s1=3'd1,s2=3'd2,s3=3'd3;

//outputs in form of registers 
reg[2:0] c_state;
reg[2:0] n_state; 

always@(posedge clock) //loop for moving from one state to another 
if (clear)
//start at s0 
    c_state<=s0;
else 
//state change 
    c_state<=n_state;
 always@(c_state) 
 
 case(c_state)
    s0:  begin //initial condition of the state machine 
         ns= green;
         ew=red;
         end
    s1:  ns=yellow;
    s2:  begin 
         ns=red;
         ew=green;
         end 
    s3:  ew=yellow; 
 endcase
 
 always@(c_state or X)
 begin 
    case(c_state)
        s0: if(X)
           n_state=s1;
           else
           n_state=s0;
         s1: begin
          // repeat(`Y2Rdelay)@(posedge clock); non synthesizable delay
          if(counter==4) begin
             n_state=s2;
             counter<=0;
             end 
             else counter<=counter+1;
          end
         s2: if(X)
             n_state=s2;
             else 
             n_state=s3;
         s3: begin
          // repeat(`Y2Rdelay)@(posedge clock); non synthesizable delay
          if(counter==4) begin
             n_state=s0;
             counter<=0;
             end 
             else counter<=counter+1;
           end 
         default: n_state=s0;
    endcase
end 
endmodule
