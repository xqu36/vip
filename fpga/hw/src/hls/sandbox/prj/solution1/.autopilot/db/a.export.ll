; ModuleID = '/home/jdanner3/VIP/repos/vip/fpga/hw/src/hls/sandbox/prj/solution1/.autopilot/db/a.o.2.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@p_str1805 = private unnamed_addr constant [5 x i8] c"axis\00", align 1
@p_str1806 = private unnamed_addr constant [13 x i8] c"INPUT_STREAM\00", align 1
@p_str1807 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@p_str1808 = private unnamed_addr constant [14 x i8] c"OUTPUT_STREAM\00", align 1
@p_str1809 = private unnamed_addr constant [10 x i8] c"s_axilite\00", align 1
@p_str1810 = private unnamed_addr constant [12 x i8] c"CONTROL_BUS\00", align 1
@p_str1811 = private unnamed_addr constant [5 x i8] c"0x14\00", align 1
@p_str1812 = private unnamed_addr constant [5 x i8] c"0x1C\00", align 1
@p_str1813 = private unnamed_addr constant [7 x i8] c"result\00", align 1
@p_str1814 = private unnamed_addr constant [8 x i8] c"top.cpp\00", align 1
@p_PRETTY_FUNCTION_Z7sandbox = private unnamed_addr constant [51 x i8] c"void sandbox(AXI_STREAM &, AXI_STREAM &, int, int)\00", align 1
@p_str1818 = private unnamed_addr constant [12 x i8] c"loop_height\00", align 1
@p_str1819 = private unnamed_addr constant [11 x i8] c"loop_width\00", align 1
@p_str1823 = private unnamed_addr constant [13 x i8] c"hls_label_18\00", align 1
@p_str1826 = private unnamed_addr constant [20 x i8] c"loop_wait_for_start\00", align 1
@p_str1827 = private unnamed_addr constant [18 x i8] c"loop_wait_for_eol\00", align 1
@p_str1828 = private unnamed_addr constant [13 x i8] c"hls_label_20\00", align 1
@llvm_global_ctors_0 = appending global [1 x i32] [i32 65535]
@llvm_global_ctors_1 = appending global [1 x void ()*] [void ()* @_GLOBAL__I_a]
@str = internal constant [8 x i8] c"sandbox\00"
@str1 = internal constant [8 x i8] c"ap_fifo\00"
@str2 = internal constant [1 x i8] zeroinitializer
@str3 = internal constant [8 x i8] c"ap_fifo\00"
@str4 = internal constant [1 x i8] zeroinitializer
@str5 = internal constant [8 x i8] c"ap_fifo\00"
@str6 = internal constant [1 x i8] zeroinitializer
@str7 = internal constant [8 x i8] c"ap_fifo\00"
@str8 = internal constant [1 x i8] zeroinitializer
@str9 = internal constant [8 x i8] c"ap_fifo\00"
@str10 = internal constant [1 x i8] zeroinitializer
@str11 = internal constant [8 x i8] c"ap_fifo\00"
@str12 = internal constant [1 x i8] zeroinitializer

define void @sandbox(i24* %INPUT_STREAM_V_data_V, i3* %INPUT_STREAM_V_keep_V, i3* %INPUT_STREAM_V_strb_V, i1* %INPUT_STREAM_V_user_V, i1* %INPUT_STREAM_V_last_V, i1* %INPUT_STREAM_V_id_V, i1* %INPUT_STREAM_V_dest_V, i24* %OUTPUT_STREAM_V_data_V, i3* %OUTPUT_STREAM_V_keep_V, i3* %OUTPUT_STREAM_V_strb_V, i1* %OUTPUT_STREAM_V_user_V, i1* %OUTPUT_STREAM_V_last_V, i1* %OUTPUT_STREAM_V_id_V, i1* %OUTPUT_STREAM_V_dest_V, i32 %rows, i32 %cols) {
codeRepl:
  %result_channel = alloca i32, align 4
  call void (...)* @_ssdm_op_SpecDataflowPipeline(i32 -1, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecBitsMap(i24* %INPUT_STREAM_V_data_V), !map !7
  call void (...)* @_ssdm_op_SpecBitsMap(i3* %INPUT_STREAM_V_keep_V), !map !11
  call void (...)* @_ssdm_op_SpecBitsMap(i3* %INPUT_STREAM_V_strb_V), !map !15
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %INPUT_STREAM_V_user_V), !map !19
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %INPUT_STREAM_V_last_V), !map !23
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %INPUT_STREAM_V_id_V), !map !27
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %INPUT_STREAM_V_dest_V), !map !31
  call void (...)* @_ssdm_op_SpecBitsMap(i24* %OUTPUT_STREAM_V_data_V), !map !35
  call void (...)* @_ssdm_op_SpecBitsMap(i3* %OUTPUT_STREAM_V_keep_V), !map !39
  call void (...)* @_ssdm_op_SpecBitsMap(i3* %OUTPUT_STREAM_V_strb_V), !map !43
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %OUTPUT_STREAM_V_user_V), !map !47
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %OUTPUT_STREAM_V_last_V), !map !51
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %OUTPUT_STREAM_V_id_V), !map !55
  call void (...)* @_ssdm_op_SpecBitsMap(i1* %OUTPUT_STREAM_V_dest_V), !map !59
  call void (...)* @_ssdm_op_SpecBitsMap(i32 %rows), !map !63
  call void (...)* @_ssdm_op_SpecBitsMap(i32 %cols), !map !69
  call void (...)* @_ssdm_op_SpecTopModule([8 x i8]* @str) nounwind
  %src_data_stream_V_0 = alloca i8, align 1
  call void (...)* @_ssdm_op_SpecInterface(i8* %src_data_stream_V_0, [8 x i8]* @str1, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str2, [1 x i8]* @str2, [8 x i8]* @str1)
  %src_data_stream_V_1 = alloca i8, align 1
  call void (...)* @_ssdm_op_SpecInterface(i8* %src_data_stream_V_1, [8 x i8]* @str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str4, [1 x i8]* @str4, [8 x i8]* @str3)
  %src_data_stream_V_2 = alloca i8, align 1
  call void (...)* @_ssdm_op_SpecInterface(i8* %src_data_stream_V_2, [8 x i8]* @str5, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str6, [1 x i8]* @str6, [8 x i8]* @str5)
  call void (...)* @_ssdm_op_SpecInterface(i24* %INPUT_STREAM_V_data_V, i3* %INPUT_STREAM_V_keep_V, i3* %INPUT_STREAM_V_strb_V, i1* %INPUT_STREAM_V_user_V, i1* %INPUT_STREAM_V_last_V, i1* %INPUT_STREAM_V_id_V, i1* %INPUT_STREAM_V_dest_V, [5 x i8]* @p_str1805, i32 0, i32 0, i32 0, i32 0, [13 x i8]* @p_str1806, [1 x i8]* @p_str1807, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i24* %OUTPUT_STREAM_V_data_V, i3* %OUTPUT_STREAM_V_keep_V, i3* %OUTPUT_STREAM_V_strb_V, i1* %OUTPUT_STREAM_V_user_V, i1* %OUTPUT_STREAM_V_last_V, i1* %OUTPUT_STREAM_V_id_V, i1* %OUTPUT_STREAM_V_dest_V, [5 x i8]* @p_str1805, i32 0, i32 0, i32 0, i32 0, [14 x i8]* @p_str1808, [1 x i8]* @p_str1807, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32 %rows, [10 x i8]* @p_str1809, i32 0, i32 0, i32 0, i32 0, [12 x i8]* @p_str1810, [5 x i8]* @p_str1811, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32 %cols, [10 x i8]* @p_str1809, i32 0, i32 0, i32 0, i32 0, [12 x i8]* @p_str1810, [5 x i8]* @p_str1812, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32 0, [10 x i8]* @p_str1809, i32 0, i32 0, i32 0, i32 0, [12 x i8]* @p_str1810, [1 x i8]* @p_str1807, [1 x i8]* @p_str1807) nounwind
  call fastcc void @sandbox_AXIvideo2Mat(i32* %result_channel, i24* %INPUT_STREAM_V_data_V, i3* %INPUT_STREAM_V_keep_V, i3* %INPUT_STREAM_V_strb_V, i1* %INPUT_STREAM_V_user_V, i1* %INPUT_STREAM_V_last_V, i1* %INPUT_STREAM_V_id_V, i1* %INPUT_STREAM_V_dest_V, i8* %src_data_stream_V_0, i8* %src_data_stream_V_1, i8* %src_data_stream_V_2)
  call fastcc void @sandbox_Block__proc(i32* %result_channel, i24* %OUTPUT_STREAM_V_data_V, i3* %OUTPUT_STREAM_V_keep_V, i3* %OUTPUT_STREAM_V_strb_V, i1* %OUTPUT_STREAM_V_user_V, i1* %OUTPUT_STREAM_V_last_V, i1* %OUTPUT_STREAM_V_id_V, i1* %OUTPUT_STREAM_V_dest_V)
  unreachable
}

define weak void @_ssdm_op_SpecInterface(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecDataflowPipeline(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecLoopName(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecLoopTripCount(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecPipeline(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecProtocol(...) nounwind {
entry:
  ret void
}

declare void @llvm.dbg.value(metadata, i64, metadata) nounwind readnone

define weak void @_ssdm_op_SpecTopModule(...) {
entry:
  ret void
}

declare void @_GLOBAL__I_a() nounwind section ".text.startup"

define weak i32 @_ssdm_op_SpecRegionBegin(...) {
entry:
  ret i32 0
}

define weak i32 @_ssdm_op_SpecRegionEnd(...) {
entry:
  ret i32 0
}

define weak void @_ssdm_op_SpecBitsMap(...) {
entry:
  ret void
}

define weak i8 @_ssdm_op_PartSelect.i8.i24.i32.i32(i24, i32, i32) nounwind readnone {
entry:
  %empty = call i24 @llvm.part.select.i24(i24 %0, i32 %1, i32 %2)
  %empty_6 = trunc i24 %empty to i8
  ret i8 %empty_6
}

define weak i24 @_ssdm_op_BitConcatenate.i24.i8.i8.i8(i8, i8, i8) nounwind readnone {
entry:
  %empty = zext i8 %1 to i16
  %empty_7 = zext i8 %2 to i16
  %empty_8 = shl i16 %empty, 8
  %empty_9 = or i16 %empty_8, %empty_7
  %empty_10 = zext i8 %0 to i24
  %empty_11 = zext i16 %empty_9 to i24
  %empty_12 = shl i24 %empty_10, 16
  %empty_13 = or i24 %empty_12, %empty_11
  ret i24 %empty_13
}

define internal fastcc void @sandbox_AXIvideo2Mat(i32* nocapture %AXI_video_strm_V_data_V_2, i24* %AXI_video_strm_V_data_V, i3* %AXI_video_strm_V_keep_V, i3* %AXI_video_strm_V_strb_V, i1* %AXI_video_strm_V_user_V, i1* %AXI_video_strm_V_last_V, i1* %AXI_video_strm_V_id_V, i1* %AXI_video_strm_V_dest_V, i8* %img_data_stream_0_V, i8* %img_data_stream_1_V, i8* %img_data_stream_2_V) {
.critedge:
  call void (...)* @_ssdm_op_SpecInterface(i8* %img_data_stream_2_V, [8 x i8]* @str5, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str6, [1 x i8]* @str6, [8 x i8]* @str5)
  call void (...)* @_ssdm_op_SpecInterface(i8* %img_data_stream_1_V, [8 x i8]* @str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str4, [1 x i8]* @str4, [8 x i8]* @str3)
  call void (...)* @_ssdm_op_SpecInterface(i8* %img_data_stream_0_V, [8 x i8]* @str1, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str2, [1 x i8]* @str2, [8 x i8]* @str1)
  call void (...)* @_ssdm_op_SpecInterface(i1* %AXI_video_strm_V_dest_V, i1* %AXI_video_strm_V_id_V, i1* %AXI_video_strm_V_last_V, i1* %AXI_video_strm_V_user_V, i3* %AXI_video_strm_V_strb_V, i3* %AXI_video_strm_V_keep_V, i24* %AXI_video_strm_V_data_V, [5 x i8]* @p_str1805, i32 0, i32 0, i32 0, i32 0, [13 x i8]* @p_str1806, [1 x i8]* @p_str1807, [1 x i8]* @p_str1807)
  br label %0

; <label>:0                                       ; preds = %0, %.critedge
  call void (...)* @_ssdm_op_SpecLoopName([20 x i8]* @p_str1826) nounwind
  %tmp = call i32 (...)* @_ssdm_op_SpecRegionBegin([20 x i8]* @p_str1826)
  call void (...)* @_ssdm_op_SpecPipeline(i32 1, i32 1, i32 1, i32 0, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecLoopTripCount(i32 0, i32 0, i32 0, [1 x i8]* @p_str1807) nounwind
  %empty = call { i24, i3, i3, i1, i1, i1, i1 } @_ssdm_op_Read.ap_auto.volatile.i24P.i3P.i3P.i1P.i1P.i1P.i1P(i24* %AXI_video_strm_V_data_V, i3* %AXI_video_strm_V_keep_V, i3* %AXI_video_strm_V_strb_V, i1* %AXI_video_strm_V_user_V, i1* %AXI_video_strm_V_last_V, i1* %AXI_video_strm_V_id_V, i1* %AXI_video_strm_V_dest_V)
  %tmp_data_V = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty, 0
  %tmp_user_V = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty, 3
  %tmp_last_V = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty, 4
  %empty_14 = call i32 (...)* @_ssdm_op_SpecRegionEnd([20 x i8]* @p_str1826, i32 %tmp)
  br i1 %tmp_user_V, label %.preheader150.preheader, label %0

.preheader150.preheader:                          ; preds = %0
  %sof_1 = alloca i1, align 1
  store i1 true, i1* %sof_1, align 1
  br label %.preheader150

.preheader150:                                    ; preds = %.preheader150.preheader, %6
  %axi_last_V1 = phi i1 [ %axi_last_V_3, %6 ], [ %tmp_last_V, %.preheader150.preheader ]
  %axi_data_V1 = phi i24 [ %axi_data_V_3, %6 ], [ %tmp_data_V, %.preheader150.preheader ]
  %p_s = phi i11 [ %i_V, %6 ], [ 0, %.preheader150.preheader ]
  %res = phi i32 [ %res_3, %6 ], [ 0, %.preheader150.preheader ]
  %exitcond1 = icmp eq i11 %p_s, -128
  call void (...)* @_ssdm_op_SpecLoopTripCount(i64 1920, i64 1920, i64 1920)
  %i_V = add i11 %p_s, 1
  br i1 %exitcond1, label %7, label %1

; <label>:1                                       ; preds = %.preheader150
  call void (...)* @_ssdm_op_SpecLoopName([12 x i8]* @p_str1818) nounwind
  %tmp_1 = call i32 (...)* @_ssdm_op_SpecRegionBegin([12 x i8]* @p_str1818)
  br label %2

; <label>:2                                       ; preds = %_ifconv, %1
  %eol_1 = phi i1 [ %axi_last_V1, %1 ], [ %axi_last_V_2, %_ifconv ]
  %axi_data_V_1 = phi i24 [ %axi_data_V1, %1 ], [ %p_Val2_s, %_ifconv ]
  %p_1 = phi i11 [ 0, %1 ], [ %j_V, %_ifconv ]
  %res_1 = phi i32 [ %res, %1 ], [ %res_2, %_ifconv ]
  %eol = phi i1 [ false, %1 ], [ %eol_2, %_ifconv ]
  %exitcond2 = icmp eq i11 %p_1, -968
  call void (...)* @_ssdm_op_SpecLoopTripCount(i64 1080, i64 1080, i64 1080)
  %j_V = add i11 %p_1, 1
  br i1 %exitcond2, label %.preheader, label %3

; <label>:3                                       ; preds = %2
  %sof_1_load = load i1* %sof_1, align 1
  call void (...)* @_ssdm_op_SpecLoopName([11 x i8]* @p_str1819) nounwind
  %tmp_2 = call i32 (...)* @_ssdm_op_SpecRegionBegin([11 x i8]* @p_str1819)
  call void (...)* @_ssdm_op_SpecPipeline(i32 1, i32 1, i32 1, i32 0, [1 x i8]* @p_str1807) nounwind
  %brmerge = or i1 %sof_1_load, %eol
  %not_sof_2 = xor i1 %sof_1_load, true
  %axi_last_V_1_mux = or i1 %eol_1, %not_sof_2
  br i1 %brmerge, label %_ifconv, label %4

; <label>:4                                       ; preds = %3
  %empty_15 = call { i24, i3, i3, i1, i1, i1, i1 } @_ssdm_op_Read.ap_auto.volatile.i24P.i3P.i3P.i1P.i1P.i1P.i1P(i24* %AXI_video_strm_V_data_V, i3* %AXI_video_strm_V_keep_V, i3* %AXI_video_strm_V_strb_V, i1* %AXI_video_strm_V_user_V, i1* %AXI_video_strm_V_last_V, i1* %AXI_video_strm_V_id_V, i1* %AXI_video_strm_V_dest_V)
  %tmp_data_V_1 = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty_15, 0
  %tmp_last_V_1 = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty_15, 4
  br label %_ifconv

_ifconv:                                          ; preds = %4, %3
  %axi_last_V_2 = phi i1 [ %tmp_last_V_1, %4 ], [ %eol_1, %3 ]
  %p_Val2_s = phi i24 [ %tmp_data_V_1, %4 ], [ %axi_data_V_1, %3 ]
  %eol_2 = phi i1 [ %tmp_last_V_1, %4 ], [ %axi_last_V_1_mux, %3 ]
  %not_tmp_6 = icmp ne i11 %p_1, -969
  %tmp_4 = trunc i32 %res_1 to i1
  %tmp_8 = or i1 %tmp_4, %not_tmp_6
  %tmp_5 = call i31 @_ssdm_op_PartSelect.i31.i32.i32.i32(i32 %res_1, i32 1, i32 31)
  %res_1_s = call i32 @_ssdm_op_BitConcatenate.i32.i31.i1(i31 %tmp_5, i1 %tmp_8)
  %res_2 = select i1 %eol_2, i32 %res_1_s, i32 %res_1
  %tmp_6 = trunc i24 %p_Val2_s to i8
  %tmp_7 = call i8 @_ssdm_op_PartSelect.i8.i24.i32.i32(i24 %p_Val2_s, i32 8, i32 15)
  %tmp_9 = call i8 @_ssdm_op_PartSelect.i8.i24.i32.i32(i24 %p_Val2_s, i32 16, i32 23)
  %tmp_s = call i32 (...)* @_ssdm_op_SpecRegionBegin([13 x i8]* @p_str1828)
  call void (...)* @_ssdm_op_SpecProtocol(i32 0, [1 x i8]* @p_str1807) nounwind
  call void @_ssdm_op_Write.ap_auto.volatile.i8P(i8* %img_data_stream_0_V, i8 %tmp_6)
  call void @_ssdm_op_Write.ap_auto.volatile.i8P(i8* %img_data_stream_1_V, i8 %tmp_7)
  call void @_ssdm_op_Write.ap_auto.volatile.i8P(i8* %img_data_stream_2_V, i8 %tmp_9)
  %empty_16 = call i32 (...)* @_ssdm_op_SpecRegionEnd([13 x i8]* @p_str1828, i32 %tmp_s)
  %empty_17 = call i32 (...)* @_ssdm_op_SpecRegionEnd([11 x i8]* @p_str1819, i32 %tmp_2)
  store i1 false, i1* %sof_1, align 1
  br label %2

.preheader:                                       ; preds = %2, %5
  %axi_last_V_3 = phi i1 [ %tmp_last_V_2, %5 ], [ %eol_1, %2 ]
  %axi_data_V_3 = phi i24 [ %tmp_data_V_2, %5 ], [ %axi_data_V_1, %2 ]
  %res_3 = phi i32 [ %res_4, %5 ], [ %res_1, %2 ]
  %eol_3 = phi i1 [ %tmp_last_V_2, %5 ], [ %eol, %2 ]
  br i1 %eol_3, label %6, label %5

; <label>:5                                       ; preds = %.preheader
  call void (...)* @_ssdm_op_SpecLoopName([18 x i8]* @p_str1827) nounwind
  %tmp_3 = call i32 (...)* @_ssdm_op_SpecRegionBegin([18 x i8]* @p_str1827)
  call void (...)* @_ssdm_op_SpecPipeline(i32 1, i32 1, i32 1, i32 0, [1 x i8]* @p_str1807) nounwind
  call void (...)* @_ssdm_op_SpecLoopTripCount(i32 0, i32 0, i32 0, [1 x i8]* @p_str1807) nounwind
  %empty_18 = call { i24, i3, i3, i1, i1, i1, i1 } @_ssdm_op_Read.ap_auto.volatile.i24P.i3P.i3P.i1P.i1P.i1P.i1P(i24* %AXI_video_strm_V_data_V, i3* %AXI_video_strm_V_keep_V, i3* %AXI_video_strm_V_strb_V, i1* %AXI_video_strm_V_user_V, i1* %AXI_video_strm_V_last_V, i1* %AXI_video_strm_V_id_V, i1* %AXI_video_strm_V_dest_V)
  %tmp_data_V_2 = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty_18, 0
  %tmp_last_V_2 = extractvalue { i24, i3, i3, i1, i1, i1, i1 } %empty_18, 4
  %res_4 = or i32 %res_3, 2
  %empty_19 = call i32 (...)* @_ssdm_op_SpecRegionEnd([18 x i8]* @p_str1827, i32 %tmp_3)
  br label %.preheader

; <label>:6                                       ; preds = %.preheader
  %empty_20 = call i32 (...)* @_ssdm_op_SpecRegionEnd([12 x i8]* @p_str1818, i32 %tmp_1)
  br label %.preheader150

; <label>:7                                       ; preds = %.preheader150
  call void @_ssdm_op_Write.ap_auto.volatile.i32P(i32* %AXI_video_strm_V_data_V_2, i32 %res)
  ret void
}

define internal fastcc void @sandbox_Block__proc(i32* nocapture %result, i24* %video_out_V_data_V, i3* %video_out_V_keep_V, i3* %video_out_V_strb_V, i1* %video_out_V_user_V, i1* %video_out_V_last_V, i1* %video_out_V_id_V, i1* %video_out_V_dest_V) {
newFuncRoot:
  %tmp_user_V = alloca i1, align 1
  call void (...)* @_ssdm_op_SpecInterface(i1* %video_out_V_dest_V, i1* %video_out_V_id_V, i1* %video_out_V_last_V, i1* %video_out_V_user_V, i3* %video_out_V_strb_V, i3* %video_out_V_keep_V, i24* %video_out_V_data_V, [5 x i8]* @p_str1805, i32 0, i32 0, i32 0, i32 0, [14 x i8]* @p_str1808, [1 x i8]* @p_str1807, [1 x i8]* @p_str1807)
  %result_load = call i32 @_ssdm_op_Read.ap_auto.volatile.i32P(i32* %result)
  %img_data_stream_0_V_assign = alloca i8, align 1
  call void (...)* @_ssdm_op_SpecInterface(i8* %img_data_stream_0_V_assign, [8 x i8]* @str7, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str8, [1 x i8]* @str8, [8 x i8]* @str7)
  %img_data_stream_1_V_assign = alloca i8, align 1
  call void (...)* @_ssdm_op_SpecInterface(i8* %img_data_stream_1_V_assign, [8 x i8]* @str9, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str10, [1 x i8]* @str10, [8 x i8]* @str9)
  %img_data_stream_2_V_assign = alloca i8, align 1
  call void (...)* @_ssdm_op_SpecInterface(i8* %img_data_stream_2_V_assign, [8 x i8]* @str11, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @str12, [1 x i8]* @str12, [8 x i8]* @str11)
  store i1 true, i1* %tmp_user_V, align 1
  br label %.exitStub

.exitStub:                                        ; preds = %newFuncRoot, %2
  %p_i = phi i11 [ %i_V, %2 ], [ 0, %newFuncRoot ]
  %exitcond3_i = icmp eq i11 %p_i, -128
  call void (...)* @_ssdm_op_SpecLoopTripCount(i64 1920, i64 1920, i64 1920)
  %i_V = add i11 %p_i, 1
  br i1 %exitcond3_i, label %"Mat2AXIvideo<24, 1920, 1080, 32>.exit", label %0

; <label>:0                                       ; preds = %.exitStub
  call void (...)* @_ssdm_op_SpecLoopName([12 x i8]* @p_str1818) nounwind
  %tmp_i = call i32 (...)* @_ssdm_op_SpecRegionBegin([12 x i8]* @p_str1818)
  br label %1

; <label>:1                                       ; preds = %"operator>>.exit.i", %0
  %p_3_i = phi i11 [ 0, %0 ], [ %j_V, %"operator>>.exit.i" ]
  %exitcond4_i = icmp eq i11 %p_3_i, -968
  call void (...)* @_ssdm_op_SpecLoopTripCount(i64 1080, i64 1080, i64 1080)
  %j_V = add i11 %p_3_i, 1
  br i1 %exitcond4_i, label %2, label %"operator>>.exit.i"

"operator>>.exit.i":                              ; preds = %1
  %tmp_user_V_load = load i1* %tmp_user_V, align 1
  call void (...)* @_ssdm_op_SpecLoopName([11 x i8]* @p_str1819) nounwind
  %tmp_i_21 = call i32 (...)* @_ssdm_op_SpecRegionBegin([11 x i8]* @p_str1819)
  call void (...)* @_ssdm_op_SpecPipeline(i32 1, i32 1, i32 1, i32 0, [1 x i8]* @p_str1807) nounwind
  %axi_last_V = icmp eq i11 %p_3_i, -969
  %tmp_1_i = call i32 (...)* @_ssdm_op_SpecRegionBegin([13 x i8]* @p_str1823)
  call void (...)* @_ssdm_op_SpecProtocol(i32 0, [1 x i8]* @p_str1807) nounwind
  %tmp_10 = call i8 @_ssdm_op_Read.ap_fifo.volatile.i8P(i8* %img_data_stream_0_V_assign)
  %tmp_11 = call i8 @_ssdm_op_Read.ap_fifo.volatile.i8P(i8* %img_data_stream_1_V_assign)
  %tmp = call i8 @_ssdm_op_Read.ap_fifo.volatile.i8P(i8* %img_data_stream_2_V_assign)
  %empty = call i32 (...)* @_ssdm_op_SpecRegionEnd([13 x i8]* @p_str1823, i32 %tmp_1_i)
  %tmp_data_V = call i24 @_ssdm_op_BitConcatenate.i24.i8.i8.i8(i8 %tmp, i8 %tmp_11, i8 %tmp_10)
  call void @_ssdm_op_Write.ap_auto.volatile.i24P.i3P.i3P.i1P.i1P.i1P.i1P(i24* %video_out_V_data_V, i3* %video_out_V_keep_V, i3* %video_out_V_strb_V, i1* %video_out_V_user_V, i1* %video_out_V_last_V, i1* %video_out_V_id_V, i1* %video_out_V_dest_V, i24 %tmp_data_V, i3 -1, i3 undef, i1 %tmp_user_V_load, i1 %axi_last_V, i1 undef, i1 undef)
  %empty_22 = call i32 (...)* @_ssdm_op_SpecRegionEnd([11 x i8]* @p_str1819, i32 %tmp_i_21)
  store i1 false, i1* %tmp_user_V, align 1
  br label %1

; <label>:2                                       ; preds = %1
  %empty_23 = call i32 (...)* @_ssdm_op_SpecRegionEnd([12 x i8]* @p_str1818, i32 %tmp_i)
  br label %.exitStub

"Mat2AXIvideo<24, 1920, 1080, 32>.exit":          ; preds = %.exitStub
  ret void
}

define weak i31 @_ssdm_op_PartSelect.i31.i32.i32.i32(i32, i32, i32) nounwind readnone {
entry:
  %empty = call i32 @llvm.part.select.i32(i32 %0, i32 %1, i32 %2)
  %empty_24 = trunc i32 %empty to i31
  ret i31 %empty_24
}

define weak i32 @_ssdm_op_BitConcatenate.i32.i31.i1(i31, i1) nounwind readnone {
entry:
  %empty = zext i31 %0 to i32
  %empty_25 = zext i1 %1 to i32
  %empty_26 = shl i32 %empty, 1
  %empty_27 = or i32 %empty_26, %empty_25
  ret i32 %empty_27
}

define weak i32 @_ssdm_op_Read.ap_auto.volatile.i32P(i32*) {
entry:
  %empty = load i32* %0
  ret i32 %empty
}

define weak i8 @_ssdm_op_Read.ap_fifo.volatile.i8P(i8*) {
entry:
  %empty = call i8 @_autotb_FifoRead_i8(i8* %0)
  ret i8 %empty
}

define weak void @_ssdm_op_Write.ap_auto.volatile.i24P.i3P.i3P.i1P.i1P.i1P.i1P(i24*, i3*, i3*, i1*, i1*, i1*, i1*, i24, i3, i3, i1, i1, i1, i1) {
entry:
  store i24 %7, i24* %0
  store i3 %8, i3* %1
  store i3 %9, i3* %2
  store i1 %10, i1* %3
  store i1 %11, i1* %4
  store i1 %12, i1* %5
  store i1 %13, i1* %6
  ret void
}

define weak void @_ssdm_op_Write.ap_auto.volatile.i32P(i32*, i32) {
entry:
  store i32 %1, i32* %0
  ret void
}

define weak { i24, i3, i3, i1, i1, i1, i1 } @_ssdm_op_Read.ap_auto.volatile.i24P.i3P.i3P.i1P.i1P.i1P.i1P(i24*, i3*, i3*, i1*, i1*, i1*, i1*) {
entry:
  %empty = load i24* %0
  %empty_28 = load i3* %1
  %empty_29 = load i3* %2
  %empty_30 = load i1* %3
  %empty_31 = load i1* %4
  %empty_32 = load i1* %5
  %empty_33 = load i1* %6
  %mrv_0 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } undef, i24 %empty, 0
  %mrv1 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } %mrv_0, i3 %empty_28, 1
  %mrv2 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } %mrv1, i3 %empty_29, 2
  %mrv3 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } %mrv2, i1 %empty_30, 3
  %mrv4 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } %mrv3, i1 %empty_31, 4
  %mrv5 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } %mrv4, i1 %empty_32, 5
  %mrv6 = insertvalue { i24, i3, i3, i1, i1, i1, i1 } %mrv5, i1 %empty_33, 6
  ret { i24, i3, i3, i1, i1, i1, i1 } %mrv6
}

define weak void @_ssdm_op_Write.ap_auto.volatile.i8P(i8*, i8) {
entry:
  store i8 %1, i8* %0
  ret void
}

declare i8 @_autotb_FifoRead_i8(i8*)

declare i24 @llvm.part.select.i24(i24, i32, i32) nounwind readnone

declare i32 @llvm.part.select.i32(i32, i32, i32) nounwind readnone

declare i1 @_ssdm_op_PartSelect.i1.i32.i32.i32(i32, i32, i32) nounwind readnone

!llvm.map.gv = !{!0}

!0 = metadata !{metadata !1, [1 x i32]* @llvm_global_ctors_0}
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0, i32 31, metadata !3}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !"llvm.global_ctors.0", metadata !5, metadata !"", i32 0, i32 31}
!5 = metadata !{metadata !6}
!6 = metadata !{i32 0, i32 0, i32 1}
!7 = metadata !{metadata !8}
!8 = metadata !{i32 0, i32 23, metadata !9}
!9 = metadata !{metadata !10}
!10 = metadata !{metadata !"video_in.V.data.V", metadata !5, metadata !"uint24", i32 0, i32 23}
!11 = metadata !{metadata !12}
!12 = metadata !{i32 0, i32 2, metadata !13}
!13 = metadata !{metadata !14}
!14 = metadata !{metadata !"video_in.V.keep.V", metadata !5, metadata !"uint3", i32 0, i32 2}
!15 = metadata !{metadata !16}
!16 = metadata !{i32 0, i32 2, metadata !17}
!17 = metadata !{metadata !18}
!18 = metadata !{metadata !"video_in.V.strb.V", metadata !5, metadata !"uint3", i32 0, i32 2}
!19 = metadata !{metadata !20}
!20 = metadata !{i32 0, i32 0, metadata !21}
!21 = metadata !{metadata !22}
!22 = metadata !{metadata !"video_in.V.user.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!23 = metadata !{metadata !24}
!24 = metadata !{i32 0, i32 0, metadata !25}
!25 = metadata !{metadata !26}
!26 = metadata !{metadata !"video_in.V.last.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!27 = metadata !{metadata !28}
!28 = metadata !{i32 0, i32 0, metadata !29}
!29 = metadata !{metadata !30}
!30 = metadata !{metadata !"video_in.V.id.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!31 = metadata !{metadata !32}
!32 = metadata !{i32 0, i32 0, metadata !33}
!33 = metadata !{metadata !34}
!34 = metadata !{metadata !"video_in.V.dest.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!35 = metadata !{metadata !36}
!36 = metadata !{i32 0, i32 23, metadata !37}
!37 = metadata !{metadata !38}
!38 = metadata !{metadata !"video_out.V.data.V", metadata !5, metadata !"uint24", i32 0, i32 23}
!39 = metadata !{metadata !40}
!40 = metadata !{i32 0, i32 2, metadata !41}
!41 = metadata !{metadata !42}
!42 = metadata !{metadata !"video_out.V.keep.V", metadata !5, metadata !"uint3", i32 0, i32 2}
!43 = metadata !{metadata !44}
!44 = metadata !{i32 0, i32 2, metadata !45}
!45 = metadata !{metadata !46}
!46 = metadata !{metadata !"video_out.V.strb.V", metadata !5, metadata !"uint3", i32 0, i32 2}
!47 = metadata !{metadata !48}
!48 = metadata !{i32 0, i32 0, metadata !49}
!49 = metadata !{metadata !50}
!50 = metadata !{metadata !"video_out.V.user.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!51 = metadata !{metadata !52}
!52 = metadata !{i32 0, i32 0, metadata !53}
!53 = metadata !{metadata !54}
!54 = metadata !{metadata !"video_out.V.last.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!55 = metadata !{metadata !56}
!56 = metadata !{i32 0, i32 0, metadata !57}
!57 = metadata !{metadata !58}
!58 = metadata !{metadata !"video_out.V.id.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!59 = metadata !{metadata !60}
!60 = metadata !{i32 0, i32 0, metadata !61}
!61 = metadata !{metadata !62}
!62 = metadata !{metadata !"video_out.V.dest.V", metadata !5, metadata !"uint1", i32 0, i32 0}
!63 = metadata !{metadata !64}
!64 = metadata !{i32 0, i32 31, metadata !65}
!65 = metadata !{metadata !66}
!66 = metadata !{metadata !"rows", metadata !67, metadata !"int", i32 0, i32 31}
!67 = metadata !{metadata !68}
!68 = metadata !{i32 0, i32 0, i32 0}
!69 = metadata !{metadata !70}
!70 = metadata !{i32 0, i32 31, metadata !71}
!71 = metadata !{metadata !72}
!72 = metadata !{metadata !"cols", metadata !67, metadata !"int", i32 0, i32 31}
