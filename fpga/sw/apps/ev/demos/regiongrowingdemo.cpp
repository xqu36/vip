/*
 * xwalkdetect.cpp 
 * 
 * Main program with which to detect crosswalks/loiter zones
 *
 */

#include "opencv2/imgproc/imgproc.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/video/video.hpp>

#include <stdio.h>
#include <iostream>
#include <string>
#include <vector>

#include "RegionGrowing.hpp"

using namespace cv;
using namespace std;

struct pixel {
  int x = 0;
  int y = 0;
  bool sel = false;
};

struct pixel spixel;

void CallBackFunc(int event, int x, int y, int flags, void* userdata) {
  if(event == EVENT_LBUTTONDOWN) {
    spixel.x = x;
    spixel.y = y;
    spixel.sel = true;
  }
}

int main(int argc, char* argv[]) {

  /* IN */
  if(argc != 2) {
    cout << "Invalid number of arguments." << endl;
    exit(0);
  }
  string infile = argv[1];
  VideoCapture capture(infile);

  Mat frame, frame_r, frame_g, frame_b;

  capture >> frame;
  if (!frame.data) { cout << "No image data." << endl; return -1; }

  /* INIT */
  Mat frame_og = frame.clone();
  Mat rg;
  seed_fill_stack fill;

  namedWindow("sel", 1);
  namedWindow("rg", 1);

  /* REGION GROWING */
  while(spixel.sel == false) {
    setMouseCallback("sel", CallBackFunc, NULL);

    imshow("sel", frame_og);
    waitKey(1);
  }

  rg = fill.RegionGrowing(frame_og, spixel.x, spixel.y, Scalar(0,0,255));

  /* PROCESSING LOOP */
  for(;;) {

    imshow("rg", rg);
    if(waitKey(30) == 27) break;
  }

  return 0;
}
