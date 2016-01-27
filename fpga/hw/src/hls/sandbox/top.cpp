#include "sandbox.h"

void sandbox(AXI_STREAM& video_in, AXI_STREAM& video_out, int rows, int cols)
{
//Create AXI streaming interfaces for the core
#pragma HLS INTERFACE axis port=video_in bundle=INPUT_STREAM
#pragma HLS INTERFACE axis port=video_out bundle=OUTPUT_STREAM

#pragma HLS INTERFACE s_axilite port=rows bundle=CONTROL_BUS offset=0x14
#pragma HLS INTERFACE s_axilite port=cols bundle=CONTROL_BUS offset=0x1C
#pragma HLS INTERFACE s_axilite port=return bundle=CONTROL_BUS

// these were commented before??
//#pragma HLS INTERFACE ap_stable port=rows
//#pragma HLS INTERFACE ap_stable port=cols

    hls::Mat<MAX_WIDTH, MAX_HEIGHT, HLS_8UC3> src;
    hls::Mat<MAX_WIDTH, MAX_HEIGHT, HLS_8UC3> out;

    int result;

    // NOTE: streams are consumed; src must be duplicated

    /**
     * 				 |||			(hls::AXIvideo2Mat)
     * 				 src
     * 				  | 		
     *				  V
     *				 out
     *				 |||			(hls::Mat2AXIvideo)
     *
     */

#pragma HLS dataflow
    result = hls::AXIvideo2Mat(video_in, src);
    assert(result);

    result = hls::Mat2AXIvideo(out, video_out);
    assert(result);
}
