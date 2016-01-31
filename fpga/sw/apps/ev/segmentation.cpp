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
  //VideoCapture capture(infile);
  VideoCapture capture(0);

  if (!capture.isOpened()) { cout << "Capture failed to open." << endl; return -1; }

  Mat frame, avgframe, frame_bw, avg_background, out_avg_background, frame_diff, out_frame_diff, bk_frame, out_bk_frame;
  capture >> frame;

  cvtColor(frame, avg_background, CV_BGR2GRAY);
  avg_background.convertTo(avg_background, CV_32F);

  // processing loop
  for(;;) {

    // take in new current frame from capture
    capture >> frame;

    cvtColor(frame, frame_bw, CV_BGR2GRAY);


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
    accumulateWeighted(frame_bw, avg_background, 0.1); //.01

    frame_bw.convertTo(frame_bw, CV_32F);

    absdiff(avg_background, frame_bw, frame_diff);

    threshold(frame_diff, bk_frame, 50, 255, THRESH_BINARY);



    avg_background.convertTo(out_avg_background, CV_8U);
    
    frame_diff.convertTo(out_frame_diff, CV_8U);

    bk_frame.convertTo(out_bk_frame, CV_8U);


    

    sample_algorithm(frame);

    /* OUT */
    imshow("frame", frame);
    imshow("avg_background01", out_avg_background);
    imshow("avg_background02", out_frame_diff);
    imshow("avg_background02", out_bk_frame);
    
    if(waitKey(30) >= 0) break;
  }
  return 0;
}

    
  
