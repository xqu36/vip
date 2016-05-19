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

  string infile = "";

  if(argc > 1) {
    infile = argv[1];
  } else {
    cout << "Please input video => ./segmentation [.mp4]" << endl;
    exit(0);
  }

  VideoCapture capture(infile);
  //VideoCapture capture(1);
  VideoStats vstats;

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    return -1; 
  }

  capture.set(CV_CAP_PROP_FRAME_WIDTH, 320);
  capture.set(CV_CAP_PROP_FRAME_HEIGHT, 240);

  assert(capture.get(CV_CAP_PROP_FRAME_WIDTH) == 320);
  assert(capture.get(CV_CAP_PROP_FRAME_HEIGHT) == 240);

  ////////////////////
  /* INITIALIZATION */
  ////////////////////

  vstats.setWidth(capture.get(CV_CAP_PROP_FRAME_WIDTH));
  vstats.setHeight(capture.get(CV_CAP_PROP_FRAME_HEIGHT));

  int loop_count = 0;

  // set MAX_AREA for pedestrians
  int MAX_AREA = vstats.getHeight()/2 * vstats.getWidth()/2;

  vstats.openLog("segmentation.log");

  Mat frame;
  capture >> frame;

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
  int result = 0;  // calibrating [0], no ped [-1], ped [+1]

  Mat prev_gradient = frame.clone();
  cvtColor(prev_gradient, prev_gradient, CV_RGB2GRAY);
  prev_gradient.convertTo(prev_gradient, CV_32FC1);

  // initialize MoG background subtractor
  BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2(1000, 64, true);
  MOG.set("detectShadows", 1);
  MOG.set("nmixtures", NMIXTURES);
  MOG.set("fTau", 0.65);

  Mat sE_e = getStructuringElement(MORPH_ELLIPSE, Size(3, 3));
  Mat sE_d = getStructuringElement(MORPH_ELLIPSE, Size(5, 5));

  // set up vector of ConnectedComponents
  vector<ConnectedComponent> vec_cc;

  PathClassifier pclass(vstats.getHeight(), vstats.getWidth());


  // processing loop
  cout << endl;
  for(;;) {

vstats.seekLog(ios::beg);

    ////////////////////
    /* PRE-PROCESSING */
    ////////////////////

    vstats.prepareFPS();
    pre_uptime = vstats.getUptime();

vstats.prepareWriteLog();
    // take new current frame
    prev_frame = frame.clone();
    capture >> frame;

    int curr_frameIndex = capture.get(CV_CAP_PROP_POS_FRAMES);

    // check if we need to restart the video
    if(frame.empty()) {
        // Looks like we've hit the end of our feed! Restart
        capture.set(CV_CAP_PROP_POS_FRAMES, 0.0);
        if(result != 0) loop_count++;
        totalPed = 0;
        continue;
    }

    // update the danger path
    dangerPath = /* pclass.carPath & */ pclass.pedPath;

    frame.copyTo(oframe);
    GaussianBlur(frame, frame, Size(5, 5), 0, 0);

vstats.writeLog("preprocessing", 0);

    ////////////////
    /* PROCESSING */
    ////////////////

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
    // TODO: optimizations?
    if(!pclass.pedPathIsValid || 1) {
      // update background model
      MOG(frame, foregroundMask, 0.005);
      MOG.getBackgroundImage(backgroundModel);
    } else {
      absdiff(frame, backgroundModel, foregroundMask_color);
      cvtColor(foregroundMask_color, foregroundMask, CV_RGB2GRAY);
    }// locked into same backgroundModel
vstats.writeLog("MoG", 0);

vstats.prepareWriteLog();
    // remove detected shadows
    //threshold(foregroundMask, foregroundMask, 15, 255, THRESH_BINARY);
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_BINARY);

    erode(foregroundMask, foregroundMask_ed3, sE_e, Point(-1, -1), 1);
    dilate(foregroundMask_ed3, foregroundMask_ed3, sE_d, Point(-1, -1), 2);
vstats.writeLog("morphological ops", 0);

vstats.prepareWriteLog();
    // find CCs in foregroundMask
    findCC(foregroundMask_ed3, vec_cc);
vstats.writeLog("connected components", 0);

/* CLEAR PCLASS LOG */
vstats.prepareWriteLog();

pclass.pstats.seekLog(ios::beg);
for(int i=0; i<25; i++) pclass.pstats.writeLog(" - ",0);
pclass.pstats.seekLog(ios::beg);

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
      dilate(objmask, objmask, sE_d, Point(-1, -1), 4);

      int classification = -1;
      classification = pclass.classify(vec_cc[i], objmask, oframe);
      
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
          //rectangle(oframe, r, Scalar(255,0,0), 3);
          ped = true;
          inst_PedCount++;
          break;
        case TYPE_UNCLASS: 
          break;
        default:
          break;
      }

      //display centroids
      Point centroid = vec_cc[i].getCentroidBox();
      if(ped && dangerPath.at<unsigned char>(centroid) != 0 &&
         pclass.pedPathIsValid /* && pclass.carPathIsValid */){
      	pedInDanger = true;
      } else pedInDanger = false;
    }

char message[25];
sprintf(message, "iterate though ccomp [%d]", (int)vec_cc.size());
vstats.writeLog(message, 0);

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
    if(vstats.getUptime() > 3.0) pclass.bgValid = true;

    imshow("frame", oframe);
    imshow("sec_frame", sec_frame);
    //imshow("fg", foregroundMask_ed3);
    imshow("dpath", dangerPath);
    //imshow("bg", backgroundModel);

    if(waitKey(35) >= 0) break;

    if(vstats.getUptime() >= pre_uptime+1) {
      //cout << "\tTime:\t" << vstats.getUptime() << " - [" << pedPerSec << "]" << endl;
      frame.copyTo(sec_frame);
      cvtColor(sec_frame, sec_frame, CV_RGB2GRAY);
      prev_sec_PedCount = sec_PedCount;
      sec_PedCount = inst_PedCount;

      if(sec_PedCount < prev_sec_PedCount) totalPed += prev_sec_PedCount - sec_PedCount;

      if(pedPerSec) {
        oframe.copyTo(sec_frame);
      }
      if(result != 0) cout << "{" << result << "} Time:\t" << vstats.getUptime() << " - [" << sec_PedCount << "][" << totalPed << "]" << endl;
      pedPerSec = false;
      prev_PedCount = inst_PedCount =  0;
    }

    if(loop_count >= 3) { cout << "Exiting..." << endl; break; }

    int num_frames = capture.get(CV_CAP_PROP_FRAME_COUNT);
    int iter = curr_frameIndex+0;

    if(iter < num_frames) capture.set(CV_CAP_PROP_POS_FRAMES, iter);

  }

  return 0;
}
