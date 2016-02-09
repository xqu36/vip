// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2014.4
// Copyright (C) 2014 Xilinx Inc. All rights reserved.
// 
// ===========================================================

#ifndef _sandbox_AXIvideo2Mat_HH_
#define _sandbox_AXIvideo2Mat_HH_

#include "systemc.h"
#include "AESL_pkg.h"


namespace ap_rtl {

struct sandbox_AXIvideo2Mat : public sc_module {
    // Port declarations 30
    sc_in_clk ap_clk;
    sc_in< sc_logic > ap_rst;
    sc_in< sc_logic > ap_start;
    sc_out< sc_logic > ap_done;
    sc_in< sc_logic > ap_continue;
    sc_out< sc_logic > ap_idle;
    sc_out< sc_logic > ap_ready;
    sc_out< sc_lv<32> > AXI_video_strm_V_data_V_2;
    sc_out< sc_logic > AXI_video_strm_V_data_V_2_ap_vld;
    sc_in< sc_lv<24> > video_in_TDATA;
    sc_in< sc_logic > video_in_TVALID;
    sc_out< sc_logic > video_in_TREADY;
    sc_in< sc_lv<3> > video_in_TKEEP;
    sc_in< sc_lv<3> > video_in_TSTRB;
    sc_in< sc_lv<1> > video_in_TUSER;
    sc_in< sc_lv<1> > video_in_TLAST;
    sc_in< sc_lv<1> > video_in_TID;
    sc_in< sc_lv<1> > video_in_TDEST;
    sc_out< sc_lv<8> > img_data_stream_0_V_din;
    sc_in< sc_logic > img_data_stream_0_V_full_n;
    sc_out< sc_logic > img_data_stream_0_V_write;
    sc_out< sc_lv<8> > img_data_stream_1_V_din;
    sc_in< sc_logic > img_data_stream_1_V_full_n;
    sc_out< sc_logic > img_data_stream_1_V_write;
    sc_out< sc_lv<8> > img_data_stream_2_V_din;
    sc_in< sc_logic > img_data_stream_2_V_full_n;
    sc_out< sc_logic > img_data_stream_2_V_write;
    sc_out< sc_logic > img_data_stream_0_V_ap_vld;
    sc_out< sc_logic > img_data_stream_1_V_ap_vld;
    sc_out< sc_logic > img_data_stream_2_V_ap_vld;


    // Module declarations
    sandbox_AXIvideo2Mat(sc_module_name name);
    SC_HAS_PROCESS(sandbox_AXIvideo2Mat);

    ~sandbox_AXIvideo2Mat();

    sc_trace_file* mVcdFile;

    sc_signal< sc_logic > ap_done_reg;
    sc_signal< sc_lv<7> > ap_CS_fsm;
    sc_signal< sc_logic > ap_sig_cseq_ST_st1_fsm_0;
    sc_signal< bool > ap_sig_bdd_26;
    sc_signal< sc_lv<1> > eol_1_reg_206;
    sc_signal< sc_lv<24> > axi_data_V_1_reg_217;
    sc_signal< sc_lv<11> > p_1_reg_228;
    sc_signal< sc_lv<32> > res_1_reg_239;
    sc_signal< sc_lv<1> > eol_reg_250;
    sc_signal< sc_lv<1> > axi_last_V_2_reg_262;
    sc_signal< sc_lv<24> > p_Val2_s_reg_274;
    sc_signal< sc_lv<1> > eol_2_reg_286;
    sc_signal< sc_lv<24> > tmp_data_V_reg_487;
    sc_signal< sc_logic > ap_sig_cseq_ST_st2_fsm_1;
    sc_signal< bool > ap_sig_bdd_79;
    sc_signal< sc_lv<1> > tmp_last_V_reg_495;
    sc_signal< sc_lv<1> > exitcond1_fu_364_p2;
    sc_signal< sc_logic > ap_sig_cseq_ST_st4_fsm_3;
    sc_signal< bool > ap_sig_bdd_93;
    sc_signal< sc_lv<11> > i_V_fu_370_p2;
    sc_signal< sc_lv<11> > i_V_reg_511;
    sc_signal< sc_lv<1> > exitcond2_fu_376_p2;
    sc_signal< sc_lv<1> > exitcond2_reg_516;
    sc_signal< sc_logic > ap_sig_cseq_ST_pp1_stg0_fsm_4;
    sc_signal< bool > ap_sig_bdd_104;
    sc_signal< sc_lv<1> > brmerge_fu_391_p2;
    sc_signal< bool > ap_sig_bdd_112;
    sc_signal< sc_logic > ap_reg_ppiten_pp1_it0;
    sc_signal< sc_logic > ap_reg_ppiten_pp1_it1;
    sc_signal< sc_lv<11> > j_V_fu_382_p2;
    sc_signal< sc_lv<32> > res_2_fu_444_p3;
    sc_signal< sc_lv<32> > res_2_reg_529;
    sc_signal< sc_lv<8> > tmp_6_fu_452_p1;
    sc_signal< sc_lv<8> > tmp_6_reg_534;
    sc_signal< sc_lv<8> > tmp_7_reg_539;
    sc_signal< sc_lv<8> > tmp_9_reg_544;
    sc_signal< sc_logic > ap_sig_cseq_ST_st7_fsm_5;
    sc_signal< bool > ap_sig_bdd_141;
    sc_signal< bool > ap_sig_bdd_146;
    sc_signal< sc_lv<32> > res_4_fu_481_p2;
    sc_signal< sc_lv<1> > axi_last_V_3_reg_297;
    sc_signal< sc_lv<1> > axi_last_V1_reg_162;
    sc_signal< sc_logic > ap_sig_cseq_ST_st8_fsm_6;
    sc_signal< bool > ap_sig_bdd_166;
    sc_signal< sc_logic > ap_sig_cseq_ST_st3_fsm_2;
    sc_signal< bool > ap_sig_bdd_173;
    sc_signal< sc_lv<24> > axi_data_V_3_reg_309;
    sc_signal< sc_lv<24> > axi_data_V1_reg_172;
    sc_signal< sc_lv<11> > p_s_reg_182;
    sc_signal< sc_lv<32> > res_3_reg_321;
    sc_signal< sc_lv<32> > res_reg_193;
    sc_signal< sc_lv<1> > eol_1_phi_fu_209_p4;
    sc_signal< sc_lv<24> > axi_data_V_1_phi_fu_220_p4;
    sc_signal< sc_lv<32> > res_1_phi_fu_242_p4;
    sc_signal< sc_lv<1> > eol_phi_fu_254_p4;
    sc_signal< sc_lv<1> > ap_reg_phiprechg_axi_last_V_2_reg_262pp1_it0;
    sc_signal< sc_lv<24> > ap_reg_phiprechg_p_Val2_s_reg_274pp1_it0;
    sc_signal< sc_lv<24> > p_Val2_s_phi_fu_278_p4;
    sc_signal< sc_lv<1> > ap_reg_phiprechg_eol_2_reg_286pp1_it0;
    sc_signal< sc_lv<1> > eol_2_phi_fu_290_p4;
    sc_signal< sc_lv<1> > axi_last_V_1_mux_fu_403_p2;
    sc_signal< sc_lv<1> > eol_3_reg_333;
    sc_signal< sc_lv<1> > sof_1_fu_112;
    sc_signal< sc_lv<1> > not_sof_2_fu_397_p2;
    sc_signal< sc_lv<1> > tmp_4_fu_416_p1;
    sc_signal< sc_lv<1> > not_tmp_6_fu_410_p2;
    sc_signal< sc_lv<31> > tmp_5_fu_426_p4;
    sc_signal< sc_lv<1> > tmp_8_fu_420_p2;
    sc_signal< sc_lv<32> > res_1_s_fu_436_p3;
    sc_signal< sc_lv<1> > tmp_user_V_fu_355_p1;
    sc_signal< sc_lv<7> > ap_NS_fsm;
    sc_signal< bool > ap_sig_bdd_335;
    sc_signal< bool > ap_sig_bdd_111;
    sc_signal< bool > ap_sig_bdd_200;
    sc_signal< bool > ap_sig_bdd_124;
    sc_signal< bool > ap_sig_bdd_216;
    static const sc_logic ap_const_logic_1;
    static const sc_logic ap_const_logic_0;
    static const sc_lv<7> ap_ST_st1_fsm_0;
    static const sc_lv<7> ap_ST_st2_fsm_1;
    static const sc_lv<7> ap_ST_st3_fsm_2;
    static const sc_lv<7> ap_ST_st4_fsm_3;
    static const sc_lv<7> ap_ST_pp1_stg0_fsm_4;
    static const sc_lv<7> ap_ST_st7_fsm_5;
    static const sc_lv<7> ap_ST_st8_fsm_6;
    static const sc_lv<32> ap_const_lv32_0;
    static const sc_lv<1> ap_const_lv1_1;
    static const sc_lv<32> ap_const_lv32_1;
    static const sc_lv<32> ap_const_lv32_3;
    static const sc_lv<32> ap_const_lv32_4;
    static const sc_lv<1> ap_const_lv1_0;
    static const sc_lv<32> ap_const_lv32_5;
    static const sc_lv<32> ap_const_lv32_6;
    static const sc_lv<32> ap_const_lv32_2;
    static const sc_lv<11> ap_const_lv11_0;
    static const sc_lv<11> ap_const_lv11_780;
    static const sc_lv<11> ap_const_lv11_1;
    static const sc_lv<11> ap_const_lv11_438;
    static const sc_lv<11> ap_const_lv11_437;
    static const sc_lv<32> ap_const_lv32_1F;
    static const sc_lv<32> ap_const_lv32_8;
    static const sc_lv<32> ap_const_lv32_F;
    static const sc_lv<32> ap_const_lv32_10;
    static const sc_lv<32> ap_const_lv32_17;
    static const bool ap_true;
    // Thread declarations
    void thread_ap_clk_no_reset_();
    void thread_AXI_video_strm_V_data_V_2();
    void thread_AXI_video_strm_V_data_V_2_ap_vld();
    void thread_ap_done();
    void thread_ap_idle();
    void thread_ap_ready();
    void thread_ap_reg_phiprechg_axi_last_V_2_reg_262pp1_it0();
    void thread_ap_reg_phiprechg_eol_2_reg_286pp1_it0();
    void thread_ap_reg_phiprechg_p_Val2_s_reg_274pp1_it0();
    void thread_ap_sig_bdd_104();
    void thread_ap_sig_bdd_111();
    void thread_ap_sig_bdd_112();
    void thread_ap_sig_bdd_124();
    void thread_ap_sig_bdd_141();
    void thread_ap_sig_bdd_146();
    void thread_ap_sig_bdd_166();
    void thread_ap_sig_bdd_173();
    void thread_ap_sig_bdd_200();
    void thread_ap_sig_bdd_216();
    void thread_ap_sig_bdd_26();
    void thread_ap_sig_bdd_335();
    void thread_ap_sig_bdd_79();
    void thread_ap_sig_bdd_93();
    void thread_ap_sig_cseq_ST_pp1_stg0_fsm_4();
    void thread_ap_sig_cseq_ST_st1_fsm_0();
    void thread_ap_sig_cseq_ST_st2_fsm_1();
    void thread_ap_sig_cseq_ST_st3_fsm_2();
    void thread_ap_sig_cseq_ST_st4_fsm_3();
    void thread_ap_sig_cseq_ST_st7_fsm_5();
    void thread_ap_sig_cseq_ST_st8_fsm_6();
    void thread_axi_data_V_1_phi_fu_220_p4();
    void thread_axi_last_V_1_mux_fu_403_p2();
    void thread_brmerge_fu_391_p2();
    void thread_eol_1_phi_fu_209_p4();
    void thread_eol_2_phi_fu_290_p4();
    void thread_eol_phi_fu_254_p4();
    void thread_exitcond1_fu_364_p2();
    void thread_exitcond2_fu_376_p2();
    void thread_i_V_fu_370_p2();
    void thread_img_data_stream_0_V_ap_vld();
    void thread_img_data_stream_0_V_din();
    void thread_img_data_stream_0_V_write();
    void thread_img_data_stream_1_V_ap_vld();
    void thread_img_data_stream_1_V_din();
    void thread_img_data_stream_1_V_write();
    void thread_img_data_stream_2_V_ap_vld();
    void thread_img_data_stream_2_V_din();
    void thread_img_data_stream_2_V_write();
    void thread_j_V_fu_382_p2();
    void thread_not_sof_2_fu_397_p2();
    void thread_not_tmp_6_fu_410_p2();
    void thread_p_Val2_s_phi_fu_278_p4();
    void thread_res_1_phi_fu_242_p4();
    void thread_res_1_s_fu_436_p3();
    void thread_res_2_fu_444_p3();
    void thread_res_4_fu_481_p2();
    void thread_tmp_4_fu_416_p1();
    void thread_tmp_5_fu_426_p4();
    void thread_tmp_6_fu_452_p1();
    void thread_tmp_8_fu_420_p2();
    void thread_tmp_user_V_fu_355_p1();
    void thread_video_in_TREADY();
    void thread_ap_NS_fsm();
};

}

using namespace ap_rtl;

#endif
