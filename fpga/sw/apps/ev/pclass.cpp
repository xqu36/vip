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
    }
  } else carPathCount++;

  /* TODO: How will we count the carPath as valid? */
  if(carPathCount > 160) carPathIsValid = 1;

  if(pedVotes < 30 && carVotes < 30 || pedVotes == carVotes) 
    return TYPE_UNCLASS;

  if(carVotes >= 50) 
    return TYPE_CAR_ONPATH;

  return (carVotes > pedVotes) ? TYPE_CAR : TYPE_PED;
}

void PathClassifier::updatePath(ConnectedComponent& ccomp, int type, const Mat& objmask) {

  // Haar Cascades
  if(type == TYPE_CAR) {
    // @MEGAN
    // TODO >>> run Haar on mask/image
    if(/* Haar returns postive for car */ true) {
      carPath |= objmask;
    }

  // already reasonably confident about car-ness
  } else if(type == TYPE_CAR_ONPATH) {
      carPath |= objmask;

  } else if(type == TYPE_PED) {}
}

