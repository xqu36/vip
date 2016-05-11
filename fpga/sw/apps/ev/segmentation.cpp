/*
 * segmentation.cpp 
 * 
 * Main program with which to experiment with segmentation
 *
 *  ZED-READY --> no references to imshow or anything needed visually
 *
 */

#include "segmentation.hpp"
#include "vidstab.hpp"
#include "utils.hpp"
#include "ccomp.hpp"
#include "pclass.hpp"

using namespace cv;
using namespace std;

int main(int argc, char** argv) {

  /* IN */

  string infile = "";

  if(argc > 1) {
    infile = argv[1];
  } else {
    cout << "Please input video => ./segmentation [.mp4]" << endl;
    exit(0);
  }

  VideoCapture capture(infile);
  VideoStats vstats;

  vstats.setWidth(capture.get(CV_CAP_PROP_FRAME_WIDTH));
  vstats.setHeight(capture.get(CV_CAP_PROP_FRAME_HEIGHT));

  vstats.openLog("segmentation.log");

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    return -1; 
  }

  Mat frame;
  capture >> frame;

  Mat prev_frame;
  prev_frame = frame.clone();

  Mat oframe;
  Mat foregroundMask, backgroundModel;
  Mat foregroundMask_ed3;

  Mat dangerPath;

  bool ped = false, pedInDanger = false;
  //Mat dist;

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

  PathClassifier pclass(vstats.getHeight(), vstats.getWidth());

  int pedCount = 0;
  int carCount = 0;

  int instPedCount, instCarCount;
  int prevPedCount, prevCarCount;

  int result = -1;
  double curr_fps = 20.0;

  // processing loop
  cout << endl;
  for(;;) {

vstats.seekLog(ios::beg);

    /* PRE-PROCESSING */

    vstats.prepareFPS();

vstats.prepareWriteLog();
    // take new current frame
    prev_frame = frame.clone();
    capture >> frame;

    // check if we need to restart the video
    if(frame.empty()) {
vstats.prepareWriteLog();
        // Looks like we've hit the end of our feed! Restart
        capture.set(CV_CAP_PROP_POS_AVI_RATIO, 0.0);
vstats.writeLog("restart source", 1);
        continue;
    }

    // update the danger path
    dangerPath = pclass.carPath & pclass.pedPath;

    //medianBlur(frame, frame, 7);
    frame.copyTo(oframe);
    GaussianBlur(frame, frame, Size(5, 5), 0, 0);

vstats.writeLog("preprocessing", 0);

    /* PROCESSING */

vstats.prepareWriteLog();
    // remove camera jitter 
    if(STABILIZE) frame = estimateMotion(&frame,  &prev_gradient);
vstats.writeLog("stabilize", 0);
    if(RIGID_STABILIZE) {
      Mat M = estimateRigidTransform(prev_frame, frame, 0);
      warpAffine(frame, frame, M, Size(vstats.getWidth(), vstats.getHeight()), INTER_NEAREST|WARP_INVERSE_MAP);
    }
    if(OPENCV_STABILIZE) {}

vstats.prepareWriteLog();
    // update background model
    MOG(frame, foregroundMask, 0.005);
    MOG.getBackgroundImage(backgroundModel);
vstats.writeLog("MoG", 0);

vstats.prepareWriteLog();
    // remove detected shadows
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_TOZERO);

    erode(foregroundMask, foregroundMask_ed3, sE_e, Point(-1, -1), 1);
    dilate(foregroundMask_ed3, foregroundMask_ed3, sE_d, Point(-1, -1), 2);
    erode(foregroundMask_ed3, foregroundMask_ed3, sE_e, Point(-1, -1), 0);
vstats.writeLog("morphological ops", 0);

vstats.prepareWriteLog();
    // find CCs in foregroundMask
    findCC(foregroundMask_ed3, vec_cc);
vstats.writeLog("connected components", 0);

    prevCarCount = instCarCount;
    prevPedCount = instPedCount;

    instPedCount = 0;
    instCarCount = 0;

vstats.prepareWriteLog();

pclass.pstats.seekLog(ios::beg);

    // iterate through the found CCs
    for(int i=0; i<vec_cc.size(); i++) {

//vstats.prepareWriteLog();
      Rect cc_bb = vec_cc[i].getBoundingBox();
      int currentSize = cc_bb.width*cc_bb.height;
      int pedSize = pclass.peddetect.getMinSize().area();
      int reqSize;
      if(!pclass.peddetect.pedSizeValid) reqSize = 400; // hardcoded for resolution/possible env
      else reqSize = pedSize * 0.10;
      if(reqSize < 400) reqSize = 400;

      if(currentSize < reqSize) continue;

      Mat objmask = Mat::zeros(vstats.getHeight(), vstats.getWidth(), CV_8U);
      objmask = vec_cc[i].getMask(objmask.rows, objmask.cols);

      dilate(objmask, objmask, sE_d, Point(-1, -1), 4);
      //erode(objmask, objmask, sE_d, Point(-1, -1), 2);

      //distanceTransform(objmask, dist, CV_DIST_L2, 3);
      //normalize(dist, dist, 0, 255, NORM_MINMAX);
      //threshold(dist, dist, 150, 255, THRESH_TOZERO);
      //dist.convertTo(dist, CV_8U);

      //distanceTransform(dist, dist, CV_DIST_L2, 3);
      //normalize(dist, dist, 0, 255, NORM_MINMAX);
      //dist.convertTo(dist, CV_8U);
//vstats.writeLog("masking", 1);
      int classification = -1;
      //classification = pclass.classify(vec_cc[i], dist, oframe);
//vstats.prepareWriteLog();
      classification = pclass.classify(vec_cc[i], objmask, oframe);
//vstats.writeLog("classify", 1);
      
      ped = false;
      bool draw = pclass.carPathIsValid && pclass.pedPathIsValid;
      Rect r = vec_cc[i].getBoundingBox();
      switch(classification) {
        case TYPE_CAR:
          //if(draw) rectangle(oframe, r, Scalar(0,0,255));
          instCarCount++;
          break;
        case TYPE_CAR_ONPATH:
          //if(draw) rectangle(oframe, r, Scalar(0,0,255), 3);
          instCarCount++;
          break;
        case TYPE_PED:
          //if(draw) rectangle(oframe, r, Scalar(255,0,0));
          instPedCount++;
          break;
        case TYPE_PED_ONPATH:
          //if(draw) rectangle(oframe, r, Scalar(255,0,0), 3);
          instPedCount++;
          ped = true;
          break;
        case TYPE_UNCLASS: 
          //if(draw) rectangle(oframe, r, Scalar(0,255,0));
          break;
        default:
          break;
      }

      //display centroids
      Point centroid = vec_cc[i].getCentroidBox();
      if(ped && dangerPath.at<unsigned char>(centroid) != 0 &&
         pclass.pedPathIsValid && pclass.carPathIsValid){

      	circle(oframe, centroid, 5, Scalar(0,0,255), 4);
      	pedInDanger = true;
      }
      else pedInDanger = false;
    }

char message[25];
sprintf(message, "iterate though ccomp [%d]", (int)vec_cc.size());
vstats.writeLog(message, 0);

    result = -1;
    if(!pclass.pedPathIsValid || !pclass.carPathIsValid) {
      result = 0; // CALIBRATING
      //dangerPath /= 2;
    }
    if(pedInDanger) result = 1;

    vstats.updateAverageFPS();

    //vstats.updateFPS();
    curr_fps = vstats.updateFPS();

    vstats.displayStats("inst", result);
    if(vstats.getUptime() > 3.0) pclass.bgValid = true;

    //if(curr_fps < 8.0) exit(0);
    //if(vstats.getUptime() >= 16) exit(0);

    /* OUT */
    //imshow("frame", oframe);
    //imshow("fg", foregroundMask_ed3);
    //imshow("path", pclass.carPath);
    //imshow("ppath", pclass.pedPath);
    //imshow("dpath", dangerPath);

    if(prevPedCount > instPedCount) pedCount++; 
    if(prevCarCount > instCarCount) carCount++; 

    //cout << "\rPedestrians: " << pedCount << "\tCar Count: " << carCount;

    if(waitKey(10) >= 0) break;
  }

  return 0;
}
