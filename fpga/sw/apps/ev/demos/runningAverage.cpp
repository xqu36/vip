//#include "opencv2/imgcodecs.hpp"
//#include "opencv2/imgproc.hpp"
//#include <opencv2/highgui.hpp>
//#include <opencv2/video.hpp>
//#include "opencv2/videoio.hpp"
#include "opencv2/imgproc/imgproc.hpp"
//#include "opencv2/videoio/videoio.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/video/video.hpp>

#include <stdio.h>

#include <iostream>
#include <sstream>
#include <string>
using namespace cv;
using namespace std;


int main () {
  cout << "Enter filename: ";
  string videoFilename;
  getline (cin, videoFilename);
  VideoCapture capture(0);
  VideoWriter output;
  //output.open("/home/mia/opencv-3.0.0/cpp/outputVideo.avi", CV_FOURCC('D', 'I', 'V', 'X'), 120, Size(1200, 1600), true);
  if (!capture.isOpened())
    return -1;
  Mat average, frame, average1, outaverage;
  capture >> frame;
  cvtColor(frame, average1, CV_BGR2GRAY);
  average1.convertTo(average1, CV_32F);
  while(1) {
    capture >> frame;
    cvtColor(frame, average, CV_BGR2GRAY);
    accumulateWeighted(average, average1, 0.01);
    average1.convertTo(outaverage, CV_8U);
    imshow("outaverage", outaverage);
    imshow("original", frame);
    output.write( frame);
    if(waitKey(30) >= 0) break;
  }
  return 0;
}

    
  
