/*
 *  Voting Scheme for Pedestrian v. Car classification
 *
 *  Has 3 stages:
 *
 *  1) weak classification -> width v. height & size considerations
 *  2) stronger -> compare inside path
 *     IF no path is deemed to exist, go to stage 3
 *  3) strongest - Haar/LBP classifier -> use this to create paths
 **/

#include "pclass.hpp"

// constructor
PathClassifier::PathClassifier(int rows, int cols) {

  prows = rows;
  pcols = cols;

  carPath = Mat::zeros(rows, cols, CV_8U);
  pedPath = Mat::zeros(rows, cols, CV_8U);

  carPathCount = 0;
  pedPathCount = 0;

  carPathIsValid = 0;
  pedPathIsValid = 0;
}

// initial effort is just for cars
int PathClassifier::classify(ConnectedComponent& ccomp, const Mat& objmask, const Mat& frame) {

  // return -1          = not worth of consideration
  // classification 0   = car
  // classification 1   = pedestrian
  // classification >1  = as of yet unclass'd
  // UPDATE: check enums in pclass.hpp for detailed types

  int pedVotes = 0;
  int carVotes = 0;

  // first stage: Width/Height/Size
  int cc_pix = ccomp.getPixelCount();

  if(ccomp.getBoundingBoxHeight() > ccomp.getBoundingBoxWidth()) pedVotes += 30;
  else carVotes += 30;
  if(cc_pix > CAR_SIZE_THRESHOLD) carVotes += 10;

  // second stage: Path Position
  if(carPathIsValid) {
    Point cntd = ccomp.getCentroidBox();

    // check intersections
    if(carPath.at<unsigned char>(cntd) > 128) {
      carVotes += 20;

      // reasonably sure this is a car; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR_ONPATH, objmask, frame);
    } else {
      //carVotes -= 20;

      // if not on the path, use Haar to more correctly determine car-ness & add to path
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR, objmask, frame);
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, objmask, frame);
    }

    // check intersections
    if(pedPath.at<unsigned char>(cntd) > 128) {
      pedVotes += 20;

      // reasonably sure this is a ped; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED_ONPATH, objmask, frame);
    } else {
      pedVotes -= 20;

      // if not on the path, use Haar to more correctly determine car-ness & add to path
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR, objmask, frame);
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, objmask, frame);
    }
  } else carPathCount++;

  /* TODO: How will we count the carPath as valid? */
  if(carPathCount > 160) carPathIsValid = 1;

  if(pedVotes < 30 && carVotes < 30 || pedVotes == carVotes) 
    return TYPE_UNCLASS;

  if(carVotes >= 50) 
    return TYPE_CAR_ONPATH;

  if(pedVotes >= 50) 
    return TYPE_PED_ONPATH;

  return (carVotes > pedVotes) ? TYPE_CAR : TYPE_PED;
}

void PathClassifier::updatePath(ConnectedComponent& ccomp, int type, const Mat& objmask, const Mat& frame) {

  Mat objframe;
  Rect rectMask = ccomp.getRectMask(frame.rows, frame.cols);
  objframe = frame(rectMask);

  if(type == TYPE_CAR) {


    if(cardetect.detectCar(objframe, rectMask.size())) {
	    carsInPath = 400;
	    if (carQueue.size() < carsInPath) {
		    carQueue.push_back(objmask);
		    redrawMask();
	    } else {
		    carQueue.pop_front();
		    carQueue.push_back(objmask);
		    redrawMask();
	    }
    }

  // already reasonably confident about car-ness
  } else if (type == TYPE_CAR_ONPATH) {
      /*
	  carsInPath = 400;
	  if (carQueue.size() < carsInPath) {
		  carQueue.push_back(objmask);
		  redrawMask();
	  } else {
		  carQueue.pop_front();
		  carQueue.push_back(objmask);
		  redrawMask();
	  }
      */

  } else if(type == TYPE_PED) {
    
    // find cropped image of obj
    // HoG to determine if pedestrian
    Mat re_objframe = objframe.clone();

    // hog's defaultPeopleDetector needs a person of at least 64,128 size
    if(rectMask.size().height < 128 || rectMask.size().width < 64) {
      resize(objframe, re_objframe, Size(64,128));
    }

    if(peddetect.detectPedestrian(re_objframe, rectMask.size())) {
	  pedsInPath = 400;
	  if(pedQueue.size() < pedsInPath) {
		pedQueue.push_back(objmask);
		redrawMask();
	  } else {
		pedQueue.pop_front();
		pedQueue.push_back(objmask);
		redrawMask();
	  }
    }
  } else if(type == TYPE_PED_ONPATH) {

    if(rectMask.size().height > peddetect.getMaxSize().height || rectMask.size().width > peddetect.getMaxSize().width) {

      Mat re_objframe = objframe.clone();

      // hog's defaultPeopleDetector needs a person of at least 64,128 size
      if(rectMask.size().height < 128 || rectMask.size().width < 64) {
        resize(objframe, re_objframe, Size(64,128));
      }

      // check to make sure
      if(peddetect.detectPedestrian(re_objframe, rectMask.size())) {
	    pedsInPath = 400;
	    if(pedQueue.size() < pedsInPath) {
	      pedQueue.push_back(objmask);
		  redrawMask();
	    } else {
		  pedQueue.pop_front();
		  pedQueue.push_back(objmask);
		  redrawMask();
        }
      }
    } else {
        /*
	    pedsInPath = 400;
	    if(pedQueue.size() < pedsInPath) {
	      pedQueue.push_back(objmask);
		  redrawMask();
	    } else {
		  pedQueue.pop_front();
		  pedQueue.push_back(objmask);
		  redrawMask();
        }
        */
    }
  }
}

void PathClassifier::redrawMask() {
    carPath = Mat::zeros(prows, pcols, CV_8U);
	for(int i = 0; i < carQueue.size(); i++) {
        carPath |= carQueue[i];
	}
    /*
    distanceTransform(carPath, carPath, CV_DIST_L2, 3);
    normalize(carPath, carPath, 0, 255, NORM_MINMAX);
    threshold(carPath, carPath, 0, 255, THRESH_TOZERO);
    carPath.convertTo(carPath, CV_8U);
    */

    pedPath = Mat::zeros(prows, pcols, CV_8U);
	for(int i = 0; i < pedQueue.size(); i++) {
		pedPath |= pedQueue[i];
	}
    /*
    distanceTransform(pedPath, pedPath, CV_DIST_L2, 3);
    normalize(pedPath, pedPath, 0, 255, NORM_MINMAX);
    threshold(pedPath, pedPath, 0, 255, THRESH_TOZERO);
    pedPath.convertTo(pedPath, CV_8U);
    */
}

