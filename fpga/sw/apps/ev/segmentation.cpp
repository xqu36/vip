/*
 * segmentation.cpp 
 * 
 * Main program with which to experiment with segmentation
 *
 *  Current version: v1.1 - 
 *
 *  Major changes from v1.0 include:
 *    implemented queue to process frames at slower pace - threaded
 *    implemented 'enhance' feature, switching to hd frame when necessary
 *    DEBUG mode
 *    more visibility for calibration
 *    blurring (Gaussian, 5x5)
 *    shadow removal (MoG2 binary thresholding)
 *
 */

#include <pthread.h>
#include <unistd.h>
#include "segmentation.hpp"
#include "vidstab.hpp"
#include "utils.hpp"
#include "ccomp.hpp"
#include "pclass.hpp"

using namespace cv;
using namespace std;

/////////////
/* GLOBALS */
/////////////

// only the Queue itself needs to be global
// init size to be 1

// Create frameGrabber pthread
pthread_t fgrabber;

deque<Mat> frameQueue;
int frameQueueSetSize = 1;
bool frameQueueReady = false;
bool pthreadExit = false;

pthread_mutex_t qutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t kutex = PTHREAD_MUTEX_INITIALIZER;

void* frameGrabber(void*) {

  Mat qFrame;

#ifdef DEBUG
  VideoCapture capture("img/spring_high_angle_8.mp4");
#endif

#ifndef DEBUG
  VideoCapture capture(0);
#endif

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    cout << "Thread is exiting: CTRL-C to terminate application." << endl;
    pthread_exit(NULL);
  }

  capture >> qFrame;

  pthread_mutex_lock(&qutex);
  // >>>
  frameQueue.push_back(qFrame);
  frameQueueReady = true;
  // >>>
  pthread_mutex_unlock(&qutex);

  while(!pthreadExit) {

    capture >> qFrame;

#ifdef DEBUG
    if(qFrame.empty()) {
      capture.set(CV_CAP_PROP_POS_AVI_RATIO, 0.0);
      continue;
    }
#endif

    // keep it real-time if necessary
    if(frameQueueSetSize == 1) {

      // while in this mode, keep updating [0] to be real-time frame
      if(frameQueue.size() <= 1) {
        pthread_mutex_lock(&qutex);
        // >>>
        frameQueue.push_back(qFrame);
        frameQueue.pop_front();
        // >>>
        pthread_mutex_unlock(&qutex);
      }
    } else if(frameQueueSetSize != 1) {

      // while in this mode, update frameQ up to specified amount
      if(frameQueue.size() < frameQueueSetSize) {
        pthread_mutex_lock(&qutex);
        // >>>
        frameQueue.push_back(qFrame);
        // >>>
        pthread_mutex_unlock(&qutex);
      } else {

        // else implies the queue is now frameQSetSize large
        // switch desired size back down to 1
        pthread_mutex_lock(&qutex);
        // >>>
        frameQueueSetSize = 1;
        // >>>
        pthread_mutex_unlock(&qutex);
      }
    }
#ifdef DEBUG
    usleep(66000);
#endif
  }
  cout << "Thread is exiting." << endl;
  pthread_exit(NULL);
}

void sig_handler(int s) {
  cout << "\nCaught signal " << s << " -- EXITING SAFELY" << endl;

  pthreadExit = true;

  sleep(10);
  cout << "goodbye" << endl;
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

  // @queue
  int rval;

  rval = pthread_create(&fgrabber, NULL, frameGrabber, 0);
  if(rval) { cout << "Thread's dead, baby. Thread's dead." << endl; exit(0); }

  ////////////////////
  /* INITIALIZATION */
  ////////////////////

  //capture.set(CV_CAP_PROP_FRAME_WIDTH, 320);
  //capture.set(CV_CAP_PROP_FRAME_HEIGHT, 240);

  //assert(capture.get(CV_CAP_PROP_FRAME_WIDTH) == 320);
  //assert(capture.get(CV_CAP_PROP_FRAME_HEIGHT) == 240);

  VideoStats vstats;

  // Set desired final resolution
  vstats.setWidth(320);
  vstats.setHeight(240);

  // set MAX_AREA for pedestrians
  int MAX_AREA = vstats.getHeight()/2 * vstats.getWidth()/2;

  Mat frame, frame_hd;

  // get next frame off of the top of the queue
  do {
    if(frameQueueReady) {
      pthread_mutex_lock(&qutex);
      // >>>
      frameQueue[0].copyTo(frame_hd);
      // >>>
      pthread_mutex_unlock(&qutex);
    }
  } while(frame_hd.empty());

  // csi enhance
  resize(frame_hd, frame, Size(320,240), INTER_NEAREST);

  // define for img stabilization
  Mat prev_frame;
  prev_frame = frame.clone();

  Mat foregroundMask, backgroundModel;

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

  // for img stabilization 
  Mat prev_gradient = frame.clone();
  if(STABILIZE) {
    cvtColor(prev_gradient, prev_gradient, CV_RGB2GRAY);
    prev_gradient.convertTo(prev_gradient, CV_32FC1);
  }

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

    // take new current frame for img stabilization
    prev_frame = frame.clone();

    //@queue
    //capture >> frame_hd;
    pthread_mutex_lock(&qutex);
    // >>>
    frameQueue[0].copyTo(frame_hd);
    // >>>
    pthread_mutex_unlock(&qutex);

    resize(frame_hd, frame, Size(320,240), INTER_NEAREST);

    // update the danger path
    dangerPath = /* pclass.carPath & */ pclass.pedPath;

    GaussianBlur(frame, frame, Size(5,5), 0, 0);
    GaussianBlur(frame_hd, frame_hd, Size(5,5), 0, 0);

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
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_BINARY);

    erode(foregroundMask, foregroundMask, sE_e, Point(-1, -1), 1);
    dilate(foregroundMask, foregroundMask, sE_d, Point(-1, -1), 2);
    erode(foregroundMask, foregroundMask, sE_e, Point(-1, -1), 0);

    // find CCs in foregroundMask
    findCC(foregroundMask, vec_cc);

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
      classification = pclass.classify(vec_cc[i], objmask, frame, frame_hd);
      
      ped = false;
      Rect r = vec_cc[i].getBoundingBox();

      switch(classification) {
        case TYPE_CAR:
          break;
        case TYPE_CAR_ONPATH:
          break;
        case TYPE_PED:
#ifdef DEBUG
          rectangle(frame, r, Scalar(255,255,0), 1);
#endif
          break;
        case TYPE_PED_ONPATH:
#ifdef DEBUG
          rectangle(frame, r, Scalar(255,255,0), 3);
#endif
          ped = true;
          inst_PedCount++;

          // break into capture mode if path is invalid
          if(!pclass.pedPathIsValid && frameQueueSetSize == 1) {

            pthread_mutex_lock(&qutex);
            // >>>
            frameQueueSetSize = 15;
            // >>>
            pthread_mutex_unlock(&qutex);
          }
          break;
        case TYPE_UNCLASS: 
#ifdef DEBUG
          rectangle(frame, r, Scalar(0,255,0), 1);
#endif
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
    if(vstats.getUptime() > 1.0) pclass.bgValid = true;

    if(frameQueue.size() > frameQueueSetSize) {
      pthread_mutex_lock(&qutex);
      // >>>
      frameQueue.pop_front();
      // >>>
      pthread_mutex_unlock(&qutex);
    }

    // update every second
    if(vstats.getMillisecUptime() >= pre_uptime+1000) {

      updatetimer = true;

      prev_sec_PedCount = sec_PedCount;
      sec_PedCount = inst_PedCount;

      if(pclass.pedPathIsValid) {
        if(sec_PedCount < prev_sec_PedCount) totalPed += prev_sec_PedCount - sec_PedCount;
      }

      // output to python script-piped stdout
#ifndef DEBUG
      cout << pclass.getCurrentPedCount() << "/" << pclass.getPedCountCalibration() << 
              "," << sec_PedCount << 
              "," << totalPed << endl;
#endif

#ifdef DEBUG
      cout << "[" << vstats.getWidth() << "x" << vstats.getHeight() << 
              "](" << frame.cols << "x" << frame.rows << ") " <<
              pclass.getCurrentPedCount() << "/" << pclass.getPedCountCalibration() << 
              "," << sec_PedCount << 
              "," << totalPed <<
              "," << pclass.peddetect.getMinSize().area() <<
              "," << pclass.peddetect.getMinSize().area()*.15 <<
              "," << pclass.peddetect.getMinSize() <<
              "," << pclass.peddetect.getMaxSize() << endl;
#endif

      pedPerSec = false;
      prev_PedCount = inst_PedCount =  0;
    }

#ifndef DEBUG
    // recalibrate every 6 hrs
    if(vstats.getUptime() > 21600) {
      pclass.recalibrate = true;
      vstats.resetUptime();
    }
#endif

#ifdef DEBUG
    imshow("frame", frame);
    imshow("fg", foregroundMask);
    imshow("probable path", dangerPath);
    if(waitKey(30) >= 0) break;
#endif

  }
  return 0;
}
