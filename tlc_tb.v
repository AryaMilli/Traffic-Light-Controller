`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Create Date: 08.03.2023 11:15:07
// Design Name: 
// Module Name: tlc_tb
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
/*`define TRUE 1'b1
`define FALSE 1'b0

module tlc_tb();
wire[1:0]NS_SIG, EW_SIG;
reg VEHICLE_EW;
reg CLOCK, CLEAR;

//instantiate module for tlc 
traffic_controller TLC(.ns(NS_SIG), .ew(EW_SIG), .X(VEHICLE_EW), .clock(CLOCK), .clear(CLEAR));
initial 
begin 
    CLOCK=`FALSE;
    forever #5 CLOCK=~CLOCK; //clock pulse switching after every 5 unit delay
end 
initial
begin 
    CLEAR=`TRUE;
    repeat(5)@(negedge CLOCK);
    CLEAR=`FALSE;
end   

initial 
begin
VEHICLE_EW=`FALSE;
repeat(20)@(negedge CLOCK); VEHICLE_EW=`TRUE;
repeat(10)@(negedge CLOCK); VEHICLE_EW=`FALSE;
repeat(20)@(negedge CLOCK); VEHICLE_EW=`TRUE;
repeat(10)@(negedge CLOCK); VEHICLE_EW=`FALSE;
repeat(20)@(negedge CLOCK); VEHICLE_EW=`TRUE;
repeat(10)@(negedge CLOCK); VEHICLE_EW=`FALSE;
repeat(10)@(negedge CLOCK); $stop;
end
endmodule
*/

`include "traffic.v"

module traffic_mealy_tb;

wire ns_light;
wire ew_light;

reg X;
reg clock;
reg reset;

traffic dut(.ns_light(ns_light), .ew_light(ew_light), .X(X), .clock(clock), .reset(reset));
initial begin
forever #10 clock=~clock;
end 
initial begin
    clock=0;
    reset=0;
    X=0;
    #20 reset=1; 
    #20 reset=0;

    //sequence 1
    #20 X=0;
    #20 X= 1;
    #20 X=1;
    #20 X=0;

    //sequence 2
    #20 X=1;
    #20 X= 0;
    #20 X=0;
    #20 X=1;

    //sequence 3
    #20 X=0;
    #20 X= 0;
    #20 X=1;
    #20 X=1;

    //sequence 4
    #20 X=1;
    #20 X= 1;
    #20 X=0;
    #20 X=0;
end
endmodule