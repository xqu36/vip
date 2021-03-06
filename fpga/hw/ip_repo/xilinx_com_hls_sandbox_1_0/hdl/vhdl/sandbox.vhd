-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2014.4
-- Copyright (C) 2014 Xilinx Inc. All rights reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sandbox is
generic (
    C_S_AXI_CONTROL_BUS_ADDR_WIDTH : INTEGER := 6;
    C_S_AXI_CONTROL_BUS_DATA_WIDTH : INTEGER := 32 );
port (
    s_axi_CONTROL_BUS_AWVALID : IN STD_LOGIC;
    s_axi_CONTROL_BUS_AWREADY : OUT STD_LOGIC;
    s_axi_CONTROL_BUS_AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_BUS_ADDR_WIDTH-1 downto 0);
    s_axi_CONTROL_BUS_WVALID : IN STD_LOGIC;
    s_axi_CONTROL_BUS_WREADY : OUT STD_LOGIC;
    s_axi_CONTROL_BUS_WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_BUS_DATA_WIDTH-1 downto 0);
    s_axi_CONTROL_BUS_WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_BUS_DATA_WIDTH/8-1 downto 0);
    s_axi_CONTROL_BUS_ARVALID : IN STD_LOGIC;
    s_axi_CONTROL_BUS_ARREADY : OUT STD_LOGIC;
    s_axi_CONTROL_BUS_ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_BUS_ADDR_WIDTH-1 downto 0);
    s_axi_CONTROL_BUS_RVALID : OUT STD_LOGIC;
    s_axi_CONTROL_BUS_RREADY : IN STD_LOGIC;
    s_axi_CONTROL_BUS_RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_CONTROL_BUS_DATA_WIDTH-1 downto 0);
    s_axi_CONTROL_BUS_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    s_axi_CONTROL_BUS_BVALID : OUT STD_LOGIC;
    s_axi_CONTROL_BUS_BREADY : IN STD_LOGIC;
    s_axi_CONTROL_BUS_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    interrupt : OUT STD_LOGIC;
    video_in_TDATA : IN STD_LOGIC_VECTOR (15 downto 0);
    video_in_TKEEP : IN STD_LOGIC_VECTOR (1 downto 0);
    video_in_TSTRB : IN STD_LOGIC_VECTOR (1 downto 0);
    video_in_TUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    video_in_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    video_in_TID : IN STD_LOGIC_VECTOR (0 downto 0);
    video_in_TDEST : IN STD_LOGIC_VECTOR (0 downto 0);
    video_out_TDATA : OUT STD_LOGIC_VECTOR (15 downto 0);
    video_out_TKEEP : OUT STD_LOGIC_VECTOR (1 downto 0);
    video_out_TSTRB : OUT STD_LOGIC_VECTOR (1 downto 0);
    video_out_TUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    video_out_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
    video_out_TID : OUT STD_LOGIC_VECTOR (0 downto 0);
    video_out_TDEST : OUT STD_LOGIC_VECTOR (0 downto 0);
    video_in_TVALID : IN STD_LOGIC;
    video_in_TREADY : OUT STD_LOGIC;
    video_out_TVALID : OUT STD_LOGIC;
    video_out_TREADY : IN STD_LOGIC );
end;


architecture behav of sandbox is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "sandbox,hls_ip_2014_4,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020clg484-1,HLS_INPUT_CLOCK=6.666667,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=5.681000,HLS_SYN_LAT=309763,HLS_SYN_TPT=309764,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=433,HLS_SYN_LUT=674}";
    constant C_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant C_WSTRB_WIDTH : INTEGER range 63 downto 0 := 4;
    constant C_ADDR_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_true : BOOLEAN := true;
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal ap_rst_n_inv : STD_LOGIC;
    signal sandbox_CONTROL_BUS_s_axi_U_ap_dummy_ce : STD_LOGIC;
    signal rows : STD_LOGIC_VECTOR (31 downto 0);
    signal cols : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_start : STD_LOGIC;
    signal ap_ready : STD_LOGIC;
    signal ap_done : STD_LOGIC;
    signal ap_idle : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_start : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_done : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_continue : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_idle : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_ready : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_AXI_video_strm_V_data_V_2 : STD_LOGIC_VECTOR (31 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_AXI_video_strm_V_data_V_2_ap_vld : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TDATA : STD_LOGIC_VECTOR (15 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TVALID : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TREADY : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TKEEP : STD_LOGIC_VECTOR (1 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TSTRB : STD_LOGIC_VECTOR (1 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TLAST : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TID : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TDEST : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_din : STD_LOGIC_VECTOR (7 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_full_n : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_write : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_din : STD_LOGIC_VECTOR (7 downto 0);
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_full_n : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_write : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_ap_vld : STD_LOGIC;
    signal sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_ap_vld : STD_LOGIC;
    signal ap_chn_write_sandbox_AXIvideo2Mat_16_640_480_16_U0_result_channel : STD_LOGIC;
    signal result_channel_full_n : STD_LOGIC;
    signal sandbox_Block_proc_U0_ap_start : STD_LOGIC;
    signal sandbox_Block_proc_U0_ap_done : STD_LOGIC;
    signal sandbox_Block_proc_U0_ap_continue : STD_LOGIC;
    signal sandbox_Block_proc_U0_ap_idle : STD_LOGIC;
    signal sandbox_Block_proc_U0_ap_ready : STD_LOGIC;
    signal sandbox_Block_proc_U0_result : STD_LOGIC_VECTOR (31 downto 0);
    signal sandbox_Block_proc_U0_video_out_TDATA : STD_LOGIC_VECTOR (15 downto 0);
    signal sandbox_Block_proc_U0_video_out_TVALID : STD_LOGIC;
    signal sandbox_Block_proc_U0_video_out_TREADY : STD_LOGIC;
    signal sandbox_Block_proc_U0_video_out_TKEEP : STD_LOGIC_VECTOR (1 downto 0);
    signal sandbox_Block_proc_U0_video_out_TSTRB : STD_LOGIC_VECTOR (1 downto 0);
    signal sandbox_Block_proc_U0_video_out_TUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_Block_proc_U0_video_out_TLAST : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_Block_proc_U0_video_out_TID : STD_LOGIC_VECTOR (0 downto 0);
    signal sandbox_Block_proc_U0_video_out_TDEST : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_sig_hs_continue : STD_LOGIC;
    signal result_channel_U_ap_dummy_ce : STD_LOGIC;
    signal result_channel_din : STD_LOGIC_VECTOR (31 downto 0);
    signal result_channel_write : STD_LOGIC;
    signal result_channel_dout : STD_LOGIC_VECTOR (31 downto 0);
    signal result_channel_empty_n : STD_LOGIC;
    signal result_channel_read : STD_LOGIC;
    signal ap_reg_procdone_sandbox_AXIvideo2Mat_16_640_480_16_U0 : STD_LOGIC := '0';
    signal ap_sig_hs_done : STD_LOGIC;
    signal ap_reg_procdone_sandbox_Block_proc_U0 : STD_LOGIC := '0';
    signal ap_CS : STD_LOGIC;
    signal ap_sig_top_allready : STD_LOGIC;

    component sandbox_AXIvideo2Mat_16_640_480_16_s IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        AXI_video_strm_V_data_V_2 : OUT STD_LOGIC_VECTOR (31 downto 0);
        AXI_video_strm_V_data_V_2_ap_vld : OUT STD_LOGIC;
        video_in_TDATA : IN STD_LOGIC_VECTOR (15 downto 0);
        video_in_TVALID : IN STD_LOGIC;
        video_in_TREADY : OUT STD_LOGIC;
        video_in_TKEEP : IN STD_LOGIC_VECTOR (1 downto 0);
        video_in_TSTRB : IN STD_LOGIC_VECTOR (1 downto 0);
        video_in_TUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        video_in_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
        video_in_TID : IN STD_LOGIC_VECTOR (0 downto 0);
        video_in_TDEST : IN STD_LOGIC_VECTOR (0 downto 0);
        img_data_stream_0_V_din : OUT STD_LOGIC_VECTOR (7 downto 0);
        img_data_stream_0_V_full_n : IN STD_LOGIC;
        img_data_stream_0_V_write : OUT STD_LOGIC;
        img_data_stream_1_V_din : OUT STD_LOGIC_VECTOR (7 downto 0);
        img_data_stream_1_V_full_n : IN STD_LOGIC;
        img_data_stream_1_V_write : OUT STD_LOGIC;
        img_data_stream_0_V_ap_vld : OUT STD_LOGIC;
        img_data_stream_1_V_ap_vld : OUT STD_LOGIC );
    end component;


    component sandbox_Block_proc IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        result : IN STD_LOGIC_VECTOR (31 downto 0);
        video_out_TDATA : OUT STD_LOGIC_VECTOR (15 downto 0);
        video_out_TVALID : OUT STD_LOGIC;
        video_out_TREADY : IN STD_LOGIC;
        video_out_TKEEP : OUT STD_LOGIC_VECTOR (1 downto 0);
        video_out_TSTRB : OUT STD_LOGIC_VECTOR (1 downto 0);
        video_out_TUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        video_out_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
        video_out_TID : OUT STD_LOGIC_VECTOR (0 downto 0);
        video_out_TDEST : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;


    component FIFO_sandbox_result_channel IS
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        if_read_ce : IN STD_LOGIC;
        if_write_ce : IN STD_LOGIC;
        if_din : IN STD_LOGIC_VECTOR (31 downto 0);
        if_full_n : OUT STD_LOGIC;
        if_write : IN STD_LOGIC;
        if_dout : OUT STD_LOGIC_VECTOR (31 downto 0);
        if_empty_n : OUT STD_LOGIC;
        if_read : IN STD_LOGIC );
    end component;


    component sandbox_CONTROL_BUS_s_axi IS
    generic (
        C_ADDR_WIDTH : INTEGER;
        C_DATA_WIDTH : INTEGER );
    port (
        AWVALID : IN STD_LOGIC;
        AWREADY : OUT STD_LOGIC;
        AWADDR : IN STD_LOGIC_VECTOR (C_ADDR_WIDTH-1 downto 0);
        WVALID : IN STD_LOGIC;
        WREADY : OUT STD_LOGIC;
        WDATA : IN STD_LOGIC_VECTOR (C_DATA_WIDTH-1 downto 0);
        WSTRB : IN STD_LOGIC_VECTOR (C_DATA_WIDTH/8-1 downto 0);
        ARVALID : IN STD_LOGIC;
        ARREADY : OUT STD_LOGIC;
        ARADDR : IN STD_LOGIC_VECTOR (C_ADDR_WIDTH-1 downto 0);
        RVALID : OUT STD_LOGIC;
        RREADY : IN STD_LOGIC;
        RDATA : OUT STD_LOGIC_VECTOR (C_DATA_WIDTH-1 downto 0);
        RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        BVALID : OUT STD_LOGIC;
        BREADY : IN STD_LOGIC;
        BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        rows : OUT STD_LOGIC_VECTOR (31 downto 0);
        cols : OUT STD_LOGIC_VECTOR (31 downto 0);
        ap_start : OUT STD_LOGIC;
        interrupt : OUT STD_LOGIC;
        ap_ready : IN STD_LOGIC;
        ap_done : IN STD_LOGIC;
        ap_idle : IN STD_LOGIC );
    end component;



begin
    sandbox_CONTROL_BUS_s_axi_U : component sandbox_CONTROL_BUS_s_axi
    generic map (
        C_ADDR_WIDTH => C_S_AXI_CONTROL_BUS_ADDR_WIDTH,
        C_DATA_WIDTH => C_S_AXI_CONTROL_BUS_DATA_WIDTH)
    port map (
        AWVALID => s_axi_CONTROL_BUS_AWVALID,
        AWREADY => s_axi_CONTROL_BUS_AWREADY,
        AWADDR => s_axi_CONTROL_BUS_AWADDR,
        WVALID => s_axi_CONTROL_BUS_WVALID,
        WREADY => s_axi_CONTROL_BUS_WREADY,
        WDATA => s_axi_CONTROL_BUS_WDATA,
        WSTRB => s_axi_CONTROL_BUS_WSTRB,
        ARVALID => s_axi_CONTROL_BUS_ARVALID,
        ARREADY => s_axi_CONTROL_BUS_ARREADY,
        ARADDR => s_axi_CONTROL_BUS_ARADDR,
        RVALID => s_axi_CONTROL_BUS_RVALID,
        RREADY => s_axi_CONTROL_BUS_RREADY,
        RDATA => s_axi_CONTROL_BUS_RDATA,
        RRESP => s_axi_CONTROL_BUS_RRESP,
        BVALID => s_axi_CONTROL_BUS_BVALID,
        BREADY => s_axi_CONTROL_BUS_BREADY,
        BRESP => s_axi_CONTROL_BUS_BRESP,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => sandbox_CONTROL_BUS_s_axi_U_ap_dummy_ce,
        rows => rows,
        cols => cols,
        ap_start => ap_start,
        interrupt => interrupt,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_idle => ap_idle);

    sandbox_AXIvideo2Mat_16_640_480_16_U0 : component sandbox_AXIvideo2Mat_16_640_480_16_s
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_start,
        ap_done => sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_done,
        ap_continue => sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_continue,
        ap_idle => sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_idle,
        ap_ready => sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_ready,
        AXI_video_strm_V_data_V_2 => sandbox_AXIvideo2Mat_16_640_480_16_U0_AXI_video_strm_V_data_V_2,
        AXI_video_strm_V_data_V_2_ap_vld => sandbox_AXIvideo2Mat_16_640_480_16_U0_AXI_video_strm_V_data_V_2_ap_vld,
        video_in_TDATA => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TDATA,
        video_in_TVALID => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TVALID,
        video_in_TREADY => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TREADY,
        video_in_TKEEP => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TKEEP,
        video_in_TSTRB => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TSTRB,
        video_in_TUSER => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TUSER,
        video_in_TLAST => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TLAST,
        video_in_TID => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TID,
        video_in_TDEST => sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TDEST,
        img_data_stream_0_V_din => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_din,
        img_data_stream_0_V_full_n => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_full_n,
        img_data_stream_0_V_write => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_write,
        img_data_stream_1_V_din => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_din,
        img_data_stream_1_V_full_n => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_full_n,
        img_data_stream_1_V_write => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_write,
        img_data_stream_0_V_ap_vld => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_ap_vld,
        img_data_stream_1_V_ap_vld => sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_ap_vld);

    sandbox_Block_proc_U0 : component sandbox_Block_proc
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => sandbox_Block_proc_U0_ap_start,
        ap_done => sandbox_Block_proc_U0_ap_done,
        ap_continue => sandbox_Block_proc_U0_ap_continue,
        ap_idle => sandbox_Block_proc_U0_ap_idle,
        ap_ready => sandbox_Block_proc_U0_ap_ready,
        result => sandbox_Block_proc_U0_result,
        video_out_TDATA => sandbox_Block_proc_U0_video_out_TDATA,
        video_out_TVALID => sandbox_Block_proc_U0_video_out_TVALID,
        video_out_TREADY => sandbox_Block_proc_U0_video_out_TREADY,
        video_out_TKEEP => sandbox_Block_proc_U0_video_out_TKEEP,
        video_out_TSTRB => sandbox_Block_proc_U0_video_out_TSTRB,
        video_out_TUSER => sandbox_Block_proc_U0_video_out_TUSER,
        video_out_TLAST => sandbox_Block_proc_U0_video_out_TLAST,
        video_out_TID => sandbox_Block_proc_U0_video_out_TID,
        video_out_TDEST => sandbox_Block_proc_U0_video_out_TDEST);

    result_channel_U : component FIFO_sandbox_result_channel
    port map (
        clk => ap_clk,
        reset => ap_rst_n_inv,
        if_read_ce => result_channel_U_ap_dummy_ce,
        if_write_ce => result_channel_U_ap_dummy_ce,
        if_din => result_channel_din,
        if_full_n => result_channel_full_n,
        if_write => result_channel_write,
        if_dout => result_channel_dout,
        if_empty_n => result_channel_empty_n,
        if_read => result_channel_read);





    -- ap_reg_procdone_sandbox_AXIvideo2Mat_16_640_480_16_U0 assign process. --
    ap_reg_procdone_sandbox_AXIvideo2Mat_16_640_480_16_U0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_reg_procdone_sandbox_AXIvideo2Mat_16_640_480_16_U0 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_sig_hs_done)) then 
                    ap_reg_procdone_sandbox_AXIvideo2Mat_16_640_480_16_U0 <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_done)) then 
                    ap_reg_procdone_sandbox_AXIvideo2Mat_16_640_480_16_U0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    -- ap_reg_procdone_sandbox_Block_proc_U0 assign process. --
    ap_reg_procdone_sandbox_Block_proc_U0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_reg_procdone_sandbox_Block_proc_U0 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_sig_hs_done)) then 
                    ap_reg_procdone_sandbox_Block_proc_U0 <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = sandbox_Block_proc_U0_ap_done)) then 
                    ap_reg_procdone_sandbox_Block_proc_U0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    -- ap_CS assign process. --
    ap_CS_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            ap_CS <= ap_const_logic_0;
        end if;
    end process;
    ap_chn_write_sandbox_AXIvideo2Mat_16_640_480_16_U0_result_channel <= sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_done;
    ap_done <= ap_sig_hs_done;

    -- ap_idle assign process. --
    ap_idle_assign_proc : process(sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_idle, sandbox_Block_proc_U0_ap_idle, result_channel_empty_n)
    begin
        if (((ap_const_logic_1 = sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_idle) and (ap_const_logic_1 = sandbox_Block_proc_U0_ap_idle) and (result_channel_empty_n = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;

    ap_ready <= ap_sig_top_allready;

    -- ap_rst_n_inv assign process. --
    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    ap_sig_hs_continue <= ap_const_logic_1;

    -- ap_sig_hs_done assign process. --
    ap_sig_hs_done_assign_proc : process(sandbox_Block_proc_U0_ap_done)
    begin
        if ((ap_const_logic_1 = sandbox_Block_proc_U0_ap_done)) then 
            ap_sig_hs_done <= ap_const_logic_1;
        else 
            ap_sig_hs_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_sig_top_allready <= sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_ready;
    result_channel_U_ap_dummy_ce <= ap_const_logic_1;
    result_channel_din <= sandbox_AXIvideo2Mat_16_640_480_16_U0_AXI_video_strm_V_data_V_2;
    result_channel_read <= sandbox_Block_proc_U0_ap_ready;
    result_channel_write <= ap_chn_write_sandbox_AXIvideo2Mat_16_640_480_16_U0_result_channel;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_continue <= result_channel_full_n;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_ap_start <= ap_start;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_0_V_full_n <= ap_const_logic_1;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_img_data_stream_1_V_full_n <= ap_const_logic_1;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TDATA <= video_in_TDATA;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TDEST <= video_in_TDEST;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TID <= video_in_TID;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TKEEP <= video_in_TKEEP;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TLAST <= video_in_TLAST;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TSTRB <= video_in_TSTRB;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TUSER <= video_in_TUSER;
    sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TVALID <= video_in_TVALID;
    sandbox_Block_proc_U0_ap_continue <= ap_sig_hs_continue;
    sandbox_Block_proc_U0_ap_start <= result_channel_empty_n;
    sandbox_Block_proc_U0_result <= result_channel_dout;
    sandbox_Block_proc_U0_video_out_TREADY <= video_out_TREADY;
    sandbox_CONTROL_BUS_s_axi_U_ap_dummy_ce <= ap_const_logic_1;
    video_in_TREADY <= sandbox_AXIvideo2Mat_16_640_480_16_U0_video_in_TREADY;
    video_out_TDATA <= sandbox_Block_proc_U0_video_out_TDATA;
    video_out_TDEST <= sandbox_Block_proc_U0_video_out_TDEST;
    video_out_TID <= sandbox_Block_proc_U0_video_out_TID;
    video_out_TKEEP <= sandbox_Block_proc_U0_video_out_TKEEP;
    video_out_TLAST <= sandbox_Block_proc_U0_video_out_TLAST;
    video_out_TSTRB <= sandbox_Block_proc_U0_video_out_TSTRB;
    video_out_TUSER <= sandbox_Block_proc_U0_video_out_TUSER;
    video_out_TVALID <= sandbox_Block_proc_U0_video_out_TVALID;
end behav;
