// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2014.4
// Copyright (C) 2014 Xilinx Inc. All rights reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module sandbox_Block_proc (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        result,
        video_out_TDATA,
        video_out_TVALID,
        video_out_TREADY,
        video_out_TKEEP,
        video_out_TSTRB,
        video_out_TUSER,
        video_out_TLAST,
        video_out_TID,
        video_out_TDEST
);

parameter    ap_const_logic_1 = 1'b1;
parameter    ap_const_logic_0 = 1'b0;
parameter    ap_ST_st1_fsm_0 = 4'b1;
parameter    ap_ST_st2_fsm_1 = 4'b10;
parameter    ap_ST_pp0_stg0_fsm_2 = 4'b100;
parameter    ap_ST_st5_fsm_3 = 4'b1000;
parameter    ap_const_lv32_0 = 32'b00000000000000000000000000000000;
parameter    ap_const_lv1_1 = 1'b1;
parameter    ap_const_lv32_1 = 32'b1;
parameter    ap_const_lv32_2 = 32'b10;
parameter    ap_const_lv1_0 = 1'b0;
parameter    ap_const_lv32_3 = 32'b11;
parameter    ap_const_lv10_0 = 10'b0000000000;
parameter    ap_const_lv9_0 = 9'b000000000;
parameter    ap_const_lv2_3 = 2'b11;
parameter    ap_const_lv2_0 = 2'b00;
parameter    ap_const_lv10_280 = 10'b1010000000;
parameter    ap_const_lv10_1 = 10'b1;
parameter    ap_const_lv9_1E0 = 9'b111100000;
parameter    ap_const_lv9_1 = 9'b1;
parameter    ap_const_lv9_1DF = 9'b111011111;
parameter    ap_const_lv8_0 = 8'b00000000;
parameter    ap_true = 1'b1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] result;
output  [15:0] video_out_TDATA;
output   video_out_TVALID;
input   video_out_TREADY;
output  [1:0] video_out_TKEEP;
output  [1:0] video_out_TSTRB;
output  [0:0] video_out_TUSER;
output  [0:0] video_out_TLAST;
output  [0:0] video_out_TID;
output  [0:0] video_out_TDEST;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg video_out_TVALID;
reg    ap_done_reg = 1'b0;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm = 4'b1;
reg    ap_sig_cseq_ST_st1_fsm_0;
reg    ap_sig_bdd_23;
reg   [8:0] p_3_i_reg_160;
wire   [0:0] exitcond3_i_fu_177_p2;
reg    ap_sig_cseq_ST_st2_fsm_1;
reg    ap_sig_bdd_49;
wire   [9:0] i_V_fu_183_p2;
reg   [9:0] i_V_reg_246;
wire   [0:0] exitcond4_i_fu_189_p2;
reg   [0:0] exitcond4_i_reg_251;
reg    ap_sig_cseq_ST_pp0_stg0_fsm_2;
reg    ap_sig_bdd_60;
reg    ap_reg_ppiten_pp0_it0 = 1'b0;
wire   [7:0] img_data_stream_0_V_assign_dout;
wire    img_data_stream_0_V_assign_empty_n;
wire   [7:0] img_data_stream_1_V_assign_dout;
wire    img_data_stream_1_V_assign_empty_n;
reg    ap_sig_bdd_79;
reg    ap_sig_ioackin_video_out_TREADY;
reg    ap_reg_ppiten_pp0_it1 = 1'b0;
wire   [8:0] j_V_fu_195_p2;
wire   [0:0] axi_last_V_fu_201_p2;
reg   [0:0] axi_last_V_reg_260;
reg   [9:0] p_i_reg_149;
reg    ap_sig_cseq_ST_st5_fsm_3;
reg    ap_sig_bdd_109;
reg    ap_sig_bdd_115;
reg   [0:0] tmp_user_V_fu_92;
reg    ap_reg_ioackin_video_out_TREADY = 1'b0;
reg   [3:0] ap_NS_fsm;




/// the current state (ap_CS_fsm) of the state machine. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_CS_fsm
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_st1_fsm_0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

/// ap_done_reg assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_done_reg
    if (ap_rst == 1'b1) begin
        ap_done_reg <= ap_const_logic_0;
    end else begin
        if ((ap_const_logic_1 == ap_continue)) begin
            ap_done_reg <= ap_const_logic_0;
        end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1) & ~(exitcond3_i_fu_177_p2 == ap_const_lv1_0))) begin
            ap_done_reg <= ap_const_logic_1;
        end
    end
end

/// ap_reg_ioackin_video_out_TREADY assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_reg_ioackin_video_out_TREADY
    if (ap_rst == 1'b1) begin
        ap_reg_ioackin_video_out_TREADY <= ap_const_logic_0;
    end else begin
        if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & (exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)))) begin
            ap_reg_ioackin_video_out_TREADY <= ap_const_logic_0;
        end else if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & (exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & ~(ap_sig_bdd_79 & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & (ap_const_logic_1 == video_out_TREADY))) begin
            ap_reg_ioackin_video_out_TREADY <= ap_const_logic_1;
        end
    end
end

/// ap_reg_ppiten_pp0_it0 assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_reg_ppiten_pp0_it0
    if (ap_rst == 1'b1) begin
        ap_reg_ppiten_pp0_it0 <= ap_const_logic_0;
    end else begin
        if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & ~(exitcond4_i_fu_189_p2 == ap_const_lv1_0))) begin
            ap_reg_ppiten_pp0_it0 <= ap_const_logic_0;
        end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1) & (exitcond3_i_fu_177_p2 == ap_const_lv1_0))) begin
            ap_reg_ppiten_pp0_it0 <= ap_const_logic_1;
        end
    end
end

/// ap_reg_ppiten_pp0_it1 assign process. ///
always @ (posedge ap_clk)
begin : ap_ret_ap_reg_ppiten_pp0_it1
    if (ap_rst == 1'b1) begin
        ap_reg_ppiten_pp0_it1 <= ap_const_logic_0;
    end else begin
        if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & (exitcond4_i_fu_189_p2 == ap_const_lv1_0))) begin
            ap_reg_ppiten_pp0_it1 <= ap_const_logic_1;
        end else if ((((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1) & (exitcond3_i_fu_177_p2 == ap_const_lv1_0)) | ((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & ~(exitcond4_i_fu_189_p2 == ap_const_lv1_0)))) begin
            ap_reg_ppiten_pp0_it1 <= ap_const_logic_0;
        end
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & (exitcond4_i_fu_189_p2 == ap_const_lv1_0))) begin
        p_3_i_reg_160 <= j_V_fu_195_p2;
    end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1) & (exitcond3_i_fu_177_p2 == ap_const_lv1_0))) begin
        p_3_i_reg_160 <= ap_const_lv9_0;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~ap_sig_bdd_115)) begin
        p_i_reg_149 <= ap_const_lv10_0;
    end else if ((ap_const_logic_1 == ap_sig_cseq_ST_st5_fsm_3)) begin
        p_i_reg_149 <= i_V_reg_246;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & (exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)))) begin
        tmp_user_V_fu_92 <= ap_const_lv1_0;
    end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~ap_sig_bdd_115)) begin
        tmp_user_V_fu_92 <= ap_const_lv1_1;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & (exitcond4_i_fu_189_p2 == ap_const_lv1_0))) begin
        axi_last_V_reg_260 <= axi_last_V_fu_201_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)))) begin
        exitcond4_i_reg_251 <= exitcond4_i_fu_189_p2;
    end
end

/// assign process. ///
always @(posedge ap_clk)
begin
    if ((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1)) begin
        i_V_reg_246 <= i_V_fu_183_p2;
    end
end

/// ap_done assign process. ///
always @ (ap_done_reg or exitcond3_i_fu_177_p2 or ap_sig_cseq_ST_st2_fsm_1)
begin
    if (((ap_const_logic_1 == ap_done_reg) | ((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1) & ~(exitcond3_i_fu_177_p2 == ap_const_lv1_0)))) begin
        ap_done = ap_const_logic_1;
    end else begin
        ap_done = ap_const_logic_0;
    end
end

/// ap_idle assign process. ///
always @ (ap_start or ap_sig_cseq_ST_st1_fsm_0)
begin
    if ((~(ap_const_logic_1 == ap_start) & (ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0))) begin
        ap_idle = ap_const_logic_1;
    end else begin
        ap_idle = ap_const_logic_0;
    end
end

/// ap_ready assign process. ///
always @ (exitcond3_i_fu_177_p2 or ap_sig_cseq_ST_st2_fsm_1)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_st2_fsm_1) & ~(exitcond3_i_fu_177_p2 == ap_const_lv1_0))) begin
        ap_ready = ap_const_logic_1;
    end else begin
        ap_ready = ap_const_logic_0;
    end
end

/// ap_sig_cseq_ST_pp0_stg0_fsm_2 assign process. ///
always @ (ap_sig_bdd_60)
begin
    if (ap_sig_bdd_60) begin
        ap_sig_cseq_ST_pp0_stg0_fsm_2 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_pp0_stg0_fsm_2 = ap_const_logic_0;
    end
end

/// ap_sig_cseq_ST_st1_fsm_0 assign process. ///
always @ (ap_sig_bdd_23)
begin
    if (ap_sig_bdd_23) begin
        ap_sig_cseq_ST_st1_fsm_0 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_st1_fsm_0 = ap_const_logic_0;
    end
end

/// ap_sig_cseq_ST_st2_fsm_1 assign process. ///
always @ (ap_sig_bdd_49)
begin
    if (ap_sig_bdd_49) begin
        ap_sig_cseq_ST_st2_fsm_1 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_st2_fsm_1 = ap_const_logic_0;
    end
end

/// ap_sig_cseq_ST_st5_fsm_3 assign process. ///
always @ (ap_sig_bdd_109)
begin
    if (ap_sig_bdd_109) begin
        ap_sig_cseq_ST_st5_fsm_3 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_st5_fsm_3 = ap_const_logic_0;
    end
end

/// ap_sig_ioackin_video_out_TREADY assign process. ///
always @ (video_out_TREADY or ap_reg_ioackin_video_out_TREADY)
begin
    if ((ap_const_logic_0 == ap_reg_ioackin_video_out_TREADY)) begin
        ap_sig_ioackin_video_out_TREADY = video_out_TREADY;
    end else begin
        ap_sig_ioackin_video_out_TREADY = ap_const_logic_1;
    end
end

/// video_out_TVALID assign process. ///
always @ (exitcond4_i_reg_251 or ap_sig_cseq_ST_pp0_stg0_fsm_2 or ap_sig_bdd_79 or ap_reg_ppiten_pp0_it1 or ap_reg_ioackin_video_out_TREADY)
begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_2) & (exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & ~(ap_sig_bdd_79 & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & (ap_const_logic_0 == ap_reg_ioackin_video_out_TREADY))) begin
        video_out_TVALID = ap_const_logic_1;
    end else begin
        video_out_TVALID = ap_const_logic_0;
    end
end
/// the next state (ap_NS_fsm) of the state machine. ///
always @ (ap_CS_fsm or exitcond3_i_fu_177_p2 or exitcond4_i_fu_189_p2 or exitcond4_i_reg_251 or ap_reg_ppiten_pp0_it0 or ap_sig_bdd_79 or ap_sig_ioackin_video_out_TREADY or ap_reg_ppiten_pp0_it1 or ap_sig_bdd_115)
begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 : 
        begin
            if (~ap_sig_bdd_115) begin
                ap_NS_fsm = ap_ST_st2_fsm_1;
            end else begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end
        end
        ap_ST_st2_fsm_1 : 
        begin
            if (~(exitcond3_i_fu_177_p2 == ap_const_lv1_0)) begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end else begin
                ap_NS_fsm = ap_ST_pp0_stg0_fsm_2;
            end
        end
        ap_ST_pp0_stg0_fsm_2 : 
        begin
            if (~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & ~(exitcond4_i_fu_189_p2 == ap_const_lv1_0))) begin
                ap_NS_fsm = ap_ST_pp0_stg0_fsm_2;
            end else if (((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ~((ap_sig_bdd_79 | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (ap_const_logic_0 == ap_sig_ioackin_video_out_TREADY))) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)) & ~(exitcond4_i_fu_189_p2 == ap_const_lv1_0))) begin
                ap_NS_fsm = ap_ST_st5_fsm_3;
            end else begin
                ap_NS_fsm = ap_ST_pp0_stg0_fsm_2;
            end
        end
        ap_ST_st5_fsm_3 : 
        begin
            ap_NS_fsm = ap_ST_st2_fsm_1;
        end
        default : 
        begin
            ap_NS_fsm = 'bx;
        end
    endcase
end


/// ap_sig_bdd_109 assign process. ///
always @ (ap_CS_fsm)
begin
    ap_sig_bdd_109 = (ap_const_lv1_1 == ap_CS_fsm[ap_const_lv32_3]);
end

/// ap_sig_bdd_115 assign process. ///
always @ (ap_start or ap_done_reg)
begin
    ap_sig_bdd_115 = ((ap_start == ap_const_logic_0) | (ap_done_reg == ap_const_logic_1));
end

/// ap_sig_bdd_23 assign process. ///
always @ (ap_CS_fsm)
begin
    ap_sig_bdd_23 = (ap_CS_fsm[ap_const_lv32_0] == ap_const_lv1_1);
end

/// ap_sig_bdd_49 assign process. ///
always @ (ap_CS_fsm)
begin
    ap_sig_bdd_49 = (ap_const_lv1_1 == ap_CS_fsm[ap_const_lv32_1]);
end

/// ap_sig_bdd_60 assign process. ///
always @ (ap_CS_fsm)
begin
    ap_sig_bdd_60 = (ap_const_lv1_1 == ap_CS_fsm[ap_const_lv32_2]);
end

/// ap_sig_bdd_79 assign process. ///
always @ (exitcond4_i_reg_251 or img_data_stream_0_V_assign_empty_n or img_data_stream_1_V_assign_empty_n)
begin
    ap_sig_bdd_79 = (((img_data_stream_0_V_assign_empty_n == ap_const_logic_0) & (exitcond4_i_reg_251 == ap_const_lv1_0)) | ((exitcond4_i_reg_251 == ap_const_lv1_0) & (img_data_stream_1_V_assign_empty_n == ap_const_logic_0)));
end
assign axi_last_V_fu_201_p2 = (p_3_i_reg_160 == ap_const_lv9_1DF? 1'b1: 1'b0);
assign exitcond3_i_fu_177_p2 = (p_i_reg_149 == ap_const_lv10_280? 1'b1: 1'b0);
assign exitcond4_i_fu_189_p2 = (p_3_i_reg_160 == ap_const_lv9_1E0? 1'b1: 1'b0);
assign i_V_fu_183_p2 = (p_i_reg_149 + ap_const_lv10_1);
assign img_data_stream_0_V_assign_dout = ap_const_lv8_0;
assign img_data_stream_0_V_assign_empty_n = ap_const_logic_1;
assign img_data_stream_1_V_assign_dout = ap_const_lv8_0;
assign img_data_stream_1_V_assign_empty_n = ap_const_logic_1;
assign j_V_fu_195_p2 = (p_3_i_reg_160 + ap_const_lv9_1);
assign video_out_TDATA = {{img_data_stream_1_V_assign_dout}, {img_data_stream_0_V_assign_dout}};
assign video_out_TDEST = ap_const_lv1_0;
assign video_out_TID = ap_const_lv1_0;
assign video_out_TKEEP = ap_const_lv2_3;
assign video_out_TLAST = axi_last_V_reg_260;
assign video_out_TSTRB = ap_const_lv2_0;
assign video_out_TUSER = tmp_user_V_fu_92;


endmodule //sandbox_Block_proc

