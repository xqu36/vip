/*
 * crowd_detect.cpp
 * 
 * Main program with which to experiment with crowd counting
 *
 */

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <stdio.h>
#include <iostream>

using namespace std;
using namespace cv;

int main(int argc, char** argv) {

  if(argc < 2) { 
    cout << "Error: argument count invalid." << endl;
    cout << "Usage: ./crowd_detect [input image]" << endl;
    exit(0);
  }

  Mat img = imread(argv[1]);

  /////////////////////////////////
  /* INSERT PROCESSING CODE HERE */
  /////////////////////////////////

  for(;;) {
    imshow("img", img);
    if(waitKey(30) >= 0) break;
  }

  return 0;
}
