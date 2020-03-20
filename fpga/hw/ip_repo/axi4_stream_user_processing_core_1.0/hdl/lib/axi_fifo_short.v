`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/08/2015
// Design Name:
// Module Name: axi_fifo_short
// Project Name:
// Target Devices:
// Tool Versions:
// Description: 32 word FIFO with AXI4-STREAM interface. This module uses the
//              SRLC32E primitive explicitly and as such can only be used with
//              Xilinx technology of the VIRTEX-6/SPARTAN-6/SIERIES-7 or newer.
//
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
// Copyright 2012 Ettus Research LLC
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
//

module axi_fifo_short #
(
    parameter WIDTH=32
)
(
    //System inputs
    input wire  clk,
    input wire  reset,
    input wire  clear,

    //Incoming data
    input wire  [WIDTH-1:0] i_tdata,
    input wire  i_tvalid,
    output wire i_tready, //Note this is an output

    //Outgoing data
    output wire [WIDTH-1:0] o_tdata,
    output wire o_tvalid,
    input wire  o_tready, //Note this is an input

    output reg [5:0] space,
    output reg [5:0] occupied
);

reg full = 1'b0, empty = 1'b1;
wire write;
wire read;
reg [4:0] a;

assign write = i_tvalid & i_tready;
assign read = o_tready & o_tvalid;
assign i_tready  = ~full;
assign o_tvalid  = ~empty;

//Create the FIFO elements
genvar i;
generate
    for (i=0;i<WIDTH;i=i+1)
        begin : gen_srlc32e
                SRLC32E srlc32e (
                    .Q(o_tdata[i]),
                    .Q31(),
                    .A(a),
                    .CE(write),
                    .CLK(clk),
                    .D(i_tdata[i])
                );
        end
endgenerate

//Handle address, full, and empty signals
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
            if(a == 30)
                full <= 1;
        end
end


//////////////////////////////////////////////////////////////
// space and occupied are used for diagnostics, not
// guaranteed correct
always @(posedge clk)
begin
    if(reset)
        space <= 6'd32;
    else if(clear)
        space <= 6'd32;
    else if(read & ~write)
        space <= space + 6'd1;
    else if(write & ~read)
        space <= space - 6'd1;
end

always @(posedge clk)
begin
    if(reset)
        occupied <= 6'd0;
    else if(clear)
        occupied <= 6'd0;
    else if(read & ~write)
        occupied <= occupied - 6'd1;
    else if(write & ~read)
        occupied <= occupied + 6'd1;
end

endmodule // axi_fifo_short

