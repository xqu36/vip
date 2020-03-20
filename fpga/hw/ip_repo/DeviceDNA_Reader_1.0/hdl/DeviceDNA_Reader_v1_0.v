
`timescale 1 ns / 1 ps

module DeviceDNA_Reader_v1_0 #
(
	// Users to add parameters here

    //Number of user registers = 2^(MEM_ADDR_BITS+1)
    parameter integer MEM_ADDR_BITS = 1,

	// User parameters ends
	// Do not modify the parameters beyond this line


	// Parameters of Axi Slave Bus Interface S_AXI
	parameter integer C_S_AXI_DATA_WIDTH	= 32,
	parameter integer C_S_AXI_ADDR_WIDTH	= 4
)
(
	// Users to add ports here

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
	input wire  s_axi_rready
);

wire rst;


//Device DNA Storage Registers and signals
reg [63:0] dev_dna;
wire dna_activate;
wire dna_read;
wire dna_bit_out;


// Instantiation of Axi Bus Interface S_AXI
wire [MEM_ADDR_BITS:0] read_address;
reg [C_S_AXI_DATA_WIDTH-1:0] read_data;
wire read_req;
reg  read_strobe;
wire [MEM_ADDR_BITS:0] write_address;
wire [C_S_AXI_DATA_WIDTH-1:0] write_data;
reg write_ack;
wire write_strobe;


//Register reads for Device DNA
always @(posedge s_axi_aclk)
begin
    if(rst)
        begin
            read_strobe <= 0;
            read_data <= 0;
        end
    else
        begin
            read_strobe <= 1'b0;

            if(read_req)
                begin
                    read_strobe <= 1'b1;

                    case (read_address)
                        4'h0: read_data <= dev_dna[31:0];
                        4'h1: read_data <= dev_dna[63:32];
                        4'h2: read_data <= 32'hAAAAAAAA;
                        4'h3: read_data <= 32'hDEADBEEF;
                        default: read_data <= 0;
                    endcase
                end
        end
end

//Simple state machine for device DNA
localparam [1:0] RESET      = 2'b00, //initial reset state
                 INITIATE   = 2'b01, //initiate dna_port load
                 READ       = 2'b10, //active dna_port read
                 IDLE       = 2'b11; //IDLE

reg [1:0] dna_state;
reg [1:0] dna_state_next;
reg [5:0] reset_counter;
reg [5:0] read_counter;
wire reset_complete;
wire read_complete;


//Synchronous state handler
always @(posedge s_axi_aclk)
begin
    if (rst)
        dna_state <= RESET;
    else
        dna_state <= dna_state_next;
end


//Next state logic
always @(dna_state, reset_complete, read_complete)
begin
    case (dna_state)
        RESET:  begin
                    if(reset_complete)
                        dna_state_next = INITIATE;
                    else
                        dna_state_next = RESET;
                    end
        INITIATE: begin
                        dna_state_next = READ;
                  end
        READ: begin
                    if(read_complete)
                        dna_state_next = IDLE;
                    else
                        dna_state_next = READ;
                end
        IDLE: begin
                        dna_state_next = IDLE;
                end
        default:dna_state_next = IDLE;
    endcase
end

assign dna_activate = (dna_state_next == INITIATE);
assign dna_read = (dna_state_next == READ);




//reset counter logic. Resets to '32'. Once it reaches '0', it stops
always @(posedge s_axi_aclk)
begin
    if(rst)
        reset_counter <= 6'h20; //reset to 32
    else
        begin
            if(!reset_complete)
                reset_counter <= reset_counter - 1;
        end
end

//This signal goes high when the register is 0
assign reset_complete = ~|reset_counter;



//read counter and dna logic
always @(posedge s_axi_aclk)
begin
    if(rst)
        read_counter <= 6'h39; //reset to 57
    else
        begin
            case(dna_state_next) //read is active in this state
                READ:  begin
                            //shift in next bit
                            dev_dna[63:1] <= dev_dna[62:0];
                            dev_dna[0] <= dna_bit_out;
                            read_counter <= read_counter - 1;
                       end
                default:begin
                            read_counter <= 6'h39; //reset to 57
                        end
            endcase
        end
end

//This signal goes high when the register is 0
assign read_complete = ~|read_counter;




//Instantiation of Device DNA primative
DNA_PORT #(
    .SIM_DNA_VALUE(0)
)
dna_port_inst (
    .DOUT(dna_bit_out),
    .CLK(s_axi_aclk),
    .DIN(1'b0),
    .READ(dna_activate),
    .SHIFT(dna_read)
);

// Instantiation of Axi Bus Interface S_AXI
DeviceDNA_Reader_v1_0_S_AXI # ( 
    .MEM_ADDR_BITS(MEM_ADDR_BITS),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
) DeviceDNA_Reader_v1_0_S_AXI_inst (
    .read_address(read_address),
    .read_data(read_data),
    .read_req(read_req),
    .read_strobe(read_strobe),
    .write_address(write_address),
    .write_data(write_data),
    .write_ack(write_ack),
    .write_strobe(write_strobe),
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

//negate reset logic
assign rst = ~s_axi_aresetn;

endmodule
