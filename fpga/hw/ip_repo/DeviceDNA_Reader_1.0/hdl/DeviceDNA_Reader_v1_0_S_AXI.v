
`timescale 1 ns / 1 ps

module DeviceDNA_Reader_v1_0_S_AXI #
(
    // Users to add parameters here
    //Number of user registers = 2^(MEM_ADDR_BITS+1)
    parameter integer MEM_ADDR_BITS = 1,

    // User parameters ends
    // Do not modify the parameters beyond this line
    parameter integer C_S_AXI_DATA_WIDTH    = 32,
    parameter integer C_S_AXI_ADDR_WIDTH    = 4
)
(
    // Users to add ports here

    //Register read interface
    output wire [MEM_ADDR_BITS:0] read_address,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] read_data,
    output wire read_req,
    input  wire read_strobe,

    //Register write interface
    output wire [MEM_ADDR_BITS:0] write_address,
    output wire [C_S_AXI_DATA_WIDTH-1:0] write_data,
    input  wire write_ack,
    output wire write_strobe,

    // User ports ends

    // Do not modify the ports beyond this line
    // Global Ports
    input  wire  S_AXI_ACLK,
    input  wire  S_AXI_ARESETN,

    //S_AXI Ports
    input  wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
    input  wire [2 : 0] S_AXI_AWPROT,
    input  wire  S_AXI_AWVALID,
    output wire  S_AXI_AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
    input  wire  S_AXI_WVALID,
    output wire  S_AXI_WREADY,
    output wire [1 : 0] S_AXI_BRESP,
    output wire  S_AXI_BVALID,
    input  wire  S_AXI_BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
    input  wire [2 : 0] S_AXI_ARPROT,
    input  wire  S_AXI_ARVALID,
    output wire  S_AXI_ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
    output wire [1 : 0] S_AXI_RRESP,
    output wire  S_AXI_RVALID,
    input  wire  S_AXI_RREADY
);

// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
// ADDR_LSB is used for addressing 32/64 bit registers/memories
// ADDR_LSB = 2 for 32 bits (n downto 2)
// ADDR_LSB = 3 for 64 bits (n downto 3)
localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;


//State machine
localparam [1:0] IDLE       = 2'b00, //idle state
                 ACTIVE     = 2'b01, //transfer state
                 ACK        = 2'b10; //completion state

reg [1:0] read_state, read_state_next;
reg [1:0] write_state, write_state_next;
reg [C_S_AXI_ADDR_WIDTH-1:0] rd_addr;

//Read state machine
always @(posedge S_AXI_ACLK)
begin
    if (!S_AXI_ARESETN)
        read_state <= IDLE;
    else
        read_state <= read_state_next;
end

always @ (read_state or S_AXI_ARVALID or read_strobe or S_AXI_RREADY)
begin
    case (read_state)
        IDLE:   begin
                    if(S_AXI_ARVALID)
                        read_state_next = ACTIVE;
                    else
                        read_state_next = IDLE;
                end
        ACTIVE: begin
                    if(read_strobe && S_AXI_RREADY)
                        read_state_next = IDLE;
                    else
                        read_state_next = ACTIVE;
                end
        default:    read_state_next = IDLE;
    endcase
end

always @(posedge S_AXI_ACLK)
begin
    if(!S_AXI_ARESETN)
        rd_addr <= 0;
    else
        begin
            case(read_state_next)
                IDLE:   rd_addr <= 0;
                ACTIVE: rd_addr <= S_AXI_ARADDR;
                default:rd_addr <= 0;
            endcase
        end
end

//Read state outputs
assign S_AXI_ARREADY = (read_state == IDLE) ? 1'b1 : 1'b0;
assign S_AXI_RVALID  = ((read_state == ACTIVE) && read_strobe) ? 1'b1 : 1'b0;
assign S_AXI_RRESP   = 2'b00;
assign S_AXI_RDATA   = read_data;
assign read_req      = ((read_state == ACTIVE) && S_AXI_RREADY) ? 1'b1 : 1'b0;
assign read_address  = rd_addr[ADDR_LSB+MEM_ADDR_BITS:ADDR_LSB];



//Write state machine
always @(posedge S_AXI_ACLK)
begin
    if (!S_AXI_ARESETN)
        write_state <= IDLE;
    else
        write_state <= write_state_next;
end

always @ (write_state or S_AXI_AWVALID or write_ack or S_AXI_WVALID or S_AXI_BREADY)
begin
    case (write_state)
        IDLE:   begin
                    if(S_AXI_AWVALID && S_AXI_WVALID && write_ack)
                        write_state_next = ACK;
                    else
                        write_state_next = IDLE;
                end
        ACTIVE: begin
                    if(S_AXI_BREADY)
                        write_state_next = IDLE;
                    else
                        write_state_next = ACTIVE;
                end
        ACK:        write_state_next = ACTIVE;
        default:    write_state_next = IDLE;
    endcase
end

//Write state outputs
assign S_AXI_AWREADY = (write_state == ACK) ? 1'b1 : 1'b0;
assign S_AXI_WREADY  = (write_state == ACK) ? 1'b1 : 1'b0;
assign S_AXI_BVALID  = (write_state == ACTIVE) ? 1'b1 : 1'b0;
assign S_AXI_BRESP   = 2'b00;
assign write_strobe  = ((write_state == IDLE) && S_AXI_AWVALID && S_AXI_WVALID) ? 1'b1 : 1'b0;
assign write_data    = S_AXI_WDATA;
assign write_address = S_AXI_AWADDR[ADDR_LSB+MEM_ADDR_BITS:ADDR_LSB];

endmodule
`default_nettype wire
