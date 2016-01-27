#ifndef _TOP_H_
#define _TOP_H_

#include "hls_video.h"

// maximum image size
#define MAX_WIDTH  1920
#define MAX_HEIGHT 1080

// macros
#define HARRIS_DETECTOR_PARAM	0.04	// must be 0.04-0.06
#define HARRIS_THRESHOLD		0.001	// % thresh for corners

// I/O Image Settings
#define INPUT_IMAGE           "test_1080p.bmp"
#define OUTPUT_IMAGE          "result_1080p.bmp"
#define OUTPUT_IMAGE_GOLDEN   "result_1080p_golden.bmp"

#define ABSDIFF(x,y)	((x>y)? x - y : y - x)
#define ABS(x)          ((x>0)? x : -x)

// typedef video library core structures
//typedef hls::stream<ap_axiu<16,1,1,1> > AXI_STREAM;
typedef hls::stream<ap_axiu<24,1,1,1> > AXI_STREAM;

// top level function for HW synthesis
void sandbox(AXI_STREAM& INPUT_STREAM, AXI_STREAM& OUTPUT_STREAM, int rows, int cols);

#endif	// _TOP_H_
