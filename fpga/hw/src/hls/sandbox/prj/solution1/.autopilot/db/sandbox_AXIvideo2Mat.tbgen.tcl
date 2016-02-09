set moduleName sandbox_AXIvideo2Mat
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set C_modelName sandbox_AXIvideo2Mat
set C_modelType { void 0 }
set C_modelArgList { 
	{ AXI_video_strm_V_data_V_2 int 32 regular {pointer 1 volatile }  }
	{ AXI_video_strm_V_data_V int 24 regular {axi_s 0 volatile  { video_in data } }  }
	{ AXI_video_strm_V_keep_V int 3 regular {axi_s 0 volatile  { video_in keep } }  }
	{ AXI_video_strm_V_strb_V int 3 regular {axi_s 0 volatile  { video_in strb } }  }
	{ AXI_video_strm_V_user_V int 1 regular {axi_s 0 volatile  { video_in user } }  }
	{ AXI_video_strm_V_last_V int 1 regular {axi_s 0 volatile  { video_in last } }  }
	{ AXI_video_strm_V_id_V int 1 regular {axi_s 0 volatile  { video_in id } }  }
	{ AXI_video_strm_V_dest_V int 1 regular {axi_s 0 volatile  { video_in dest } }  }
	{ img_data_stream_0_V int 8 regular {fifo 1 volatile }  }
	{ img_data_stream_1_V int 8 regular {fifo 1 volatile }  }
	{ img_data_stream_2_V int 8 regular {fifo 1 volatile }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "AXI_video_strm_V_data_V_2", "interface" : "wire", "bitwidth" : 32} , 
 	{ "Name" : "AXI_video_strm_V_data_V", "interface" : "axis", "bitwidth" : 24} , 
 	{ "Name" : "AXI_video_strm_V_keep_V", "interface" : "axis", "bitwidth" : 3} , 
 	{ "Name" : "AXI_video_strm_V_strb_V", "interface" : "axis", "bitwidth" : 3} , 
 	{ "Name" : "AXI_video_strm_V_user_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "AXI_video_strm_V_last_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "AXI_video_strm_V_id_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "AXI_video_strm_V_dest_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "img_data_stream_0_V", "interface" : "fifo", "bitwidth" : 8} , 
 	{ "Name" : "img_data_stream_1_V", "interface" : "fifo", "bitwidth" : 8} , 
 	{ "Name" : "img_data_stream_2_V", "interface" : "fifo", "bitwidth" : 8} ]}
# RTL Port declarations: 
set portNum 30
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ AXI_video_strm_V_data_V_2 sc_out sc_lv 32 signal 0 } 
	{ AXI_video_strm_V_data_V_2_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ video_in_TDATA sc_in sc_lv 24 signal 1 } 
	{ video_in_TVALID sc_in sc_logic 1 invld 1 } 
	{ video_in_TREADY sc_out sc_logic 1 inacc 7 } 
	{ video_in_TKEEP sc_in sc_lv 3 signal 2 } 
	{ video_in_TSTRB sc_in sc_lv 3 signal 3 } 
	{ video_in_TUSER sc_in sc_lv 1 signal 4 } 
	{ video_in_TLAST sc_in sc_lv 1 signal 5 } 
	{ video_in_TID sc_in sc_lv 1 signal 6 } 
	{ video_in_TDEST sc_in sc_lv 1 signal 7 } 
	{ img_data_stream_0_V_din sc_out sc_lv 8 signal 8 } 
	{ img_data_stream_0_V_full_n sc_in sc_logic 1 signal 8 } 
	{ img_data_stream_0_V_write sc_out sc_logic 1 signal 8 } 
	{ img_data_stream_1_V_din sc_out sc_lv 8 signal 9 } 
	{ img_data_stream_1_V_full_n sc_in sc_logic 1 signal 9 } 
	{ img_data_stream_1_V_write sc_out sc_logic 1 signal 9 } 
	{ img_data_stream_2_V_din sc_out sc_lv 8 signal 10 } 
	{ img_data_stream_2_V_full_n sc_in sc_logic 1 signal 10 } 
	{ img_data_stream_2_V_write sc_out sc_logic 1 signal 10 } 
	{ img_data_stream_0_V_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ img_data_stream_1_V_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ img_data_stream_2_V_ap_vld sc_out sc_logic 1 outvld 10 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "AXI_video_strm_V_data_V_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXI_video_strm_V_data_V_2", "role": "default" }} , 
 	{ "name": "AXI_video_strm_V_data_V_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "AXI_video_strm_V_data_V_2", "role": "ap_vld" }} , 
 	{ "name": "video_in_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "AXI_video_strm_V_data_V", "role": "default" }} , 
 	{ "name": "video_in_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "AXI_video_strm_V_data_V", "role": "default" }} , 
 	{ "name": "video_in_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "AXI_video_strm_V_dest_V", "role": "default" }} , 
 	{ "name": "video_in_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "AXI_video_strm_V_keep_V", "role": "default" }} , 
 	{ "name": "video_in_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "AXI_video_strm_V_strb_V", "role": "default" }} , 
 	{ "name": "video_in_TUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "AXI_video_strm_V_user_V", "role": "default" }} , 
 	{ "name": "video_in_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "AXI_video_strm_V_last_V", "role": "default" }} , 
 	{ "name": "video_in_TID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "AXI_video_strm_V_id_V", "role": "default" }} , 
 	{ "name": "video_in_TDEST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "AXI_video_strm_V_dest_V", "role": "default" }} , 
 	{ "name": "img_data_stream_0_V_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "img_data_stream_0_V", "role": "din" }} , 
 	{ "name": "img_data_stream_0_V_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img_data_stream_0_V", "role": "full_n" }} , 
 	{ "name": "img_data_stream_0_V_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img_data_stream_0_V", "role": "write" }} , 
 	{ "name": "img_data_stream_1_V_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "img_data_stream_1_V", "role": "din" }} , 
 	{ "name": "img_data_stream_1_V_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img_data_stream_1_V", "role": "full_n" }} , 
 	{ "name": "img_data_stream_1_V_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img_data_stream_1_V", "role": "write" }} , 
 	{ "name": "img_data_stream_2_V_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "img_data_stream_2_V", "role": "din" }} , 
 	{ "name": "img_data_stream_2_V_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img_data_stream_2_V", "role": "full_n" }} , 
 	{ "name": "img_data_stream_2_V_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img_data_stream_2_V", "role": "write" }} , 
 	{ "name": "img_data_stream_0_V_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "img_data_stream_0_V", "role": "ap_vld" }} , 
 	{ "name": "img_data_stream_1_V_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "img_data_stream_1_V", "role": "ap_vld" }} , 
 	{ "name": "img_data_stream_2_V_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "img_data_stream_2_V", "role": "ap_vld" }}  ]}
set Spec2ImplPortList { 
	AXI_video_strm_V_data_V_2 { ap_vld {  { AXI_video_strm_V_data_V_2 out_data 1 32 }  { AXI_video_strm_V_data_V_2_ap_vld out_vld 1 1 } } }
	AXI_video_strm_V_data_V { axis {  { video_in_TDATA in_data 0 24 }  { video_in_TVALID in_vld 0 1 } } }
	AXI_video_strm_V_keep_V { axis {  { video_in_TKEEP in_data 0 3 } } }
	AXI_video_strm_V_strb_V { axis {  { video_in_TSTRB in_data 0 3 } } }
	AXI_video_strm_V_user_V { axis {  { video_in_TUSER in_data 0 1 } } }
	AXI_video_strm_V_last_V { axis {  { video_in_TLAST in_data 0 1 } } }
	AXI_video_strm_V_id_V { axis {  { video_in_TID in_data 0 1 } } }
	AXI_video_strm_V_dest_V { axis {  { video_in_TREADY in_acc 1 1 }  { video_in_TDEST in_data 0 1 } } }
	img_data_stream_0_V { ap_fifo {  { img_data_stream_0_V_din fifo_data 1 8 }  { img_data_stream_0_V_full_n fifo_status 0 1 }  { img_data_stream_0_V_write fifo_update 1 1 }  { img_data_stream_0_V_ap_vld out_vld 1 1 } } }
	img_data_stream_1_V { ap_fifo {  { img_data_stream_1_V_din fifo_data 1 8 }  { img_data_stream_1_V_full_n fifo_status 0 1 }  { img_data_stream_1_V_write fifo_update 1 1 }  { img_data_stream_1_V_ap_vld out_vld 1 1 } } }
	img_data_stream_2_V { ap_fifo {  { img_data_stream_2_V_din fifo_data 1 8 }  { img_data_stream_2_V_full_n fifo_status 0 1 }  { img_data_stream_2_V_write fifo_update 1 1 }  { img_data_stream_2_V_ap_vld out_vld 1 1 } } }
}
