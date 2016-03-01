set moduleName sandbox_Block_proc
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set C_modelName sandbox_Block__proc
set C_modelType { void 0 }
set C_modelArgList { 
	{ result int 32 regular {pointer 0 volatile }  }
	{ video_out_V_data_V int 24 regular {axi_s 1 volatile  { video_out data } }  }
	{ video_out_V_keep_V int 3 regular {axi_s 1 volatile  { video_out keep } }  }
	{ video_out_V_strb_V int 3 regular {axi_s 1 volatile  { video_out strb } }  }
	{ video_out_V_user_V int 1 regular {axi_s 1 volatile  { video_out user } }  }
	{ video_out_V_last_V int 1 regular {axi_s 1 volatile  { video_out last } }  }
	{ video_out_V_id_V int 1 regular {axi_s 1 volatile  { video_out id } }  }
	{ video_out_V_dest_V int 1 regular {axi_s 1 volatile  { video_out dest } }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "result", "interface" : "wire", "bitwidth" : 32} , 
 	{ "Name" : "video_out_V_data_V", "interface" : "axis", "bitwidth" : 24} , 
 	{ "Name" : "video_out_V_keep_V", "interface" : "axis", "bitwidth" : 3} , 
 	{ "Name" : "video_out_V_strb_V", "interface" : "axis", "bitwidth" : 3} , 
 	{ "Name" : "video_out_V_user_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "video_out_V_last_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "video_out_V_id_V", "interface" : "axis", "bitwidth" : 1} , 
 	{ "Name" : "video_out_V_dest_V", "interface" : "axis", "bitwidth" : 1} ]}
# RTL Port declarations: 
set portNum 17
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ result sc_in sc_lv 32 signal 0 } 
	{ video_out_TDATA sc_out sc_lv 24 signal 1 } 
	{ video_out_TVALID sc_out sc_logic 1 outvld 7 } 
	{ video_out_TREADY sc_in sc_logic 1 outacc 7 } 
	{ video_out_TKEEP sc_out sc_lv 3 signal 2 } 
	{ video_out_TSTRB sc_out sc_lv 3 signal 3 } 
	{ video_out_TUSER sc_out sc_lv 1 signal 4 } 
	{ video_out_TLAST sc_out sc_lv 1 signal 5 } 
	{ video_out_TID sc_out sc_lv 1 signal 6 } 
	{ video_out_TDEST sc_out sc_lv 1 signal 7 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "result", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "result", "role": "default" }} , 
 	{ "name": "video_out_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "video_out_V_data_V", "role": "default" }} , 
 	{ "name": "video_out_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "video_out_V_dest_V", "role": "default" }} , 
 	{ "name": "video_out_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "video_out_V_dest_V", "role": "default" }} , 
 	{ "name": "video_out_TKEEP", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "video_out_V_keep_V", "role": "default" }} , 
 	{ "name": "video_out_TSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "video_out_V_strb_V", "role": "default" }} , 
 	{ "name": "video_out_TUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "video_out_V_user_V", "role": "default" }} , 
 	{ "name": "video_out_TLAST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "video_out_V_last_V", "role": "default" }} , 
 	{ "name": "video_out_TID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "video_out_V_id_V", "role": "default" }} , 
 	{ "name": "video_out_TDEST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "video_out_V_dest_V", "role": "default" }}  ]}
set Spec2ImplPortList { 
	result { ap_none {  { result in_data 0 32 } } }
	video_out_V_data_V { axis {  { video_out_TDATA out_data 1 24 } } }
	video_out_V_keep_V { axis {  { video_out_TKEEP out_data 1 3 } } }
	video_out_V_strb_V { axis {  { video_out_TSTRB out_data 1 3 } } }
	video_out_V_user_V { axis {  { video_out_TUSER out_data 1 1 } } }
	video_out_V_last_V { axis {  { video_out_TLAST out_data 1 1 } } }
	video_out_V_id_V { axis {  { video_out_TID out_data 1 1 } } }
	video_out_V_dest_V { axis {  { video_out_TVALID out_vld 1 1 }  { video_out_TREADY out_acc 0 1 }  { video_out_TDEST out_data 1 1 } } }
}
