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

using namespace cv;
using namespace std;

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

  namedWindow("canny", 1);
  namedWindow("lines", 1);

  int c_sliderVal1 = 50;
  createTrackbar("Canny Low", "canny", &c_sliderVal1, 100);

  int c_sliderVal2 = 50;
  createTrackbar("Canny High", "canny", &c_sliderVal2, 100);

  int l_sliderVal1 = 75;
  createTrackbar("Hough Votes", "lines", &l_sliderVal1, 100);

  int l_sliderVal2 = 50;
  createTrackbar("Min Line Length", "lines", &l_sliderVal2, 100);

  int l_sliderVal3 = 50;
  createTrackbar("Max Gap Step", "lines", &l_sliderVal3, 100);

  /* SPLIT/MERGE */
  Mat rgbSplit[3];
  split(frame, rgbSplit);
  threshold(rgbSplit[0], frame_r, 45, 255, THRESH_TOZERO);
  threshold(frame_r, frame_r, 125, 255, THRESH_TOZERO_INV);
  threshold(rgbSplit[1], frame_g, 55, 255, THRESH_TOZERO);
  threshold(frame_g, frame_g, 115, 255, THRESH_TOZERO_INV);
  threshold(rgbSplit[2], frame_b, 45, 255, THRESH_TOZERO);
  threshold(frame_b, frame_b, 115, 255, THRESH_TOZERO_INV);

  int r = frame_r.rows;
  int c = frame_r.cols;
  for(int i = 0; i < r; i++){
    for(int j = 0; j < c; j++){
      if(frame_r.at<int>(i, j) == 0){
        frame_g.at<int>(i, j) = 0;
        frame_b.at<int>(i, j) = 0;
      }
      else if(frame_g.at<int>(i, j) == 0){
        frame_r.at<int>(i, j) = 0;
        frame_b.at<int>(i, j) = 0;
      }
      else if(frame_b.at<int>(i, j) == 0){
        frame_g.at<int>(i, j) = 0;
        frame_r.at<int>(i, j) = 0;
      }
    }
  }

  rgbSplit[0]=frame_r;
  rgbSplit[1]=frame_g;
  rgbSplit[2]=frame_b;
  merge(rgbSplit, 3, frame);

  /* BLEND IMAGES */
  Mat blended;

  subtract(frame_og, frame, blended);
  
  /* CANNY */
  Mat canny_gray;
  Mat canny, cdst;

  cvtColor(blended, canny_gray, CV_RGB2GRAY);
  GaussianBlur(canny_gray, canny_gray, Size(5,5), 0, 0);
  canny_gray.convertTo(canny_gray, -1, 1.5, 0);
  equalizeHist(canny_gray, canny_gray);

  /* PROCESSING LOOP */
  for(;;) {

    /* CANNY */
    int canny_low = c_sliderVal1 * 5;
    int canny_high = (c_sliderVal2 * 5) + 25;
    Canny(canny_gray, canny, canny_low, canny_high);
    cvtColor(canny, cdst, CV_GRAY2RGB);

    /* HOUGH */
    vector<Vec4i> lines;
    // NON P vector<Vec2f> lines;

    int hough_thresh = l_sliderVal1;
    int minline = l_sliderVal2;
    int maxstep = l_sliderVal3;

    //HoughLines(canny, lines, 1, CV_PI/180, hough_thresh, 0, 0);
    HoughLinesP(canny, lines, 1, CV_PI/180, hough_thresh, minline, maxstep);

    for(size_t i = 0; i < lines.size(); i++) {
      line(cdst, Point(lines[i][0], lines[i][1]), Point(lines[i][2], lines[i][3]), Scalar(0,0,255), 3, CV_AA);
    }

    imshow("canny_gray", canny_gray);
    imshow("canny", canny);
    imshow("lines", cdst);

    if(waitKey(30) == 27) break;
  }

  return 0;
}
