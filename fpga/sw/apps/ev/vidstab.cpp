/*
 * vidstab.cpp
 * 
 * Provides simple phase difference based motion compensation
 *
 */

#include "vidstab.hpp"

using namespace cv;
using namespace std;

Point2d phase_diff = Point2d(0);

// returns frame offset for compensation
Mat estimateMotion(Mat* frame, Mat* prev_gradient) {

  Mat gradX, gradY;
  Mat frame_bw;

  int scale = 1;
  int delta = 0;
  int ddepth = CV_16S;

  // cvt to grayscale
  cvtColor(*frame, frame_bw, CV_RGB2GRAY);

  Mat comp_frame = (*frame).clone();

  // Sobel operators - X & Y
  Sobel(frame_bw, gradX, ddepth, 1, 0, 3, scale, delta, BORDER_DEFAULT);
  Sobel(frame_bw, gradY, ddepth, 0, 1, 3, scale, delta, BORDER_DEFAULT);

  // THRESHOLD NOISE
  convertScaleAbs(gradX, gradX);
  convertScaleAbs(gradY, gradY);

  threshold(gradX, gradX, THRESH_NOISE, 255, THRESH_TOZERO);
  threshold(gradY, gradY, THRESH_NOISE, 255, THRESH_TOZERO);

  Mat gradient;
  addWeighted(gradX, 0.5, gradY, 0.5, 0, gradient);
  gradient.convertTo(gradient, CV_32FC1);

  Point2d _phase_diff = Point2d(0);
  _phase_diff = phaseCorrelate(gradient, *prev_gradient);
      
  // motion smoothing defined in percents. Divide by 100
  phase_diff = phase_diff * ((float)(100 - MOTIONSMOOTHING)/100); 
  phase_diff += _phase_diff;

  gradient.copyTo(*prev_gradient);
      
  Mat warp_mat = ( Mat_<double>(2, 3) << 1, 0, phase_diff.x, 0, 1, phase_diff.y);
  warpAffine(comp_frame, comp_frame, warp_mat, Size(frame->cols, frame->rows));

  return comp_frame;
}
