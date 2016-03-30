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
  Mat foregroundMask, backgroundModel;
  Mat foregroundMask_ed1, foregroundMask_ed2, foregroundMask_ed3;
  Mat dist;

  Mat prev_gradient = frame.clone();
  cvtColor(prev_gradient, prev_gradient, CV_RGB2GRAY);
  prev_gradient.convertTo(prev_gradient, CV_32FC1);

  // initialize MoG background subtractor
  BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2(1000, 64, true);
  //BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2();
  MOG.set("detectShadows", 1);
  MOG.set("nmixtures", NMIXTURES);
  MOG.set("fTau", 0.65);

  Mat sE_e = getStructuringElement(MORPH_ELLIPSE, Size(3, 3));
  Mat sE_d = getStructuringElement(MORPH_ELLIPSE, Size(5, 5));

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
    MOG(frame, foregroundMask, 0.005);
    MOG.getBackgroundImage(backgroundModel);
    frame.copyTo(mframe, foregroundMask);

    Mat shadowMask = Mat::zeros(frame.rows, frame.cols, CV_8U);

	  //chr.removeShadows(frame, foregroundMask, backgroundModel, chrMask, shadowMask);
	  //lrTex.removeShadows(frame, foregroundMask, backgroundModel, lrTexMask);

    // remove detected shadows
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_TOZERO);
    //threshold(chrMask, chrMask, 128, 255, THRESH_TOZERO);
    //threshold(lrTexMask, lrTexMask, 128, 255, THRESH_TOZERO);
/*
    erode(lrTexMask, lrTexMask, sE, Point(-1, -1), 1);
    dilate(lrTexMask, lrTexMask, sE, Point(-1, -1), 3);
    erode(lrTexMask, lrTexMask, sE, Point(-1, -1), 2);
*/
    //erode and dilate
    distanceTransform(foregroundMask, dist, CV_DIST_L1, 3);
    threshold(dist, dist, 1, 255, THRESH_BINARY);
    dist.convertTo(dist, CV_8U);

    erode(dist, foregroundMask_ed3, sE_e, Point(-1, -1), 0);
    dilate(foregroundMask_ed3, foregroundMask_ed3, sE_d, Point(-1, -1), 2);
    erode(foregroundMask_ed3, foregroundMask_ed3, sE_e, Point(-1, -1), 0);

    // find CCs in foregroundMask
    findCC(foregroundMask_ed3, vec_cc);
    //findCC(foregroundMask, vec_cc);
    //findCC(lrTexMask, vec_cc);

    // iterate through the found CCs
    for(int i=0; i<vec_cc.size(); i++) {
        int bb_area = vec_cc[i].getBoundingBoxArea(); 
        int cc_pix = vec_cc[i].getPixelCount();
        if(cc_pix < 200) continue;
        //if(bb_area < MIN_AREA) continue;

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
    //imshow("lrTexMask", lrTexMask);
    //imshow("chrMask", chrMask);
    imshow("foreground_ed3", foregroundMask_ed3);
    //imshow("distance", dist);
    //imshow("foreground", mframe);
    
    if(waitKey(30) >= 0) break;
  }
  return 0;
}
