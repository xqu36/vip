`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/08/2015
// Design Name:
// Module Name: fifo_long
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Longer FIFO intended to be interchangeable with fifo_short.
//              Uses block RAM instead of SRL16 primatives.
//              Port A is write port, Port B is read port.
//              Note - This file has been adopted from the Ettus Research open
//                     source GPL FPGA repository for the USRP. The original
//                     copyright notice is included below.
// Dependencies: ram_2port
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

module fifo_long #
(
    parameter WIDTH=32, SIZE=9
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

    output reg [15:0] space,
    output reg [15:0] occupied
);

wire write;
wire read;
wire full, empty;

assign write = src_rdy_i & dst_rdy_o;
assign read = dst_rdy_i & src_rdy_o;
assign dst_rdy_o  = ~full;
assign src_rdy_o  = ~empty;

// Read side states
localparam EMPTY = 0;
localparam PRE_READ = 1;
localparam READING = 2;

reg [SIZE-1:0] wr_addr, rd_addr;
wire [SIZE-1:0] dont_write_past_me;
wire becoming_full;
reg [1:0]      read_state;
reg empty_reg, full_reg;

//Memory storage elements
ram_2port #(.DWIDTH(WIDTH),.AWIDTH(SIZE)) ram (
    .clka(clk),
    .ena(1'b1),
    .wea(write),
    .addra(wr_addr),
    .dia(datain),
    .doa(),
    .clkb(clk),
    .enb((read_state==PRE_READ)|read),
    .web(0),
    .addrb(rd_addr),
    .dib({WIDTH{1'b1}}),
    .dob(dataout)
);

//Write pointer logic 
always @(posedge clk)
begin
    if(reset)
        wr_addr <= 0;
    else if(clear)
        wr_addr <= 0;
    else if(write)
        wr_addr <= wr_addr + 1;
end

//Read pointer logic
always @(posedge clk)
begin
    if(reset)
        begin
            read_state <= EMPTY;
            rd_addr <= 0;
            empty_reg <= 1;
        end
    else if(clear)
        begin
            read_state <= EMPTY;
            rd_addr <= 0;
            empty_reg <= 1;
        end
    else
        begin
            case(read_state)
                EMPTY : begin
                            if(write)
                                read_state <= PRE_READ;
                        end
                PRE_READ: begin
                            read_state <= READING;
                            empty_reg <= 0;
                            rd_addr <= rd_addr + 1;
                          end
                READING : begin
                            if(read)
                                begin
                                    if(rd_addr == wr_addr)
                                        begin
                                            empty_reg <= 1;
                                            if(write)
                                              read_state <= PRE_READ;
                                            else
                                              read_state <= EMPTY;
                                        end
                                    else
                                        rd_addr <= rd_addr + 1;
                                end
                          end
            endcase
        end
end

//generate almost-full logic
assign dont_write_past_me = rd_addr - 3;
assign becoming_full = wr_addr == dont_write_past_me;


//Empty and Full logic
always @(posedge clk)
begin
    if(reset)
        full_reg <= 0;
    else if(clear)
        full_reg <= 0;
    else if(read & ~write)
        full_reg <= 0;
    else if(write & ~read & becoming_full)
        full_reg <= 1;
end

assign empty = empty_reg;
assign full = full_reg;

//////////////////////////////////////////////
// space and occupied are for diagnostics only
// not guaranteed exact
localparam NUMLINES = (1<<SIZE)-2;

always @(posedge clk)
begin
    if(reset)
        space <= NUMLINES;
    else if(clear)
        space <= NUMLINES;
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
