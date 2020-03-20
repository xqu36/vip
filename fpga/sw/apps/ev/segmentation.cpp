/*
 * segmentation.cpp 
 *
 *  Current version: v1.1 - 
 *
 */

#include <pthread.h>
#include <unistd.h>
#include "segmentation.hpp"
#include "vidstab.hpp"
#include "utils.hpp"
#include "ccomp.hpp"
#include "pclass.hpp"
#include "kalman.hpp"
#include <cstdio>
#ifdef LOGGING
#include <ctime>
#endif

using namespace cv;
using namespace std;

/////////////
/* GLOBALS */
/////////////

// only the Queue itself needs to be global
// init size to be 1

deque<Mat> frameQueue;
int frameQueueSetSize = 1;
bool frameQueueReady = false;
bool pthreadExit = false;
bool writeCalib = false;

pthread_mutex_t qutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t kutex = PTHREAD_MUTEX_INITIALIZER;

// grabs frames from the capture object and places them in global queue
void* frameGrabber(void*) {

#ifdef LOGGING
  clock_t begin = clock();
  double elapsed_time;
#endif

  Mat qFrame;

#ifdef DEBUG
  VideoCapture capture("img/spring_high_angle_5.mp4");
#endif
#ifndef DEBUG
  VideoCapture capture(0);
#endif

  if (!capture.isOpened()) { 
    cout << "Capture failed to open." << endl; 
    //cout << "Thread is exiting: CTRL-C to terminate application." << endl;
    pthread_exit(NULL);
  }

  capture >> qFrame;

#ifdef LOGGING
      clock_t begin_pop = clock();
#endif

  pthread_mutex_lock(&qutex);
  // >>>
  frameQueue.push_back(qFrame);
  frameQueueReady = true;
  // >>>
  pthread_mutex_unlock(&qutex);

#ifdef LOGGING
  clock_t end = clock();
  freopen("log.txt", "a", stderr);
  elapsed_time = double(end - begin_pop);
  cerr << "Frame pop time:" << elapsed_time << endl;
  fclose(stderr);
#endif

  while(!pthreadExit) {

#ifdef LOGGING
    begin = clock();
#endif

    capture >> qFrame;

    if(qFrame.empty()) {
      capture.set(CV_CAP_PROP_POS_AVI_RATIO, 0.0);
      continue;
    }
#ifdef DEBUG
#endif

    // keep it real-time if necessary
    if(frameQueueSetSize == 1) {

      // while in this mode, keep updating [0] to be real-time frame
      if(frameQueue.size() <= 1) {

#ifdef LOGGING
        begin_pop = clock();
#endif

        pthread_mutex_lock(&qutex);
        // >>>
        frameQueue.push_back(qFrame);
        frameQueue.pop_front(); // new
        //frameQueueReady = true;
        // >>>
        pthread_mutex_unlock(&qutex);

#ifdef LOGGING
        end = clock();
        elapsed_time = double(end - begin_pop);
        freopen("log.txt", "a", stderr);
        cerr << "Frame pop time:" << elapsed_time << endl;
        fclose(stderr);
#endif

      }
    } else if(frameQueueSetSize != 1) {

      // while in this mode, update frameQ up to specified amount
      if(frameQueue.size() < frameQueueSetSize) {

#ifdef LOGGING
        begin_pop = clock();
#endif

        pthread_mutex_lock(&qutex);
        // >>>
        frameQueue.push_back(qFrame);
        //frameQueueReady = true;
        // >>>
        pthread_mutex_unlock(&qutex);

#ifdef LOGGING
        end = clock();
        elapsed_time = double(end - begin_pop);
        freopen("log.txt", "a", stderr);
        cerr << "Frame pop time:" << elapsed_time << endl;
        fclose(stderr);
#endif

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

#ifdef LOGGING
    end = clock();
    elapsed_time = double(end - begin);
    freopen("log.txt", "a", stderr);
    cerr<< "Frame grabber function time:" << elapsed_time << endl;
    fclose(stderr);
#endif

#ifdef DEBUG
    usleep(66000);
#endif

  }
  cout << "Thread is exiting." << endl;
  pthread_exit(NULL);
}
 
// TODO: Future Deployment
// // Classes needed for the Kalman Tracking
// class Tracker{
// public:
// 	KalmanFilter KF;
// 	Mat_<float> measurement;
// 	Point predicted;
// 	int assigned;
// 	int size;
// };

// class Detected{
// public:
// 	Point p;
// 	int x_vel;
// 	int y_vel;
// 	int assigned;
// 	int size;
// };

// Tracker createKalman(){
// 	KalmanFilter KF (4,2,0);
// 	Mat_<float> measurement(2,1);

// 	Tracker new_tracker;
// 	new_tracker.KF = KF;
// 	new_tracker.measurement = measurement;

// 	return new_tracker;
// }

// std::vector<Tracker> tracker_arr;
// std::vector<Detected> detected_arr;


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

  // Create frameGrabber pthread
  pthread_t fgrabber;

  // @queue
  int rval;

  rval = pthread_create(&fgrabber, NULL, frameGrabber, 0);
  if(rval) { cout << "Thread's dead, baby. Thread's dead. (Thread cannot be created)" << endl; exit(0); }

  ////////////////////
  /* INITIALIZATION */
  ////////////////////

  clock_t init_begin = clock();

  VideoStats vstats;

  // Set desired final resolution
  vstats.setWidth(320);
  vstats.setHeight(240);

  // set MAX_AREA for pedestrians
  //int MAX_AREA = vstats.getHeight()/2 * vstats.getWidth()/2;
  int MAX_AREA = ( vstats.getHeight()*vstats.getWidth() )/2;

  Mat frame, frame_hd;
#ifdef LOGGING
  clock_t pop_begin;
  clock_t pop_end;
  double elapsed_time;
#endif
  // get next frame off of the top of the queue
  do {
#ifdef LOGGING
    pop_begin = clock();
#endif
    if(frameQueueReady) {
      pthread_mutex_lock(&qutex);
      // >>>
      frameQueue[0].copyTo(frame_hd);
      // >>>
      pthread_mutex_unlock(&qutex);
#ifdef LOGGING
      pop_end = clock();
      elapsed_time = double(pop_end - pop_begin);
      freopen("log.txt", "a", stderr);
      cerr << "Frame pop time:" << elapsed_time << endl;
      fclose(stderr);
#endif
    }
  } while(frame_hd.empty());

  // csi enhance
#ifdef LOGGING
  clock_t resizing = clock(); 
#endif
  resize(frame_hd, frame, Size(320,240), INTER_NEAREST);
#ifdef LOGGING
  clock_t end_resizing = clock();
  elapsed_time = double(end_resizing - resizing);
  freopen("log.txt", "a", stderr);
  cerr << "CSI Resizing time:" << elapsed_time << endl;
  fclose(stderr);
#endif

  Mat foregroundMask, backgroundModel;

  Mat dangerPath;

  bool ped = false, pedInDanger = false;
  bool pedPerSec = false; // updated once a second
  int inst_PedCount = 0;
  int prev_PedCount = inst_PedCount;
  int sec_PedCount, prev_sec_PedCount = 0;
  int totalPed = 0;
  int kalmanPeds = 0;

  int curr_fps = INT_MAX;
  double pre_uptime = 0.0;
  bool updatetimer = true;
  int result = 0;  // calibrating [0], no ped [-1], ped [+1]
  bool isUptimeSCSet = false; // Uptime(S)ince(C)alibration
  int uptimeSC_offset = 0;  // simply determine an offset, and calculate when needed
  int sinceLastWrite = 0;

  // initialize MoG background subtractor
#ifdef LOGGING
  clock_t MoG_begin = clock();
#endif
  BackgroundSubtractorMOG2 MOG = BackgroundSubtractorMOG2();
  MOG.set("detectShadows", DETECTSHADOWS);
  MOG.set("nmixtures", NMIXTURES);
  MOG.set("fTau", 0.65);

  Mat sE_e = getStructuringElement(MORPH_ELLIPSE, Size(3, 3));
  Mat sE_d = getStructuringElement(MORPH_ELLIPSE, Size(5, 5));

#ifdef LOGGING
  clock_t end = clock();
  elapsed_time = double(end - MoG_begin);
  freopen("log.txt", "a", stderr);
  cerr << "MoG initialization time:" << elapsed_time << endl;
  fclose(stderr);
#endif

  // set up vector of ConnectedComponents
  vector<ConnectedComponent> vec_cc;

  PathClassifier pclass(vstats.getHeight(), vstats.getWidth());

  // processing loop

  // TODO: Future deployment
  //std::vector<Tracker> tracker_arr;

  for(;;) {

    ////////////////////
    /* PRE-PROCESSING */
    ////////////////////

    vstats.prepareFPS();
    if(updatetimer){
      pre_uptime = vstats.getMillisecUptime();
      updatetimer = !updatetimer;
    }

    //@queue
    //capture >> frame_hd;
    pthread_mutex_lock(&qutex);
    // >>>
    frameQueue[0].copyTo(frame_hd);
    // >>>
    pthread_mutex_unlock(&qutex);

    resize(frame_hd, frame, Size(320,240), INTER_NEAREST);

    // update the danger path
    //dangerPath = /* pclass.carPath & */ pclass.pedPath;
    dangerPath = /* pclass.carPath & */ pclass.getPath(0);

#ifdef LOGGING
    clock_t begin_gaussian = clock();
#endif
    GaussianBlur(frame, frame, Size(5,5), 0, 0);
    GaussianBlur(frame_hd, frame_hd, Size(5,5), 0, 0);
#ifdef LOGGING
    clock_t end_gaussian = clock();
    elapsed_time = double(end_gaussian - begin_gaussian);
    freopen("log.txt", "a", stderr);
    cerr << "Gaussian Blur time:" << elapsed_time << endl;
    fclose(stderr);
#endif
    ////////////////
    /* PROCESSING */
    ////////////////

    // TODO: optimizations?
    // update background model
    MOG(frame, foregroundMask);
    MOG.getBackgroundImage(backgroundModel);

    // remove detected shadows
    threshold(foregroundMask, foregroundMask, 128, 255, THRESH_BINARY);
    #ifdef LOGGING
    clock_t begin_morphological = clock();
    #endif
    erode(foregroundMask, foregroundMask, sE_e, Point(-1, -1), 1);
    dilate(foregroundMask, foregroundMask, sE_d, Point(-1, -1), 2);
    erode(foregroundMask, foregroundMask, sE_e, Point(-1, -1), 0);
    #ifdef LOGGING
    clock_t end_morph = clock();
    elapsed_time = double(end_morph - begin_morphological);
    freopen("log.txt", "a", stderr);
    cerr << "Morphological time:" << elapsed_time << endl;
    fclose(stderr);
    #endif

    // find CCs in foregroundMask
    #ifdef LOGGING
    clock_t begin_CC = clock();
    #endif
    findCC(foregroundMask, vec_cc);
    #ifdef LOGGING
    clock_t end_CC = clock();
    elapsed_time = double(end_CC - begin_CC);
    freopen("log.txt", "a", stderr);
    cerr << "Connected Component find time:" << elapsed_time << endl;
    fclose(stderr);
    #endif

    prev_PedCount = inst_PedCount;
    inst_PedCount = 0;

    // iterate through the found CCs

    // TODO: Future deployment
    //std::vector<Detected> detected_arr;

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

#ifdef LOGGING
      clock_t classification_begin = clock();
#endif
      int classification = -1;
      classification = pclass.classify(vec_cc[i], objmask, frame, frame_hd);
#ifdef LOGGING
      end = clock();
      elapsed_time = double(end - classification_begin);
      freopen("log.txt", "a", stderr);
      cerr << "classification time:" << elapsed_time << endl;
      fclose(stderr);
#endif
      ped = false;
      Rect r = vec_cc[i].getBoundingBox();

      // TODO: Future deployment
      //Detected d1;

      switch(classification) {
        case TYPE_CAR:
          break;
        case TYPE_CAR_ONPATH:
          break;
        case TYPE_PED:
#ifdef DEBUG
          // rectangle(frame, r, Scalar(255,255,0), 1);

          // TODO: Future deployment
          // d1.p = vec_cc[i].getCentroidBox();
          // d1.size = vec_cc[i].getBoundingBoxArea();
          // detected_arr.push_back(d1);
#endif
          break;
        case TYPE_PED_ONPATH:
#ifdef DEBUG
        rectangle(frame, r, Scalar(255,255,0), 3);

        // TODO: Future deployment
	      //d1.p = vec_cc[i].getCentroidBox();
	      //d1.size = vec_cc[i].getBoundingBoxArea();
	      //detected_arr.push_back(d1);
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
          // rectangle(frame, r, Scalar(0,255,0), 1);
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

    // TODO: Future deployment
    //kalmanPeds += pedestrian_count(&frame, detected_arr, &tracker_arr);
	  //printf("Total pedestrian count:  %d\n", kalmanPeds);

    /////////
    /* OUT */
    /////////

    if(!isUptimeSCSet) {
      uptimeSC_offset = vstats.getUptime();
      if(pclass.pedPathIsValid) isUptimeSCSet = true;
    }

    result = -1;
    if(!pclass.pedPathIsValid /* || !pclass.carPathIsValid */) {
      result = 0; // CALIBRATING
    }
    if(pedInDanger) result = 1;

    vstats.updateAverageFPS();

    curr_fps = vstats.updateFPS();

    if(ped) pedPerSec = true;
    inst_PedCount = MAX(prev_PedCount,inst_PedCount);

#ifdef DEBUG
    //vstats.displayStats("inst", result);
#endif
    if(vstats.getUptime() > 1.0) pclass.bgValid = true;

    if(frameQueue.size() > frameQueueSetSize) {
#ifdef LOGGING
      clock_t begin_pop = clock();
#endif
      pthread_mutex_lock(&qutex);
      // >>>
      frameQueue.pop_front();
      // >>>
      pthread_mutex_unlock(&qutex);
#ifdef LOGGING
      clock_t end_pop = clock();
      elapsed_time = double(end_pop - begin_pop);
      freopen("log.txt", "a", stderr);
      cerr << "pop time:" << elapsed_time << endl << endl;
      fclose(stderr);
#endif
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
      cout << pclass.getCurrentPedCount_adjusted() << "/" << pclass.getPedCountCalibration() << 
              "," << sec_PedCount << 
              "," << totalPed << endl;
#endif

#ifdef DEBUG
      cout << "[" << vstats.getWidth() << "x" << vstats.getHeight() << 
              "]  |  Uptime: " << vstats.getUptime() << "s  |  Since Calibration: " <<
              vstats.getUptime() - uptimeSC_offset << "s  |  Calibration Length: " << uptimeSC_offset <<
              "s\t| Calibration Status:\t" <<  
              pclass.getCurrentPedCount() << "/" << pclass.getPedCountCalibration_adjusted() << 
              "[adjusted], " <<
              pclass.getCurrentPedCount_adjusted() << "/" << pclass.getPedCountCalibration() <<
              "  |  Last loaded detections for this hour: " << pclass.hourToDetections[vstats.getHour()] << endl;
#endif

      pedPerSec = false;
      prev_PedCount = inst_PedCount =  0;
    }

    //CHANGE CURRENT FRAME TO HSV//
    int valLevel = 0;
    int avgVal = 0;

    if ((int)vstats.getUptime()%10==0) {
      int total = 0;

      Mat hsvImg;
      cvtColor(frame, hsvImg, CV_RGB2HSV);
      for (int i = 0; i < hsvImg.rows; i++) {
          for(int j = 0; j <hsvImg.cols; j++) {
              Vec3b intensity = hsvImg.at<Vec3b>(i,j);
              uchar value = intensity.val[2];
              total += value;
          }
      }
      avgVal = total/(hsvImg.rows*hsvImg.cols);
    }

    if (avgVal >= 0 && avgVal < 90) valLevel = 1;
    if (avgVal >= 90 && avgVal < 120) valLevel = 2;
    if (avgVal >= 120 && avgVal < 140) valLevel = 3;
    if (avgVal >= 140) valLevel = 4;


    /////////////////////////////
    /* READ/WRITE CALIBRATIONS */
    /////////////////////////////

    // write/read new calibration tables every 5 mins
    // ...and only do it once in this interval

    // EXTERNAL to timing - only write when we hit the upper bound
    // check to make sure calibration doesn't already exist

    /* --- */

    // write calibrations once PedCount == 500
    if(pclass.getCurrentPedCount_adjusted() == pclass.getPedCountCalibration() ) {

      // if we already have an appropriate calib, skip writing
      bool skipWrite = false;

      DIR *dir;
      struct dirent *dent;

      dir = opendir("./calibrations");
      if(dir != NULL) {
        while( (dent=readdir(dir)) != NULL) {
          string fname = dent->d_name;

          // "partial" -- "0" means success
          if( fname.substr(0,7).compare("partial") == 0) {

            // "_x_" hour, "xxxx" num detections
            int hour = atoi( fname.substr(8,2).c_str() );
            int numDetections = atoi( fname.substr(11,4).c_str() );
            int hsvVal = atoi( fname.substr(16,1).c_str() );

            // if hour isn't right, skip ahead
            if(hour != vstats.getHour() ) continue;

            // if numDetections < 500, skip ahead
            if(numDetections < pclass.getPedCountCalibration() ) continue;
            
            // if hsvVal isn't the same, skip ahead
            if(hsvVal != valLevel) continue;

            // now we're only left in a situation in which we already   \
            // have a calibration for this hour, with the maximum       \
            // number of detections to boot. Go ahead and skip writing
            skipWrite = true;
          }
        }
      }

      if(!skipWrite) {
	
        // only write once
        Mat writePath = pclass.getPath(0);

        // sstream
        stringstream ss;
        ss << "./calibrations/partial_" << 
        setw(2) << setfill('0') << vstats.getHour() << "_" <<
        setw(4) << setfill('0') << pclass.getCurrentPedCount_adjusted() << "_" <<
        setw(1) << setfill('0') << valLevel <<
        ".jpg";

#ifdef DEBUG
        cout << "[" << pclass.getPedCountCalibration() << "] Writing " << ss.str() << endl;
#endif
        imwrite(ss.str(), writePath);
      }
    }
    /* --- */

    if(writeCalib) {
      
      // write current calibration
      // 0: ped path
      // 1: car path
      ////////////////////////////

      // only write once
      Mat writePath = pclass.getPath(0);

      // sstream
      stringstream ss;
      ss << "./calibrations/partial_" << 
      setw(2) << setfill('0') << vstats.getHour() << "_" <<
      setw(4) << setfill('0') << pclass.getCurrentPedCount_adjusted() << "_" <<
      setw(1) << setfill('0') << valLevel <<
      ".jpg";

      // write current calibration
      if(pclass.getCurrentPedCount_adjusted() < pclass.getPedCountCalibration() ) {
#ifdef DEBUG
        cout << "Writing " << ss.str() << endl;
#endif
        imwrite(ss.str(), writePath);
      }

      pclass.clearPath(0);

      // populate pclass calib vector
      ///////////////////////////////

      DIR *dir;
      struct dirent *dent;

      dir = opendir("./calibrations");
      if(dir != NULL) {
        while( (dent=readdir(dir)) != NULL) {
          string fname = dent->d_name;

          // "partial" -- "0" means success
          if( fname.substr(0,7).compare("partial") == 0) {

            // "_x_" hour, "xxxx" num detections
            int hour = atoi( fname.substr(8,2).c_str() );
            int numDetections = atoi( fname.substr(11,4).c_str() );

            if(numDetections < pclass.hourToDetections[hour]) continue;
            else pclass.hourToDetections[hour] = numDetections;

            // populate the calibration vectors
            pclass.pHour = vstats.getHour();
            pclass.hourToDetections[hour] = numDetections;

            int scaledHour = hour;

            string openstream = "./calibrations/" + fname;
            Mat calib = imread(openstream, CV_LOAD_IMAGE_GRAYSCALE);
#ifdef DEBUG
            cout << "Loaded " << openstream << endl;
#endif  
            if(calib.data) {
              pclass.insertCalibration(scaledHour, calib);
#ifdef DEBUG
              cout << "inserted Calibration >> " << scaledHour << endl;
#endif
            }

            // TODO
            // remove read data
            //remove(openstream.c_str());
            //cout << "Removed " << openstream << endl;
          }
        }
      }

      writeCalib = false;
    }
    if(sinceLastWrite > 0) sinceLastWrite--;
    // write every 15 mins
    if((int)vstats.getUptime()%900 == 0 && sinceLastWrite == 0) {
      writeCalib = true;
      sinceLastWrite = 100;
    }

#ifdef DEBUG
    imshow("frame", frame);
    imshow("fg", foregroundMask);
    imshow("probable path", dangerPath);
    if(waitKey(30) >= 0) break;//30
#endif

  }
  pthreadExit = true;
  sleep(10);

  cout << "goodbye" << endl;
  return 0;
}
