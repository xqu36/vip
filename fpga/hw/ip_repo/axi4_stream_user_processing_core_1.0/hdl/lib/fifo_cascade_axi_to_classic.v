`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/08/2015
// Design Name:
// Module Name: fifo_cascade_axi_to_classic
// Project Name:
// Target Devices:
// Tool Versions:
// Description: This FIFO exists to provide an intermediate point for data
//              coming from/going to the external world as it interfaces with
//              the Zynq processing system in the AXI interface domain.
//              This module has a fifo_short on one side, and an axi_fifo_short
//              on the other.
//              Note - This file has been derived from the Ettus Research open
//                     source GPL FPGA repository for the USRP. The original
//                     copyright notice is included below.
//
// Dependencies: fifo_short, fifo_long, axi_fifo_short
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

module fifo_cascade_axi_to_classic #
(
    parameter WIDTH=32, SIZE=9
)
(
    //System inputs
    input wire clk,
    input wire reset,
    input wire clear,

    //Incoming data
    input wire [WIDTH-1:0] tdata_i,     //axi data in
    input wire tvalid_i,                //external source has data available
    output wire tready_i,               //internal FIFO has room available

    //Outgoing data
    output wire [WIDTH-1:0] dataout,    //raw data out
    output wire src_rdy_o,              //internal FIFO has data available
    input wire dst_rdy_i,               //external destination has room available

    //FIFO contents status
    output wire [15:0] space,
    output wire [15:0] occupied
);

wire [WIDTH-1:0] data_int, data_int2;
wire src_rdy_1, dst_rdy_1, src_rdy_2, dst_rdy_2;

wire [5:0]  s1_space, s1_occupied;
wire [4:0]  s2_space, s2_occupied;
wire [15:0] l_space, l_occupied;


//Short input FIFO for AXI domain
axi_fifo_short #(.WIDTH(WIDTH)) head_fifo (
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .i_tdata(tdata_i),
    .i_tvalid(tvalid_i),
    .i_tready(tready_i),    //note - this is an output! Indicates that this FIFO has space available
    .o_tdata(data_int),
    .o_tvalid(src_rdy_1),
    .o_tready(dst_rdy_1),   //note - this is an input! Next fifo has available space
    .space(s1_space),
    .occupied(s1_occupied)
);


//Central block RAM FIFO for data buffering
fifo_long #(.WIDTH(WIDTH),.SIZE(SIZE)) middle_fifo (
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .datain(data_int),
    .src_rdy_i(src_rdy_1),
    .dst_rdy_o(dst_rdy_1),
    .dataout(data_int2),
    .src_rdy_o(src_rdy_2),
    .dst_rdy_i(dst_rdy_2),
    .space(l_space),.occupied(l_occupied)
);

//Short output FIFO for other logic blocks
fifo_short #(.WIDTH(WIDTH)) tail_fifo (
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .datain(data_int2),
    .src_rdy_i(src_rdy_2),
    .dst_rdy_o(dst_rdy_2),
    .dataout(dataout),
    .src_rdy_o(src_rdy_o),
    .dst_rdy_i(dst_rdy_i),
    .space(s2_space),.occupied(s2_occupied)
);

assign space = {10'b0,s1_space} + {11'b0,s2_space} + l_space;
assign occupied = {10'b0,s1_occupied} + {11'b0,s2_occupied} + l_occupied;

endmodule









