`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/08/2015
// Design Name:
// Module Name: fifo_short
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Short fifo based on SRL16 primatives.
//              Note - This file has been adopted from the Ettus Research open
//                     source GPL FPGA repository for the USRP. The original
//                     copyright notice is included below.
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2011 Ettus Research LLC
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
module fifo_short #
(
    parameter WIDTH=32
)
(
    //System inputs
    input wire  clk,
    input wire  reset,
    input wire  clear,

    //Incoming data
    input wire  [WIDTH-1:0] datain,
    input wire  src_rdy_i,
    output wire dst_rdy_o,

    //Outgoing data
    output wire [WIDTH-1:0] dataout,
    output wire src_rdy_o,
    input wire  dst_rdy_i,

    output reg [4:0] space,
    output reg [4:0] occupied
);

reg full, empty;
wire write;        
wire read;
         
assign write = src_rdy_i & dst_rdy_o;
assign read = dst_rdy_i & src_rdy_o;
assign dst_rdy_o  = ~full;
assign src_rdy_o  = ~empty;

reg [3:0] a;

//Create FIFO elements
genvar i;
generate
    for (i=0;i<WIDTH;i=i+1)
        begin : gen_srl16
                SRL16E srl16e (
                    .Q(dataout[i]),
                    .A0(a[0]),.A1(a[1]),.A2(a[2]),.A3(a[3]),
                    .CE(write),
                    .CLK(clk),
                    .D(datain[i])
                );
        end
endgenerate

//Handle addressing, empty, and full flags
//NOTE will fail if you write into a full fifo or read from an empty one
always @(posedge clk)
begin
    if(reset)
        begin
            a <= 0;
            empty <= 1;
            full <= 0;
        end
    else if(clear)
        begin
            a <= 0;
            empty <= 1;
            full<= 0;
        end
    else if(read & ~write)
        begin
            full <= 0;
            if(a==0)
                empty <= 1;
            else
                a <= a - 1;
        end
    else if(write & ~read)
        begin
            empty <= 0;
            if(~empty)
                a <= a + 1;
            if(a == 14)
                full <= 1;
        end
end


//////////////////////////////////////////////////////////////
// space and occupied are used for diagnostics, not
// guaranteed correct
always @(posedge clk)
begin
    if(reset)
        space <= 16;
    else if(clear)
        space <= 16;
    else if(read & ~write)
        space <= space + 1;
    else if(write & ~read)
        space <= space - 1;
end


always @(posedge clk)
begin
    if(reset)
        occupied <= 0;
    else if(clear)
        occupied <= 0;
    else if(read & ~write)
        occupied <= occupied - 1;
    else if(write & ~read)
        occupied <= occupied + 1;
end

endmodule

