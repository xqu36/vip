#ifndef PCLASS_H
#define PCLASS_H

/*
 *  Path CLassifier for Pedestrian v. Car classification
 *
 *  Has 3 stages:
 *
 *  1) weak classification -> width v. height & size considerations
 *  2) stronger -> compare inside path
 *     IF no path is deemed to exist, go to stage 3
 *  3) strongest - Haar/LBP classifier -> use this to create paths
 **/

#include "opencv2/opencv.hpp"
#include "ccomp.hpp"

#define MIN_NUM_PIXELS 500
#define CAR_SIZE_THRESHOLD 700
#define MIN_AREA 250

using namespace cv;

enum objType {
  TYPE_CAR,
  TYPE_PED
};

class PathClassifier {
protected:
  Mat carPath;
  Mat pedPath;

  int carPathCount;
  int pedPathCount;

  bool carPathIsValid;
  bool pedPathIsValid;

public:
  PathClassifier(int rows, int cols);

  int classify(ConnectedComponent& ccomp);
  void updatePath(ConnectedComponent& ccomp, int type);
};

#endif // PCLASS_H
