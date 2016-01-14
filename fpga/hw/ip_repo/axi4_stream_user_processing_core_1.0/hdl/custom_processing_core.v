`timescale 1 ns / 1 ps
`default_nettype none
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/19/2015
// Design Name:
// Module Name: custom_processing_core
// Project Name:
// Target Devices:
// Tool Versions:
// Description: This module exists to provide a example processing core to
//              take input data, perform some action on it, and send it out
//              as output. Users should gut this and fill in with whatever
//              logic they wish.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module custom_processing_core #
(
    parameter DATWIDTH=32
)
(
    input wire clk,
    input wire reset,
    input wire [DATWIDTH-1:0] datain,
    input wire input_enable,
    output wire core_ready,
    output wire [DATWIDTH-1:0] dataout,
    output wire dataout_valid,
    input wire output_enable
);

wire xform_rdy;
reg [DATWIDTH-1:0] data_xform;

//perform action only when both input and output are ready
assign xform_rdy = input_enable & output_enable;

always @ (posedge clk)
begin
    if(reset)
            data_xform <= 0;
    else if (xform_rdy)
        begin
            data_xform <= datain + 1;
        end
end

//always ready unless in reset
assign core_ready = ~reset;

assign dataout_valid = xform_rdy;
assign dataout = data_xform;

endmodule

`default_nettype wire
