/*
 * segmentation.cpp 
 * 
 * Main program with which to experiment with segmentation
 *
 *  ZED-READY --> no references to imshow or anything needed visually
 *
 */

#include <unistd.h>
#include "segmentation.hpp"
#include "vidstab.hpp"
#include "utils.hpp"
#include "ccomp.hpp"
#include "pclass.hpp"

using namespace cv;
using namespace std;

void sig_handler(int s) {
  cout << "\nCaught signal " << s << " -- EXITING SAFELY" << endl;
  exit(0);
}

int main(int argc, char** argv) {

  /////////////////
  /* EXIT SAFELY */
  /////////////////

  struct sigaction sigIntHandler;

  sigIntHandler.sa_handler = sig_handler;
  sigemptyset(&sigIntHandler.sa_mask);
  sigIntHandler.sa_flags = 0;

  sigaction(SIGINT, &sigIntHandler, NULL);

  ////////
  /* IN */
  ////////

  //VideoCapture capture("img/illegal_seagull.mp4");
  VideoCapture capture(0);
  VideoStats vstats;

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    return -1; 
  }

  //capture.set(CV_CAP_PROP_FRAME_WIDTH, 320);
  //capture.set(CV_CAP_PROP_FRAME_HEIGHT, 240);

  //assert(capture.get(CV_CAP_PROP_FRAME_WIDTH) == 320);
  //assert(capture.get(CV_CAP_PROP_FRAME_HEIGHT) == 240);

  ////////////////////
  /* INITIALIZATION */
  ////////////////////

  // @csi_enhance
  //vstats.setWidth(capture.get(CV_CAP_PROP_FRAME_WIDTH));
  //vstats.setHeight(capture.get(CV_CAP_PROP_FRAME_HEIGHT));
  vstats.setWidth(320);
  vstats.setHeight(240);

  int loop_count = 0;

  // set MAX_AREA for pedestrians
  int MAX_AREA = vstats.getHeight()/2 * vstats.getWidth()/2;

  Mat frame, frame_hd;
  capture >> frame_hd;
  // @csi_enhance
  resize(frame_hd, frame, Size(320,240));

  Mat prev_frame;
  prev_frame = frame.clone();

  Mat oframe, sec_frame;
  capture >> sec_frame;

  Mat foregroundMask, backgroundModel;
  Mat foregroundMask_color;
  Mat foregroundMask_ed3;

  Mat dangerPath;

  bool ped = false, pedInDanger = false;
  bool pedPerSec = false; // updated once a second
  int inst_PedCount = 0;
  int prev_PedCount = inst_PedCount;
  int sec_PedCount, prev_sec_PedCount = 0;
  int totalPed = 0;

  int curr_fps = INT_MAX;
  double pre_uptime = 0.0;
  bool updatetimer = true;
  int result = 0;  // calibrating [0], no ped [-1], ped [+1]

  Mat prev_gradient = frame.clone();
  cvtColor(prev_gradient, prev_gradient, CV_RGB2GRAY);
  prev_gradient.convertTo(prev_gradient, CV_32FC1);

  // initialize MoG background subtractor
  BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2();
  MOG.set("detectShadows", DETECTSHADOWS);
  MOG.set("nmixtures", NMIXTURES);
  MOG.set("fTau", 0.65);

  Mat sE_e = getStructuringElement(MORPH_ELLIPSE, Size(3, 3));
  Mat sE_d = getStructuringElement(MORPH_ELLIPSE, Size(5, 5));

  // set up vector of ConnectedComponents
  vector<ConnectedComponent> vec_cc;

  PathClassifier pclass(vstats.getHeight(), vstats.getWidth());

  // processing loop
  for(;;) {

    ////////////////////
    /* PRE-PROCESSING */
    ////////////////////

    vstats.prepareFPS();
    if(updatetimer){
      pre_uptime = vstats.getMillisecUptime();
      updatetimer = !updatetimer;
    }

    // take new current frame
    prev_frame = frame.clone();
    capture >> frame_hd;

#ifndef RELEASE
    //if(frame.empty()) {
    if(frame_hd.empty()) {
      capture.set(CV_CAP_PROP_POS_AVI_RATIO, 0.0);
      continue;
    }
#endif

    resize(frame_hd, frame, Size(320,240));

    // update the danger path
    dangerPath = /* pclass.carPath & */ pclass.pedPath;

    //frame.copyTo(oframe);
    GaussianBlur(frame, frame, Size(11,11), 0, 0);
    GaussianBlur(frame_hd, frame_hd, Size(7,7), 0, 0);
    frame.copyTo(oframe);

    ////////////////
    /* PROCESSING */
    ////////////////

    // remove camera jitter 
    if(STABILIZE) frame = estimateMotion(&frame,  &prev_gradient);
    if(RIGID_STABILIZE) {
      Mat M = estimateRigidTransform(prev_frame, frame, 0);
      warpAffine(frame, frame, M, Size(vstats.getWidth(), vstats.getHeight()), INTER_NEAREST|WARP_INVERSE_MAP);
    }
    if(OPENCV_STABILIZE) {}

    // TODO: optimizations?
    // update background model
    MOG(frame, foregroundMask);
    MOG.getBackgroundImage(backgroundModel);

    // remove detected shadows
    //threshold(foregroundMask, foregroundMask, 0, 255, THRESH_BINARY);
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_BINARY);

    erode(foregroundMask, foregroundMask_ed3, sE_e, Point(-1, -1), 1);
    dilate(foregroundMask_ed3, foregroundMask_ed3, sE_d, Point(-1, -1), 2);
    erode(foregroundMask_ed3, foregroundMask_ed3, sE_e, Point(-1, -1), 0);

    // find CCs in foregroundMask
    findCC(foregroundMask_ed3, vec_cc);

    prev_PedCount = inst_PedCount;
    inst_PedCount = 0;
    // iterate through the found CCs
    for(int i=0; i<vec_cc.size(); i++) {

      Rect cc_bb = vec_cc[i].getBoundingBox();
      int currentSize = cc_bb.width*cc_bb.height;
      int pedSize = pclass.peddetect.getMinSize().area();
      int reqSize;
      if(!pclass.peddetect.pedSizeValid) reqSize = 100; // hardcoded for resolution/possible env
      else reqSize = pedSize * 0.15;
      if(reqSize < 100) reqSize = 100;

      if(currentSize < reqSize) continue;
      if(currentSize > MAX_AREA) continue;  // can't be bigger than half the screen

      Mat objmask = Mat::zeros(vstats.getHeight(), vstats.getWidth(), CV_8U);
      objmask = vec_cc[i].getMask(objmask.rows, objmask.cols);

      // FIXME - four times too much?
      //dilate(objmask, objmask, sE_d, Point(-1, -1), 2);

      int classification = -1;
      classification = pclass.classify(vec_cc[i], objmask, oframe, frame_hd);
      
      ped = false;
      bool draw = /* pclass.carPathIsValid && */ pclass.pedPathIsValid;
      Rect r = vec_cc[i].getBoundingBox();
      switch(classification) {
        case TYPE_CAR:
          break;
        case TYPE_CAR_ONPATH:
          break;
        case TYPE_PED:
          //rectangle(oframe, r, Scalar(255,0,0), 1);
          break;
        case TYPE_PED_ONPATH:
          rectangle(oframe, r, Scalar(255,0,0), 3);
          ped = true;
          inst_PedCount++;
          break;
        case TYPE_UNCLASS: 
          //rectangle(oframe, r, Scalar(0,255,0), 1);
          break;
        default:
          ped = false;
          break;
      }

      //display centroids
      Point centroid = vec_cc[i].getCentroidBox();

      if(ped && dangerPath.at<unsigned char>(centroid) != 0 &&
         pclass.pedPathIsValid /* && pclass.carPathIsValid */){
      	pedInDanger = true;
      } else pedInDanger = false;
    }

    /////////
    /* OUT */
    /////////

    result = -1;
    if(!pclass.pedPathIsValid /* || !pclass.carPathIsValid */) {
      result = 0; // CALIBRATING
    }
    if(pedInDanger) result = 1;

    vstats.updateAverageFPS();

    curr_fps = vstats.updateFPS();

    if(ped) pedPerSec = true;
    inst_PedCount = MAX(prev_PedCount,inst_PedCount);

    vstats.displayStats("inst", result);
    if(vstats.getUptime() > 4.0) pclass.bgValid = true;

    // update every quarter second
    if(vstats.getMillisecUptime() >= pre_uptime+1000) {

      updatetimer = true;

#ifndef RELEASE 
      frame.copyTo(sec_frame);
      cvtColor(sec_frame, sec_frame, CV_RGB2GRAY);
#endif

      prev_sec_PedCount = sec_PedCount;
      sec_PedCount = inst_PedCount;

      if(pclass.pedPathIsValid) {
        if(sec_PedCount < prev_sec_PedCount) totalPed += prev_sec_PedCount - sec_PedCount;
      }

#ifndef RELEASE
      if(pedPerSec) {
        oframe.copyTo(sec_frame);
      }
#endif

      // output to python script-piped stdout
#ifdef RELEASE
      cout << result*result << "," << sec_PedCount << "," << totalPed << endl;
#endif

#ifndef RELEASE
      cout << "[" << vstats.getWidth() << "x" << vstats.getHeight() << 
              "](" << frame.cols << "x" << frame.rows << ") " <<
              pclass.getCurrentPedCount() << "/" << pclass.getPedCountCalibration() << 
              "," << sec_PedCount << 
              "," << totalPed << endl;
              //"," << pclass.peddetect.getMinSize().area() <<
              //"," << pclass.peddetect.getMinSize().area()*.15 << endl;
#endif

      pedPerSec = false;
      prev_PedCount = inst_PedCount =  0;
    }

#ifdef RELEASE
    // recalibrate every 6 hrs
    if(vstats.getUptime() > 21600) {
      pclass.recalibrate = true;
      vstats.resetUptime();
    }
#endif

#ifndef RELEASE
    //imshow("frame", oframe);
    //imshow("fg", foregroundMask_ed3);
    //imshow("probable path", dangerPath);
    //if(waitKey(30) >= 0) break;
#endif

  }
  return 0;
}
