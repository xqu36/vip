/**
  * shadowsaver.cpp
  * 
  * preserves shadows within connected components and removes them otherwise
  *
  * 1) input foregroundMask with gray shadows
  * 2) save binary shadow mask
  * 3) invert image and set shadows to white
  * 4) traditional distance transform
  * 5) combine mask and foreground
  * 6) threshold appropriately (min, max?)
  * 7) prune shadows
  *
  **/

#include "shadowsaver.hpp"

// foregroundMask must exist as CV_8U [0,255]
void shadowSaver(Mat& foregroundMask) {

  // create shadowMask
  Mat shadowMask = Mat::zeros(foregroundMask.rows, foregroundMask.cols, CV_8U);
  Mat invertedMask = Mat::zeros(foregroundMask.rows, foregroundMask.cols, CV_8U);
  int val;

  for(int y = 0; y < foregroundMask.rows; y++) {
    for(int x = 0; x < foregroundMask.cols; x++) {
      val = foregroundMask.at<unsigned char>(y,x);
      if(val == 127) 
        shadowMask.at<unsigned char>(y,x) = 255;
    }
  }

  // invert foregroundMask
  for(int y = 0; y < foregroundMask.rows; y++) {
    for(int x = 0; x < foregroundMask.cols; x++) {
      val = foregroundMask.at<unsigned char>(y,x);
      invertedMask.at<unsigned char>(y,x) = 255 - val;
      if(invertedMask.at<unsigned char>(y,x) == 128) 
        invertedMask.at<unsigned char>(y,x) = 255;
    }
  }

  // distance xform
  Mat dInvertedMask;

  distanceTransform(invertedMask, dInvertedMask, CV_DIST_L2, 3);
  dInvertedMask.convertTo(dInvertedMask, CV_8U); 

  // combine shadowMask & InvertedMask
  Mat dShadowMask = shadowMask & dInvertedMask;

  // prune shadows with high values
  threshold(dShadowMask, dShadowMask, 3, 255, THRESH_BINARY_INV);

  foregroundMask &= dShadowMask;
}
