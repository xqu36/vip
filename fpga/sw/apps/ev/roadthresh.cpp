#include "roadthresh.hpp"

cv::Mat roadThresh(Mat& frame) {

  Mat rgbSplit[3], frame_r, frame_g, frame_b;
  int rAve = 0, gAve = 0, bAve = 0, pixCount = 0;
  split(frame, rgbSplit);
  frame_r = rgbSplit[0] & pclass.carPath;
  frame_g = rgbSplit[1] & pclass.carPath;
  frame_b = rgbSplit[2] & pclass.carPath;

  for(int r = 0; r < frame_r.rows; r++){
    for(int c = 0; c < frame_r.cols; c++){
      if(pclass.carPath.at<unsigned char>(r, c) != 0){
  			pixCount++;
  			rAve += (int) frame_r.at<unsigned char>(r, c);
  			gAve += (int) frame_g.at<unsigned char>(r, c);
   			bAve += (int) frame_b.at<unsigned char>(r, c);
      }
    }
  }

  if(pixCount != 0){
    rAve = rAve / pixCount;
	  gAve = gAve / pixCount;
	  bAve = bAve / pixCount;

	  threshold(frame_r, frame_r, rAve - 30, 255, THRESH_TOZERO);
		threshold(frame_r, frame_r, rAve + 30, 255, THRESH_TOZERO_INV);
		threshold(frame_g, frame_g, gAve - 30, 255, THRESH_TOZERO);
		threshold(frame_g, frame_g, gAve + 30, 255, THRESH_TOZERO_INV);
		threshold(frame_b, frame_b, bAve - 30, 255, THRESH_TOZERO);
		threshold(frame_b, frame_b, bAve + 30, 255, THRESH_TOZERO_INV);

		for(int r = 0; r < frame_r.rows; r++){
      for(int c = 0; c < frame_r.cols; c++){
		    if(frame_r.at<unsigned char>(r, c) == 0){
		      frame_g.at<unsigned char>(r, c) = 0;
		      frame_b.at<unsigned char>(r, c) = 0;
		    } else if(frame_g.at<unsigned char>(r, c) == 0){
		      frame_r.at<unsigned char>(r, c) = 0;
		      frame_b.at<unsigned char>(r, c) = 0;
		    }
		    else if(frame_b.at<unsigned char>(r, c) == 0){
		      frame_g.at<unsigned char>(r, c) = 0;
		      frame_r.at<unsigned char>(r, c) = 0;
		    }
		  }
		}
  }

  Mat merged;
  merge(rgbSplit, 3, merged);
	cvtColor(merged, merged, CV_BGR2GRAY);

  return merged;

}
