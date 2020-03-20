#include "opencv2/opencv.hpp"
#include "sandbox.h"

using namespace cv;

void opencv_sandbox(IplImage *_src, IplImage *_dst)
{
    Mat src(_src);
    Mat dst(_dst);

	/**
	 * Forced to use the legacy C API, as channel-based shenanigans prevented grayscale from being utilized.
	 */

    /*
	IplImage* gray = cvCreateImage(cvGetSize(_src), IPL_DEPTH_8U, 1);
	cvCvtColor(_src, gray, CV_BGR2GRAY);

    // use opencv lib cornerHarris
	IplImage* dst_32F = cvCreateImage(cvGetSize(_src), IPL_DEPTH_32F, 1);
    cvCornerHarris(gray, dst_32F, 5, 3, HARRIS_DETECTOR_PARAM);
    */

    /**
     * From this point on, I had to mix the C/C++ API. Mat seems to make/break things.
     */

    /*
    Mat mask(dst_32F);
    Mat mat_gray(gray);

    bool draw = false;
    for(int j=0; j<dst.rows; j++) {
    	for(int i=0; i<dst.cols; i++) {
    		draw = false;
    		if(mask.at<float>(j, i) > HARRIS_THRESHOLD) draw = true;

    		// populate original source pixels & paint mask if draw
    		dst.at<Vec3b>(j, i) = src.at<Vec3b>(j, i);
    		if(draw) dst.at<Vec3b>(j, i) = Vec3b(0, 0, 255);
    	}
    }
    */

}
