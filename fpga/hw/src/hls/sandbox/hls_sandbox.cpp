#include "hls_opencv.h"
#include "sandbox.h"

using namespace cv;

void hls_sandbox(IplImage *_src, IplImage *_dst)
{
	Mat src(_src);
	Mat dst(_dst);
    AXI_STREAM src_axi, dst_axi;

    cvMat2AXIvideo(src, src_axi);
   	sandbox(src_axi, dst_axi, src.rows, src.cols);
    AXIvideo2cvMat(dst_axi, dst);
}
