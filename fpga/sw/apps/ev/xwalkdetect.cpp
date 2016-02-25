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

#include "sample_algorithm.hpp"


using namespace cv;
using namespace std;

int main() {

  /* IN */

  string infile = "/home/ableemer/vip/fpga/sw/apps/ev/hemphill_low_snapshot.JPG";

  VideoCapture capture(infile);

  Mat frame, frame_r, frame_g, frame_b, avgframe, frame_bw, blur_frame, out_blur_frame, avg_background, out_avg_background, frame_diff, out_frame_diff, bk_frame, out_bk_frame;
  Mat out_frame_r, out_frame_g, out_frame_b, frame_road;
  capture >> frame;
  //frame = imread(infile, 1);

  if (!frame.data) { cout << "No image data." << endl; return -1; }

  //Split frame into red, green and blue images.
  Mat rgbSplit[3];
  split(frame, rgbSplit);
  threshold(rgbSplit[0], frame_r, 50, 255, THRESH_TOZERO);
  threshold(frame_r, frame_r, 120, 255, THRESH_TOZERO_INV);
  threshold(rgbSplit[1], frame_g, 60, 255, THRESH_TOZERO);
  threshold(frame_g, frame_g, 110, 255, THRESH_TOZERO_INV);
  threshold(rgbSplit[2], frame_b, 50, 255, THRESH_TOZERO);
  threshold(frame_b, frame_b, 110, 255, THRESH_TOZERO_INV);

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

  cout << r << " " << c << endl;
  cout << frame_r.rows << " " << frame_r.cols << endl;
  cout << frame_g.rows << " " << frame_g.cols << endl;
  cout << frame_b.rows << " " << frame_b.cols << endl;

  rgbSplit[0]=frame_r;
  rgbSplit[1]=frame_g;
  rgbSplit[2]=frame_b;
  cout << "threshed";

  /* PROCESSING */
    /* Create black and white frame
    cvtColor(frame, frame_bw, CV_BGR2GRAY);
    */

    /* Thresh black and white image, morpho that image, blur black
        and white image, thresh that image to compare the two.
    //accumulateWeighted(frame_bw, avg_background, 0.05); //.05
    //frame_bw.convertTo(frame_bw, CV_32F);
    //absdiff(avg_background, frame_bw, frame_diff);
    threshold(frame_bw, bk_frame, 60, 255, THRESH_BINARY);
    
  //for(int j = 0; j < 10; j++){
    for(int i = 0; i < 10; i++){
          dilate(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
          //erode(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
    }
    for(int i = 0; i < 10; i++){
          //dilate(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
          erode(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
    }
  //}

    for(int i = 1; i < 10; i+=2){
      GaussianBlur(frame_bw, blur_frame, Size(i,i), 0, 0);
    }

    threshold(blur_frame, blur_frame, 60, 255, THRESH_BINARY);

    /*for(int i = 0; i < 10; i++){
          dilate(blur_frame, blur_frame, Mat(), Point(-1,-1), 2,1,1);
          //erode(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
    }
    for(int i = 0; i < 10; i++){
          //dilate(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
          erode(blur_frame, blur_frame, Mat(), Point(-1,-1), 2,1,1);
    }
    */

    //avg_background.convertTo(out_avg_background, CV_8U);
    //frame_diff.convertTo(out_frame_diff, CV_8U);

    /* Convert threshed and blurred frames to saveable/viewable
    bk_frame.convertTo(out_bk_frame, CV_8U);
    blur_frame.convertTo(out_blur_frame, CV_8U);
    */
    frame_r.convertTo(out_frame_r, CV_8U);
    frame_g.convertTo(out_frame_g, CV_8U);
    frame_b.convertTo(out_frame_b, CV_8U);

    merge(rgbSplit, 3, frame_road);

    imwrite("/home/ableemer/vip/fpga/sw/apps/ev/hemphill_low_roadDetect.JPG", frame_road);



    /* Save morpho/threshed image and blurred image
    imwrite("/home/ableemer/vip/fpga/sw/apps/ev/morpho_thresh.JPG", out_bk_frame);
    imwrite("/home/ableemer/vip/fpga/sw/apps/ev/gauss_thresh.JPG", out_blur_frame);
    */
/*
    imshow("frame", frame);
    imshow("frame_r", out_frame_r);
    imshow("frame_g", out_frame_g);
    imshow("frame_b", out_frame_b);
*/
    imshow("frame_road", frame_road);

    /* Show black and white, threshed and blurred frames.
    imshow("frame_bw", frame_bw);
    imshow("threshold", out_bk_frame);
    imshow("Gaussian Blur", out_blur_frame);
    */
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
  //imshow("frame", frame);

  waitKey(0);
  return 0;
}

    
  
