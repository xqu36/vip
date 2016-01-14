`timescale 1 ns / 1 ps
`default_nettype none
module axi4_stream_user_processing_core_v1_0_S_AXIS #
(
    // Users to add parameters here

    // Total number of input data between TLAST assertions.
    parameter NUMBER_OF_INPUT_WORDS  = 512,

    // User parameters ends
    // Do not modify the parameters beyond this line

    // AXI4Stream sink: Data Width
    parameter integer C_S_AXIS_TDATA_WIDTH  = 32
)
(
    // Users to add ports here
    output wire [C_S_AXIS_TDATA_WIDTH-1:0] tdata_o,
    output wire tvalid_o,
    input wire tready_i,

    // User ports ends
    // Do not modify the ports beyond this line

    //Global ports
    input wire  S_AXIS_ACLK,
    input wire  S_AXIS_ARESETN,

    //AXIS Ports
    output wire  S_AXIS_TREADY,
    input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
    input wire  S_AXIS_TLAST,
    input wire  S_AXIS_TVALID
);

//Returns value of the ceiling of the log_base_2(input)
function integer clogb2 (input integer bit_depth);
  begin
    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
      bit_depth = bit_depth >> 1;
  end
endfunction

// bit_num gives the minimum number of bits needed to fit a counter for TLAST
localparam bit_num  = clogb2(NUMBER_OF_INPUT_WORDS-1);
reg [bit_num-1:0] write_counter;

//state machine
parameter [1:0] IDLE = 1'b0,        //idle
                WRITE_FIFO  = 1'b1; //transfer

reg mst_exec_state;
reg writes_done;
wire axis_tready;

// Control state machine implementation
always @(posedge S_AXIS_ACLK)
begin
    if (!S_AXIS_ARESETN)
          mst_exec_state <= IDLE;
    else
    case (mst_exec_state)
          IDLE:
                if (S_AXIS_TVALID)
                    mst_exec_state <= WRITE_FIFO;
                else
                    mst_exec_state <= IDLE;
          WRITE_FIFO:
                if (writes_done)
                    mst_exec_state <= IDLE;
                else
                    mst_exec_state <= WRITE_FIFO;
    endcase
end

assign axis_tready      = ((mst_exec_state == WRITE_FIFO) && (write_counter <= NUMBER_OF_INPUT_WORDS-1));
assign S_AXIS_TREADY    = tready_i & axis_tready;
assign tdata_o          = S_AXIS_TDATA;
assign tvalid_o         = S_AXIS_TVALID & axis_tready;

//Handle TLAST and state machine signals
always@(posedge S_AXIS_ACLK)
begin
    if(!S_AXIS_ARESETN)
        begin
            write_counter <= 0;
            writes_done <= 1'b0;
        end
    else if (write_counter <= NUMBER_OF_INPUT_WORDS-1)
        begin
            if (tvalid_o)
                begin
                    write_counter <= write_counter + 1;
                    writes_done <= 1'b0;
                end
            if ((write_counter == NUMBER_OF_INPUT_WORDS-1)|| S_AXIS_TLAST)
                begin
                      writes_done <= 1'b1;
                      write_counter <= 0;
                end
        end
end



// Add user logic here

// User logic ends

endmodule
`default_nettype wire
