`timescale 1ns / 1ps
`default_nettype none
////////////////////////////////////////////////////////////////////////////////
// Company: GTRI
// Engineer: Mike Ruiz
//
// Create Date: 06/08/2015
// Design Name:
// Module Name: axi4_stream_user_processing_core_v1_0
// Project Name:
// Target Devices:
// Tool Versions:
// Description: This module exists to provide a simple glue interface between
//              the Xilinx AXI-STREAM interface (from something like a STREAM
//              FIFO + DMA combo) and a more traditional programmable logic
//              interface. This module is only meant to be a base design
//              and users are expected to implement core logic functionality
//              on data to/from the FIFO interfaces.
//
// Dependencies: fifo_short, fifo_long, axi_fifo_short
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module axi4_stream_user_processing_core_v1_0 #
(
    // Users to add parameters here

    //This value will be used for TLAST handling
    parameter integer PACKET_LENGTH=512,

    // User parameters ends
    // Do not modify the parameters beyond this line


    // Parameters of Axi Slave Bus Interface S_AXI
    parameter integer C_S_AXI_DATA_WIDTH    = 32,
    parameter integer C_S_AXI_ADDR_WIDTH    = 7,

    // Parameters of Axi Slave Bus Interface S_AXIS
    parameter integer C_S_AXIS_TDATA_WIDTH  = 32,

    // Parameters of Axi Master Bus Interface M_AXIS
    parameter integer C_M_AXIS_TDATA_WIDTH  = 32,
    parameter integer C_M_AXIS_START_COUNT  = 32
)
(
    // Users to add ports here

    //added because Vivado forgot, and it's required for some
    //Xilinx IP
    output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tkeep,
    // User ports ends
    // Do not modify the ports beyond this line


    // Ports of Axi Slave Bus Interface S_AXI
    input wire  s_axi_aclk,
    input wire  s_axi_aresetn,
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_awaddr,
    input wire [2 : 0] s_axi_awprot,
    input wire  s_axi_awvalid,
    output wire  s_axi_awready,
    input wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_wdata,
    input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
    input wire  s_axi_wvalid,
    output wire  s_axi_wready,
    output wire [1 : 0] s_axi_bresp,
    output wire  s_axi_bvalid,
    input wire  s_axi_bready,
    input wire [C_S_AXI_ADDR_WIDTH-1 : 0] s_axi_araddr,
    input wire [2 : 0] s_axi_arprot,
    input wire  s_axi_arvalid,
    output wire  s_axi_arready,
    output wire [C_S_AXI_DATA_WIDTH-1 : 0] s_axi_rdata,
    output wire [1 : 0] s_axi_rresp,
    output wire  s_axi_rvalid,
    input wire  s_axi_rready,

    // Ports of Axi Slave Bus Interface S_AXIS
    input wire  s_axis_aclk,
    input wire  s_axis_aresetn,
    output wire  s_axis_tready,
    input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] s_axis_tdata,
    input wire  s_axis_tlast,
    input wire  s_axis_tvalid,

    // Ports of Axi Master Bus Interface M_AXIS
    input wire  m_axis_aclk,
    input wire  m_axis_aresetn,
    output wire  m_axis_tvalid,
    output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
    output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
    output wire  m_axis_tlast,
    input wire  m_axis_tready
);

//extra AXIS signals
wire  m_axis_iface_tvalid;
wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_iface_tdata;
wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_iface_tstrb;
wire  m_axis_iface_tlast;
wire s_axis_iface_tready;
wire reset;



// Instantiation of Axi Bus Interface S_AXI
axi4_stream_user_processing_core_v1_0_S_AXI # (
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
) axi4_stream_user_processing_core_v1_0_S_AXI_inst (
    .S_AXI_ACLK(s_axi_aclk),
    .S_AXI_ARESETN(s_axi_aresetn),
    .S_AXI_AWADDR(s_axi_awaddr),
    .S_AXI_AWPROT(s_axi_awprot),
    .S_AXI_AWVALID(s_axi_awvalid),
    .S_AXI_AWREADY(s_axi_awready),
    .S_AXI_WDATA(s_axi_wdata),
    .S_AXI_WSTRB(s_axi_wstrb),
    .S_AXI_WVALID(s_axi_wvalid),
    .S_AXI_WREADY(s_axi_wready),
    .S_AXI_BRESP(s_axi_bresp),
    .S_AXI_BVALID(s_axi_bvalid),
    .S_AXI_BREADY(s_axi_bready),
    .S_AXI_ARADDR(s_axi_araddr),
    .S_AXI_ARPROT(s_axi_arprot),
    .S_AXI_ARVALID(s_axi_arvalid),
    .S_AXI_ARREADY(s_axi_arready),
    .S_AXI_RDATA(s_axi_rdata),
    .S_AXI_RRESP(s_axi_rresp),
    .S_AXI_RVALID(s_axi_rvalid),
    .S_AXI_RREADY(s_axi_rready)
);

//Interface between AXIS domain and core logic FIFOs
wire [C_S_AXIS_TDATA_WIDTH-1:0] axis_data_in;
wire [C_S_AXIS_TDATA_WIDTH-1:0] axis_data_out;
wire [C_S_AXIS_TDATA_WIDTH-1:0] s_axis_fifo_tdata_i;
wire [C_M_AXIS_TDATA_WIDTH-1:0] m_axis_fifo_tdata_o;
wire s_axis_tvalid_o;
wire s_axis_tready_o;
wire m_axis_tvalid_i;
wire m_axis_tready_o;
wire src_rdy_1;
wire src_rdy_2;
wire dst_rdy_1;
wire dst_rdy_2;

// Instantiation of Axi Bus Interface S_AXIS
axi4_stream_user_processing_core_v1_0_S_AXIS # (
    .NUMBER_OF_INPUT_WORDS(PACKET_LENGTH),
    .C_S_AXIS_TDATA_WIDTH(C_S_AXIS_TDATA_WIDTH)
) axi4_stream_user_processing_core_v1_0_S_AXIS_inst (
    .tdata_o(s_axis_fifo_tdata_i),
    .tvalid_o(s_axis_tvalid_o),
    .tready_i(s_axis_tready_o),
    .S_AXIS_ACLK(s_axis_aclk),
    .S_AXIS_ARESETN(s_axis_aresetn),
    .S_AXIS_TREADY(s_axis_iface_tready),
    .S_AXIS_TDATA(s_axis_tdata),
    .S_AXIS_TLAST(s_axis_tlast),
    .S_AXIS_TVALID(s_axis_tvalid)
);

// Instantiation of Axi Bus Interface M_AXIS
axi4_stream_user_processing_core_v1_0_M_AXIS # (
    .NUMBER_OF_OUTPUT_WORDS(PACKET_LENGTH),
    .C_M_AXIS_TDATA_WIDTH(C_M_AXIS_TDATA_WIDTH),
    .C_M_START_COUNT(C_M_AXIS_START_COUNT)
) axi4_stream_user_processing_core_v1_0_M_AXIS_inst (
    .tdata_i(m_axis_fifo_tdata_o),
    .tvalid_i(m_axis_tvalid_i),
    .tready_o(m_axis_tready_o),
    .M_AXIS_ACLK(m_axis_aclk),
    .M_AXIS_ARESETN(m_axis_aresetn),
    .M_AXIS_TVALID(m_axis_iface_tvalid),
    .M_AXIS_TDATA(m_axis_iface_tdata),
    .M_AXIS_TSTRB(m_axis_iface_tstrb),
    .M_AXIS_TLAST(m_axis_iface_tlast),
    .M_AXIS_TREADY(m_axis_tready)
);

//Basic FIFOs to handle receiving data from the external AXIS master, and/or
//sending to the external AXIS slave. To customize you code from here, you can
//break this into two paths.
//1. Transmit (CPU_TO_DEV) - fifo_cascade_axi_to_classic
//     dataout   = data being sent into the logic for processing
//     src_rdy_o = dataout is valid
//     dst_rdy_i = logic is ready to receive this data.
//     To access the data:
//        1) Set "dst_rdy_i" high
//        2) use a always @ (posedge clk) block to clock in data when valid
//           always @ (posege clk) begin
//              if (src_rdy_o) my_dat <= dataout;
//           end
//
//2. Receive (DEV_TO_CPU) - fifo_cascade_classic_to_axi
//     datain = data from your sensor/logic you want sent to the CPU
//     src_rdy_i = signal that your source data is now valid
//     dst_rdy_o = AXI fifo interface stage ready to receive your data
//     To send the data:
//        1) Set "src_rdy_i" high
//        2) connect your data to the fifo's "datain" port. It will be clocked
//           on the rising edge.
//        3) If your data source itself is coming from a previous FIFO stage,
//           use the dst_rdy_o signal to control when you read your data


//FIFO to interface to the Slave AXIS logic
fifo_cascade_axi_to_classic fifo_cascade_axi_to_classic_0 (
    .clk(s_axis_aclk),
    .reset(reset),
    .clear(1'b0),
    .tdata_i(s_axis_fifo_tdata_i),  //axi data in
    .tvalid_i(s_axis_tvalid_o),     //external source has data available
    .tready_i(s_axis_tready_o),     //internal FIFO has room available
    .dataout(axis_data_in),        //core logic data out
    .src_rdy_o(src_rdy_1),          //internal FIFO has data available
    .dst_rdy_i(dst_rdy_1),          //external destination has room available
    .space(),
    .occupied()
);


//Example core for handling incoming/outgoing data stream. This core simply
//transforms incoming data in some manner and returns it to the CPU.
//This could be turned into a transmit/receive path by splitting this into
//two separate modules with the transmit module working with
//{axis_data_in, src_rdy_1, dst_rdy_1} and the receive module working with
//{axis_data_out, src_rdy_2, dst_rdy_2}
custom_processing_core custom_processing_core_0 (
    .clk(m_axis_aclk),
    .reset(reset),
    .datain(axis_data_in),
    .input_enable(src_rdy_1),
    .core_ready(dst_rdy_1),
    .dataout(axis_data_out),
    .dataout_valid(src_rdy_2),
    .output_enable(dst_rdy_2)
);


//FIFO to interface to the Master AXIS Logic
fifo_cascade_classic_to_axi fifo_cascade_classic_to_axi_0 (
    .clk(m_axis_aclk),
    .reset(reset),
    .clear(1'b0),
    .datain(axis_data_out),        //core logic input data
    .src_rdy_i(src_rdy_2),          //external source has valid data available
    .dst_rdy_o(dst_rdy_2),          //Internal FIFO has space available
    .tdata_o(m_axis_fifo_tdata_o),  //axi interface data out
    .tvalid_o(m_axis_tvalid_i),     //Internal FIFO has valid data available
    .tready_o(m_axis_tready_o),     //External dest has space available
    .space(),
    .occupied()
);

//Make reset positive-edge
assign reset = ~m_axis_aresetn;

//This is just for temporary testing. Allows for bypassing core logic
wire core_logic_bypass;
assign core_logic_bypass = 1'b0;
assign m_axis_tdata  = core_logic_bypass ? s_axis_tdata  : m_axis_iface_tdata;
assign m_axis_tvalid = core_logic_bypass ? s_axis_tvalid : m_axis_iface_tvalid;
assign m_axis_tlast  = core_logic_bypass ? s_axis_tlast  : m_axis_iface_tlast;
assign s_axis_tready = core_logic_bypass ? m_axis_tready : s_axis_iface_tready;

//This is to make other Xilinx block happy.
assign m_axis_tkeep = 4'b1111;
assign m_axis_tstrb  = m_axis_iface_tstrb;

// User logic ends

endmodule
`default_nettype wire
