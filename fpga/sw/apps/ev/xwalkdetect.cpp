/*
 * xwalkdetect.cpp 
 * 
 * Main program with which to detect crosswalks/loiter zones
 *
 */

#include "opencv2/imgproc/imgproc.hpp"
#include <opencv2/highgui/highgui.hpp>

#include <stdio.h>
#include <iostream>
#include <string>

using namespace cv;
using namespace std;

int main() {

  /* IN */

  string infile = "/path/to/visual/input";

  Mat frame;
  frame = imread(infile, 1);

  if (!frame.data) { cout << "No image data." << endl; return -1; }

  /* PROCESSING */

  /*
   * YOUR CODE GOES HERE
   * 
   * 1) Threshold; color or b&w?
   * 2) Can you extract the road?
   * 3) Determine geometry of image (HoughLines)
   * 4) Find areas of high contrast in close proximity (repeating?)
   * 5) Given this info, can you find the crosswalk?
   * 6) With the crosswalk and road identifed, can you extract the loiter zones?
   *
   */ 

  /* OUT */
  imshow("frame", frame);

  waitKey(0);
  return 0;
}

    
  
