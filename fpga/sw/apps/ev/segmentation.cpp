/*
 * segmentation.cpp 
 * 
 * Main program with which to experiment with segmentation
 *
 */

#include "segmentation.hpp"
#include "vidstab.hpp"

using namespace cv;
using namespace std;

int main() {

  /* IN */

  VideoCapture capture(INFILE);

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    return -1; 
  }

  Mat frame;
  capture >> frame;

  Mat mframe;
  Mat foregroundMask;

  Mat prev_gradient = frame.clone();
  cvtColor(prev_gradient, prev_gradient, CV_RGB2GRAY);
  prev_gradient.convertTo(prev_gradient, CV_32FC1);

  // initialize MoG background subtractor
  BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2();
  MOG.set("detectShadows", DETECTSHADOWS);
  MOG.set("nmixtures", NMIXTURES);

  Mat sE = getStructuringElement(MORPH_ELLIPSE, Size(5, 5));

  // processing loop
  for(;;) {

    /* PRE-PROCESSING */

    // take new current frame
    capture >> frame;

    // check if we need to restart the video
    if(frame.empty()) {
        // Looks like we've hit the end of our feed! Restart
        cout << "Frame is empty, restarting..." << endl;
        capture.set(CV_CAP_PROP_POS_AVI_RATIO, 0.0);
        cout << "Done!" << endl;
        continue;
    }
    mframe.setTo(Scalar(0,0,0));

    //medianBlur(frame, frame, 3);
    GaussianBlur(frame, frame, Size(9,9), 0, 0);

    /* PROCESSING */

    if(STABILIZE) frame = estimateMotion(&frame,  &prev_gradient);
    MOG(frame, foregroundMask);

    //erode and dilate
    /*
    dilate(foregroundMask, foregroundMask, sE, Point(-1, -1), 1);
    erode(foregroundMask, foregroundMask, sE, Point(-1, -1), 1);
    dilate(foregroundMask, foregroundMask, sE, Point(-1, -1), 1);
    */

    frame.copyTo(mframe, foregroundMask);

    /* OUT */
    imshow("frame", frame);
    imshow("foreground", foregroundMask);
    //imshow("foreground", mframe);
    
    if(waitKey(30) >= 0) break;
  }
  return 0;
}
