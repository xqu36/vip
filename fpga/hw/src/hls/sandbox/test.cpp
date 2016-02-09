#include "hls_opencv.h"
#include "sandbox.h"
#include "../common/image_utils.h"

using namespace cv;

extern void opencv_sandbox(IplImage *src, IplImage *dst);
extern void hls_sandbox(IplImage *src, IplImage *dst);

int main (int argc, char** argv)
{
    Mat src_rgb = imread(INPUT_IMAGE);
    Mat dst_rgb(src_rgb.rows, src_rgb.cols, CV_8UC3);
    
    IplImage cv_src = src_rgb;
    IplImage cv_dst = dst_rgb;

    //hls_sandbox(&cv_src, &cv_dst);
    imwrite(OUTPUT_IMAGE, dst_rgb);

    //opencv_sandbox(&cv_src, &cv_dst);
    imwrite(OUTPUT_IMAGE_GOLDEN, dst_rgb);

    return image_compare(OUTPUT_IMAGE, OUTPUT_IMAGE_GOLDEN);
}
