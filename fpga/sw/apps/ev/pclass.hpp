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
#include "segmentation.hpp"
#include "peddetect.hpp"

using namespace std;
using namespace cv;

enum objType {
  TYPE_CAR,
  TYPE_CAR_ONPATH,
  TYPE_PED,
  TYPE_PED_ONPATH,
  TYPE_UNCLASS
};

class PathClassifier {
  
private:
  int prows;
  int pcols;

  int carPathCount;
  int pedPathCount;

  int carPathIsValid;
  int pedPathIsValid;

  int carsInPath;
  deque<Mat> carQueue;

  PedestrianDetector peddetect;

public:
  Mat carPath;
  Mat pedPath;

  PathClassifier(int rows, int cols);

  int classify(ConnectedComponent& ccomp, const Mat& objmask, const Mat& frame);
  void updatePath(ConnectedComponent& ccomp, int type, const Mat& objmask, const Mat& frame);
  void redrawMask(deque<Mat> carQueue);
};

#endif // PCLASS_H
