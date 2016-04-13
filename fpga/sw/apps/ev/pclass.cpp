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
int PathClassifier::classify(ConnectedComponent& ccomp, const Mat& objmask) {

  // return -1          = not worth of consideration
  // classification 0   = car
  // classification 1   = pedestrian
  // classification >1  = as of yet unclass'd

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
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR_ONPATH, objmask);
    } else {
      carVotes -= 20;

      // if not on the path, use Haar to more correctly determine car-ness & add to path
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR, objmask);
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, objmask);
    }

    // check intersections
    if(pedPath.at<unsigned char>(cntd) > 128) {
      pedVotes += 20;

      // reasonably sure this is a ped; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED_ONPATH, objmask);
    } else {
      pedVotes -= 20;

      // if not on the path, use Haar to more correctly determine car-ness & add to path
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR, objmask);
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, objmask);
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

void PathClassifier::updatePath(ConnectedComponent& ccomp, int type, const Mat& objmask) {

  if(type == TYPE_CAR) {
    // @MEGAN
    // TODO >>> run Haar on mask/image
    if(/* Haar returns postive for car */ true) {
      /*
  	  carPath.convertTo(carPath, CV_32F);
      accumulateWeighted(objmask, carPath, 0.03);
      carPath.convertTo(carPath, CV_8U);
      */
	    carsInPath = 150;
	    if (carQueue.size() < carsInPath) {
		    carPath |= objmask;
		    carQueue.push_back(objmask);
	    } else {
		    carQueue.pop_front();
		    carQueue.push_back(objmask);
		    redrawMask(carQueue);
	    }
    }

  // already reasonably confident about car-ness
  } else if (type == TYPE_CAR_ONPATH) {
	  carsInPath = 150;
	  if (carQueue.size() < carsInPath) {
		  carPath |= objmask;
		  carQueue.push_back(objmask);
	  } else {
		  carQueue.pop_front();
		  carQueue.push_back(objmask);
		  redrawMask(carQueue);
	  }

  } else if(type == TYPE_PED) {

    // @MEGAN
    // TODO >>> run Haar on mask/image
    if(/* Haar returns negative for car */ true) {
      pedPath |= objmask;
    }
  } else if(type == TYPE_PED_ONPATH) {
    pedPath |= objmask;
  }
}

void PathClassifier::redrawMask(deque<Mat> carQueue) {
		carPath = Mat::zeros(prows, pcols, CV_8U);
	for (int i = 0; i < carQueue.size(); i++) {
		carPath |= carQueue[i];
	}
}

