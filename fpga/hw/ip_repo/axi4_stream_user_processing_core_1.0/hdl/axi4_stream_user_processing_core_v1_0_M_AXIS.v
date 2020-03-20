`timescale 1 ns / 1 ps
`default_nettype none
module axi4_stream_user_processing_core_v1_0_M_AXIS #
(
    // Users to add parameters here

    //Expected output packet length. Assert TLAST after this many transfers
    parameter NUMBER_OF_OUTPUT_WORDS = 512,

    // User parameters ends
    // Do not modify the parameters beyond this line
    parameter integer C_M_AXIS_TDATA_WIDTH  = 32,     // Width of AXIS bus.
    parameter integer C_M_START_COUNT   = 32          //reset counter
)
(
    // Users to add ports here
    input wire [C_M_AXIS_TDATA_WIDTH-1:0] tdata_i,
    input wire tvalid_i,
    output wire tready_o,
    // User ports ends
    // Do not modify the ports beyond this line

    // Global ports
    input wire  M_AXIS_ACLK,
    input wire  M_AXIS_ARESETN,

    //AXIS Ports
    output wire  M_AXIS_TVALID,
    output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
    output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB, //not used. set to 1;
    output wire  M_AXIS_TLAST,
    input wire  M_AXIS_TREADY
);


//Returns value of the ceiling of the log_base_2(input)
function integer clogb2 (input integer bit_depth);
  begin
    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
      bit_depth = bit_depth >> 1;
  end
endfunction

// WAIT_COUNT_BITS is the width of the wait counter.
localparam integer WAIT_COUNT_BITS = clogb2(C_M_START_COUNT-1);
reg [WAIT_COUNT_BITS-1 : 0]     count;

// bit_num gives the minimum number of bits needed to fit a counter for TLAST
localparam bit_num  = clogb2(NUMBER_OF_OUTPUT_WORDS);
reg [bit_num-1:0] read_counter;

//State machine
parameter [1:0] IDLE          = 2'b00, //idle state
                INIT_COUNTER  = 2'b01, //initial reset state
                SEND_STREAM   = 2'b10; //transfer state

reg [1:0] mst_exec_state;
wire    tx_en;
reg     tx_done;

//AXIS Signals
wire    axis_tvalid;
reg     axis_tvalid_delay; //delayed by one clock cycle
wire    axis_tlast;
reg     axis_tlast_delay; //delayed by one clock cycle
reg [C_M_AXIS_TDATA_WIDTH-1 : 0]    stream_data_out;


// Control state machine implementation
always @(posedge M_AXIS_ACLK)
begin
    if (!M_AXIS_ARESETN)
        begin
            mst_exec_state <= IDLE;
            count    <= 0;
        end
    else
        case (mst_exec_state)
            IDLE:
                    mst_exec_state  <= INIT_COUNTER;
            INIT_COUNTER:
                    //this state only applies during initial startup.
                    if ( count == C_M_START_COUNT - 1 )
                        mst_exec_state  <= SEND_STREAM;
                    else
                      begin
                        count <= count + 1;
                        mst_exec_state  <= INIT_COUNTER;
                      end
            SEND_STREAM:
                    if (tx_done)
                        mst_exec_state <= IDLE;
                    else
                        mst_exec_state <= SEND_STREAM;
        endcase
end


//State machine input generation

assign tx_en = M_AXIS_TREADY & axis_tvalid;

always@(posedge M_AXIS_ACLK)
begin
    if(!M_AXIS_ARESETN)
        begin
          read_counter <= 0;
          tx_done <= 1'b0;
        end
    else
        begin
            if (read_counter <= NUMBER_OF_OUTPUT_WORDS-1)
                begin
                    if (tx_en)
                      begin
                        read_counter <= read_counter + 1;
                        tx_done <= 1'b0;
                      end
                end
            else if (read_counter == NUMBER_OF_OUTPUT_WORDS)
                begin
                    // tx_done is asserted when NUMBER_OF_OUTPUT_WORDS numbers of streaming data
                    // has been out.
                    tx_done <= 1'b1;
                    read_counter <= 0;
                end
        end
end



// Streaming output data is sent
always @( posedge M_AXIS_ACLK )
begin
    if(!M_AXIS_ARESETN)
        stream_data_out <= 0;
    else if (tx_en)
            stream_data_out <= tdata_i;
end




assign tready_o = ((mst_exec_state == SEND_STREAM) && (read_counter < NUMBER_OF_OUTPUT_WORDS));
assign axis_tvalid = tvalid_i & tready_o;
assign axis_tlast = (read_counter == NUMBER_OF_OUTPUT_WORDS-1);


// Delay the axis_tvalid and axis_tlast signal by one clock cycle
// to match the latency of M_AXIS_TDATA
always @(posedge M_AXIS_ACLK)
begin
    if (!M_AXIS_ARESETN)
        begin
            axis_tvalid_delay <= 1'b0;
            axis_tlast_delay <= 1'b0;
        end
    else
        begin
            axis_tvalid_delay <= axis_tvalid;
            axis_tlast_delay <= axis_tlast;
        end
end

assign M_AXIS_TVALID    = axis_tvalid_delay;
assign M_AXIS_TDATA     = stream_data_out;
assign M_AXIS_TLAST     = axis_tlast_delay;
assign M_AXIS_TSTRB     = {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};

// User logic ends

endmodule
`default_nettype wire
