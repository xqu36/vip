/*
 * segmentation.cpp 
 * 
 * Main program with which to experiment with segmentation
 *
 */

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/video/video.hpp>

#include <stdio.h>
#include <iostream>
#include <string>

#include "sample_algorithm.hpp"

using namespace cv;
using namespace std;

int main() {

  /* IN */

  string infile = "/path/to/visual/input";
  VideoCapture capture(infile);

  if (!capture.isOpened()) { cout << "Capture failed to open." << endl; return -1; }

  Mat frame;
  capture >> frame;

  Mat avg_background = frame;

  // processing loop
  for(;;) {

    // take in new current frame from capture
    capture >> frame;

    /* PROCESSING */

    /*
     * YOUR CODE GOES HERE
     * 
     * 1) Extract foreground objects
     * 2) Filter noise and erode/dilate
     * 3) Convert color
     * 4) Segmentation - use various critera (size, speed, shape) to determine
     *                   what each foreground object is, color them appropriately
     */ 

    // create rough background model
    accumulateWeighted(frame, avg_background, 0.01);

    sample_algorithm(frame);

    /* OUT */
    imshow("frame", frame);
    imshow("avg_background", avg_background);

    if(waitKey(30) >= 0) break;
  }
  return 0;
}

    
  
