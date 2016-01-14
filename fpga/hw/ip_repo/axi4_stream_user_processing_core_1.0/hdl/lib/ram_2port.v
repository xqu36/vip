`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/09/2015
// Design Name:
// Module Name: ram_2port
// Project Name:
// Target Devices:
// Tool Versions:
// Description: 2-port RAM module for use in various FIFOs
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

module ram_2port #
(
    parameter DWIDTH=32,
    parameter AWIDTH=9
)
(
    //Port 1 inputs
    input wire clka,
    input wire ena,
    input wire wea,
    input wire [AWIDTH-1:0] addra,
    input wire [DWIDTH-1:0] dia,
    output reg [DWIDTH-1:0] doa,

    //Port 2 inputs
    input wire clkb,
    input wire enb,
    input wire web,
    input wire [AWIDTH-1:0] addrb,
    input wire [DWIDTH-1:0] dib,
    output reg [DWIDTH-1:0] dob
);

//Storage elements and initialization
reg [DWIDTH-1:0] ram [(1<<AWIDTH)-1:0];

//Memory read/write logic
always @(posedge clka)
begin
    if (ena)
        begin
            if (wea)
                begin
                    ram[addra] <= dia;
                end
                
            doa <= ram[addra];
        end
end


always @(posedge clkb)
begin
    if (enb)
        begin
            if (web)
                begin
                    ram[addrb] <= dib;
                end
                
            dob <= ram[addrb];
        end
end


endmodule // ram_2port
