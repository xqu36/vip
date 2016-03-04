/*
 * segmentation.cpp 
 * 
 * Main program with which to experiment with segmentation
 *
 */

#include "segmentation.hpp"
#include "vidstab.hpp"
#include "utils.hpp"
#include "ccomp.hpp"

using namespace cv;
using namespace std;

int main() {

  /* IN */

  VideoCapture capture(INFILE);
  VideoStats vstats;

  vstats.setWidth(capture.get(CV_CAP_PROP_FRAME_WIDTH));
  vstats.setHeight(capture.get(CV_CAP_PROP_FRAME_HEIGHT));

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    return -1; 
  }

  Mat frame;
  capture >> frame;

  Mat prev_frame;
  prev_frame = frame.clone();

  Mat mframe;
  Mat foregroundMask;

  Mat prev_gradient = frame.clone();
  cvtColor(prev_gradient, prev_gradient, CV_RGB2GRAY);
  prev_gradient.convertTo(prev_gradient, CV_32FC1);

  // initialize MoG background subtractor
  BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2();
  MOG.set("detectShadows", DETECTSHADOWS);
  MOG.set("nmixtures", NMIXTURES);

  Mat sE = getStructuringElement(MORPH_ELLIPSE, Size(3, 3));

  // set up vector of ConnectedComponents
  vector<ConnectedComponent> vec_cc;

  // processing loop
  for(;;) {

    /* PRE-PROCESSING */

    // take new current frame
    prev_frame = frame.clone();
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

    //medianBlur(frame, frame, 7);
    GaussianBlur(frame, frame, Size(5, 5), 0, 0);
    //blur(frame, frame, Size(7,7));

    /* PROCESSING */

    // remove camera jitter 
    // TODO: HEAVY FPS HIT
    if(STABILIZE) frame = estimateMotion(&frame,  &prev_gradient);
    if(RIGID_STABILIZE) {
      Mat M = estimateRigidTransform(prev_frame, frame, 0);
      warpAffine(frame, frame, M, Size(vstats.getWidth(), vstats.getHeight()), INTER_NEAREST|WARP_INVERSE_MAP);
    }
    if(OPENCV_STABILIZE) {}

    // update background model
    MOG(frame, foregroundMask);
    frame.copyTo(mframe, foregroundMask);

    // remove detected shadows
    // TODO: There is a more elegant way surely @jdanner3
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_TOZERO);

    //erode and dilate
    erode(foregroundMask, foregroundMask, sE, Point(-1, -1), 1);
    dilate(foregroundMask, foregroundMask, sE, Point(-1, -1), 1);

    // find CCs in foregroundMask
    findCC(foregroundMask, vec_cc);

    // iterate through the found CCs
    for(int i=0; i<vec_cc.size(); i++) {
        int bb_area = vec_cc[i].getBoundingBoxArea(); 
        if(bb_area < MIN_AREA) continue;

        Rect r = vec_cc[i].getBoundingBox();
        rectangle(frame, r, Scalar(255,0,0));

        /*
         * example for Megan
         **/

        Mat objmask = Mat::zeros(vstats.getHeight(), vstats.getWidth(), CV_8U);
        objmask = vec_cc[i].getMask(objmask.rows, objmask.cols);

        /* 
         * Here is where you would add up all the rows/cols to find centroids
         * I would recommend only scanning the rows/cols bounded by the bounding 
         * box. Should shave off a good amount of time
         **/
    }

    vstats.updateFPS();
    vstats.displayStats();

    /* OUT */
    imshow("frame", frame);
    //imshow("foreground", foregroundMask);
    //imshow("foreground", mframe);
    
    if(waitKey(30) >= 0) break;
  }
  return 0;
}
