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
  Mat carPath = Mat::zeros(rows, cols, CV_8U);
  Mat pedPath = Mat::zeros(rows, cols, CV_8U);

  int carPathCount = 0;
  int pedPathCount = 0;

  bool carPathIsValid = false;
  bool pedPathIsValid = false;
}

// initial effort is just for cars
int PathClassifier::classify(ConnectedComponent& ccomp) {

  // return -1          = not worth of consideration
  // classification 0   = car
  // classification 1   = pedestrian
  // classification >1  = as of yet unclass'd

  int pedVotes = 0;
  int carVotes = 0;

  // first stage: Width/Height/Size
  int cc_pix = ccomp.getPixelCount();
  int bb_area = ccomp.getBoundingBoxArea(); 

  if(cc_pix < MIN_NUM_PIXELS) return -1;
  if(ccomp.getBoundingBoxHeight() > ccomp.getBoundingBoxWidth()) pedVotes += 30;
  else carVotes += 30;
  
  if(cc_pix > CAR_SIZE_THRESHOLD) carVotes += 10;

  // second stage: Path Position
  if(carPathIsValid) {
    Rect r = ccomp.getBoundingBox();
    // @MEGAN get centroid

    // check intersections
    if(/* centroid within the path */ true) carVotes += 20;
    else carVotes -= 20;

  // If path doesn't exist, create car path using Haar classifier
  } else updatePath(ccomp, TYPE_CAR);

  if(pedVotes < 30 || carVotes < 30) return 2;
  return (carVotes >= pedVotes) ? TYPE_CAR : TYPE_PED;
}

void PathClassifier::updatePath(ConnectedComponent& ccomp, int type) {

  if(type == TYPE_CAR) {
    Mat objmask = Mat::zeros(/* TODO param res */ 320, 240, CV_8U);
    objmask = ccomp.getMask(objmask.rows, objmask.cols);

    // >>> run Haar on mask/image

    if(/* Haar returns postive for car */ true) {
      carPath |= objmask;
      carPathCount++;
    }
  } else if(type == TYPE_PED) {}

  if(carPathCount > 60) carPathIsValid = true;
}

