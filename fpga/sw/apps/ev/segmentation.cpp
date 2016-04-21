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
  Mat foregroundMask_ed1, foregroundMask_ed2, foregroundMask_ed3;
  Mat dist;
  Mat dangerPath;
  bool ped = false, pedInDanger = false;

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

  // processing loop
  cout << endl;

  for(;;) {


  	Mat rgbSplit[3], frame_r, frame_g, frame_b;
    int rAve = 0, gAve = 0, bAve = 0, pixCount = 0;
    split(frame, rgbSplit);
    frame_r = rgbSplit[0] & pclass.carPath;
    frame_g = rgbSplit[1] & pclass.carPath;
    frame_b = rgbSplit[2] & pclass.carPath;

    for(int r = 0; r < frame_r.rows; r++){
    	for(int c = 0; c < frame_r.cols; c++){
    		if(pclass.carPath.at<unsigned char>(r, c) != 0){
    			pixCount++;
    			rAve += (int) frame_r.at<unsigned char>(r, c);
    			gAve += (int) frame_g.at<unsigned char>(r, c);
    			bAve += (int) frame_b.at<unsigned char>(r, c);
    		}
    	}
    }
    if(pixCount != 0){
    	rAve = rAve / pixCount;
	    gAve = gAve / pixCount;
	    bAve = bAve / pixCount;
	    threshold(frame_r, frame_r, rAve - 30, 255, THRESH_TOZERO);
		threshold(frame_r, frame_r, rAve + 30, 255, THRESH_TOZERO_INV);
		threshold(frame_g, frame_g, gAve - 30, 255, THRESH_TOZERO);
		threshold(frame_g, frame_g, gAve + 30, 255, THRESH_TOZERO_INV);
		threshold(frame_b, frame_b, bAve - 30, 255, THRESH_TOZERO);
		threshold(frame_b, frame_b, bAve + 30, 255, THRESH_TOZERO_INV);
		for(int r = 0; r < frame_r.rows; r++){
    		for(int c = 0; c < frame_r.cols; c++){
		      if(frame_r.at<unsigned char>(r, c) == 0){
		        frame_g.at<unsigned char>(r, c) = 0;
		        frame_b.at<unsigned char>(r, c) = 0;
		      }
		      else if(frame_g.at<unsigned char>(r, c) == 0){
		        frame_r.at<unsigned char>(r, c) = 0;
		        frame_b.at<unsigned char>(r, c) = 0;
		      }
		      else if(frame_b.at<unsigned char>(r, c) == 0){
		        frame_g.at<unsigned char>(r, c) = 0;
		        frame_r.at<unsigned char>(r, c) = 0;
		      }
		    }
		}
    }

    Mat editCarPath;
    merge(rgbSplit, 3, editCarPath);
	cvtColor(editCarPath, editCarPath, CV_BGR2GRAY);
	//cout << editCarPath.rows << " " << editCarPath.cols << endl << pclass.carPath.rows << " " << pclass.carPath.cols << endl;

    editCarPath = editCarPath & pclass.carPath;

    dangerPath = editCarPath & pclass.pedPath;
    //dangerPath = dangerPath & editCarPath;

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

    //medianBlur(frame, frame, 7);
    frame.copyTo(oframe);
    GaussianBlur(frame, frame, Size(5, 5), 0, 0);

    /* PROCESSING */

    // remove camera jitter 
    if(STABILIZE) frame = estimateMotion(&frame,  &prev_gradient);
    if(RIGID_STABILIZE) {
      Mat M = estimateRigidTransform(prev_frame, frame, 0);
      warpAffine(frame, frame, M, Size(vstats.getWidth(), vstats.getHeight()), INTER_NEAREST|WARP_INVERSE_MAP);
    }
    if(OPENCV_STABILIZE) {}

    // update background model
    MOG(frame, foregroundMask, 0.005);
    MOG.getBackgroundImage(backgroundModel);

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
    /*
    distanceTransform(foregroundMask, dist, CV_DIST_L1, 3);
    threshold(dist, dist, 1, 255, THRESH_BINARY);
    dist.convertTo(dist, CV_8U);
    */

    erode(foregroundMask, foregroundMask_ed3, sE_e, Point(-1, -1), 1);
    dilate(foregroundMask_ed3, foregroundMask_ed3, sE_d, Point(-1, -1), 2);
    erode(foregroundMask_ed3, foregroundMask_ed3, sE_e, Point(-1, -1), 0);

    // find CCs in foregroundMask
    findCC(foregroundMask_ed3, vec_cc);

    prevCarCount = instCarCount;
    prevPedCount = instPedCount;

    instPedCount = 0;
    instCarCount = 0;
    // iterate through the found CCs
    for(int i=0; i<vec_cc.size(); i++) {

      Rect cc_bb = vec_cc[i].getBoundingBox();
      int currentSize = cc_bb.width*cc_bb.height;
      int pedSize = pclass.peddetect.getMinSize().area();
      int reqSize;
      if(!pclass.peddetect.pedSizeValid) reqSize = 400; // hardcoded for resolution/possible env
      else reqSize = pedSize * 0.10;
      if(reqSize < 200) reqSize = 200;

      if(currentSize < reqSize) continue;

      Mat objmask = Mat::zeros(vstats.getHeight(), vstats.getWidth(), CV_8U);
      objmask = vec_cc[i].getMask(objmask.rows, objmask.cols);

      dilate(objmask, objmask, sE_d, Point(-1, -1), 4);
      //erode(objmask, objmask, sE_d, Point(-1, -1), 4);

      distanceTransform(objmask, dist, CV_DIST_L2, 3);
      normalize(dist, dist, 0, 255, NORM_MINMAX);
      threshold(dist, dist, 150, 255, THRESH_TOZERO);
      dist.convertTo(dist, CV_8U);

      distanceTransform(dist, dist, CV_DIST_L2, 3);
      normalize(dist, dist, 0, 255, NORM_MINMAX);
      dist.convertTo(dist, CV_8U);

      int classification = -1;
      //classification = pclass.classify(vec_cc[i], dist, oframe);
      classification = pclass.classify(vec_cc[i], objmask, oframe);

      Rect r = vec_cc[i].getBoundingBox();
      switch(classification) {
        case TYPE_CAR:
          rectangle(frame, r, Scalar(0,0,255));
          instCarCount++;
          ped = false;
          break;
        case TYPE_CAR_ONPATH:
          rectangle(frame, r, Scalar(0,0,255), 3);
          instCarCount++;
          ped = false;
          break;
        case TYPE_PED:
          rectangle(frame, r, Scalar(255,0,0));
          instPedCount++;
          ped = true;
          break;
        case TYPE_PED_ONPATH:
          rectangle(frame, r, Scalar(255,0,0), 3);
          instPedCount++;
          ped = true;
          break;
        case TYPE_UNCLASS: 
          //rectangle(frame, r, Scalar(0,255,0));
          ped = false;
          break;
        default:
          ped = false;
          break;
      }

      //display centroids
      Point centroid = vec_cc[i].getCentroidBox();
      //circle(frame, vec_cc[i].getCentroidExact(objmask), 5, Scalar(0,80,80));
      if(ped && dangerPath.at<int>(centroid.x, centroid.y) != 0){
      	circle(frame, centroid, 5, Scalar(255,0,0));
      	pedInDanger = true;
      }
      else{
      	circle(frame, centroid, 5, Scalar(0,255,0));
      	pedInDanger = false;
      }

    }

    vstats.updateFPS();
    //vstats.displayStats();

    

    /* OUT */
    imshow("frame", frame);
    imshow("path", pclass.carPath);
    imshow("ppath", pclass.pedPath);
    imshow("danger", dangerPath);

    if(prevPedCount > instPedCount) pedCount++; 
    if(prevCarCount > instCarCount) carCount++; 

    //cout << "\rPedestrians: " << pedCount << "\tCar Count: " << carCount;
    
    if(waitKey(30) >= 0) break;
  }
  return 0;
}
