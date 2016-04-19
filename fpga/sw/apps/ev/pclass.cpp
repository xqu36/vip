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

  carPathIsValid = false;
  pedPathIsValid = false;

  pedsInPath = 200;
  carsInPath = 200;

  bgValid = false;
}

int PathClassifier::classify(ConnectedComponent& ccomp, const Mat& objmask, const Mat& frame) {

  // return -1          = not worth of consideration
  // classification 0   = car
  // classification 1   = pedestrian
  // classification >1  = as of yet unclass'd
  // UPDATE: check enums in pclass.hpp for detailed types
  
  // cars ONPATH need to be checked for size
  // after a certain path has been built up, STOP HOG

  int pedVotes = 0;
  int carVotes = 0;

  int outType = TYPE_UNCLASS;

  // first stage: Width/Height/Size
  int cc_pix = ccomp.getPixelCount();

  if(ccomp.getBoundingBoxHeight() > ccomp.getBoundingBoxWidth()) pedVotes += 30;
  else carVotes += 30;
  if(cc_pix > CAR_SIZE_THRESHOLD) carVotes += 0; // disabled

  if(pedQueue.size() >= pedsInPath) pedPathIsValid = true;
  if(carQueue.size() >= carsInPath) carPathIsValid = true;

  // second stage: Path Position
  if(bgValid) {
    Point cntd = ccomp.getCentroidBox();

    // check intersections
    if(carPath.at<unsigned char>(cntd) > 128) {
      if(carVotes > 0) carVotes += 20;

      // reasonably sure this is a car; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR_ONPATH, outType, objmask, frame);
      if(outType != TYPE_CAR_ONPATH) carVotes -= 20;
    } else {
      if(carVotes > 0) carVotes -= 20;

      // if not on the path, use Haar to more correctly determine car-ness & add to path
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR, outType, objmask, frame);
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, outType, objmask, frame);
    }

    // check intersections
    if(pedPath.at<unsigned char>(cntd) > 128) {
      if(pedVotes > 0) pedVotes += 20;

      // reasonably sure this is a ped; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED_ONPATH, outType, objmask, frame);
      if(outType != TYPE_PED_ONPATH) pedVotes -= 20;
    } else {
      if(pedVotes > 0) pedVotes -= 20;

      // if not on the path, use Haar to more correctly determine car-ness & add to path
      if(carVotes > pedVotes) updatePath(ccomp, TYPE_CAR, outType, objmask, frame);
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, outType, objmask, frame);
    }
  } else ;

  if(pedVotes < 10 && carVotes < 10 || pedVotes == carVotes) 
    return TYPE_UNCLASS;

  if(carVotes >= 50) 
    return TYPE_CAR_ONPATH;

  if(pedVotes >= 50) 
    return TYPE_PED_ONPATH;

  return (carVotes > pedVotes) ? TYPE_CAR : TYPE_PED;
}

void PathClassifier::updatePath(ConnectedComponent& ccomp, int type, int& outType, const Mat& objmask, const Mat& frame) {

  outType = type; 

  Mat objframe;
  Rect rectMask = ccomp.getRectMask(frame.rows, frame.cols);
  objframe = frame(rectMask);

  if(type == TYPE_CAR) {
    if(!carPathIsValid) {

      if(cardetect.detectCar(objframe, rectMask.size())) {
        if (carQueue.size() < carsInPath) {
          carQueue.push_back(objmask);
          redrawMask();
        } else {
          carQueue.pop_front();
          carQueue.push_back(objmask);
          redrawMask();
        }
        outType = TYPE_CAR_ONPATH;
      } else outType = TYPE_CAR;
    }

  // already reasonably confident about car-ness
  } else if (type == TYPE_CAR_ONPATH) {
    //cout << "Min Car Size: " << cardetect.getMinSize().width << ", " << cardetect.getMinSize().height << endl;
    //cout << "Max Car Size: " << cardetect.getMaxSize().width << ", " << cardetect.getMaxSize().height << endl;

    int scaledMaxHeight = 0.8 * cardetect.getMaxSize().height;
    int scaledMaxWidth = 0.8 * cardetect.getMaxSize().width;
    int scaledMinHeight = 1.2 * cardetect.getMinSize().height;
    int scaledMinWidth = 1.2 * cardetect.getMinSize().width;
    int avgHeight = scaledMaxHeight+scaledMinHeight / 2;
    int avgWidth = scaledMaxWidth+scaledMinWidth / 2;

    if(rectMask.size().height < avgHeight || rectMask.size().width < avgWidth) {
    //if(rectMask.size().height > scaledMaxHeight || rectMask.size().width > scaledMaxWidth ||
    //   rectMask.size().height < scaledMinHeight || rectMask.size().width < scaledMinWidth) {

      if(cardetect.detectCar(objframe, rectMask.size())) {
        if (carQueue.size() < carsInPath) {
          carQueue.push_back(objmask);
          redrawMask();
        } else {
          carQueue.pop_front();
          carQueue.push_back(objmask);
          redrawMask();
        }
        outType = TYPE_CAR_ONPATH;
      } else outType = TYPE_UNCLASS;
    } else {
      if (carQueue.size() < carsInPath) {
        carQueue.push_back(objmask);
        redrawMask();
      } else {
        carQueue.pop_front();
        carQueue.push_back(objmask);
        redrawMask();
      }
    }
  } else if(type == TYPE_PED) {

    if(!pedPathIsValid) {
      
      // find cropped image of obj
      // HoG to determine if pedestrian
      Mat re_objframe = objframe.clone();

      // hog's defaultPeopleDetector needs a person of at least 64,128 size
      if(rectMask.size().height < 128 || rectMask.size().width < 64) {
        resize(objframe, re_objframe, Size(64,128));
      }

      if(peddetect.detectPedestrian(re_objframe, rectMask.size())) {
        if(pedQueue.size() < pedsInPath) {
          pedQueue.push_back(objmask);
          redrawMask();
        } else {
          pedQueue.pop_front();
          pedQueue.push_back(objmask);
          redrawMask();
        }
        outType = TYPE_PED_ONPATH;
      } else outType = TYPE_PED;
    }
  } else if(type == TYPE_PED_ONPATH) {

    int scaledMaxHeight = 1.0 * peddetect.getMaxSize().height;
    int scaledMaxWidth = 1.0 * peddetect.getMaxSize().width;
    int scaledMinHeight = 1.0 * peddetect.getMinSize().height;
    int scaledMinWidth = 1.0 * peddetect.getMinSize().width;
    if(rectMask.size().height > scaledMaxHeight || rectMask.size().width > scaledMaxWidth ||
       rectMask.size().height < scaledMinHeight || rectMask.size().width < scaledMinWidth) {

    //if(rectMask.size().height > peddetect.getMaxSize().height || rectMask.size().width > peddetect.getMaxSize().width ||
    //   rectMask.size().height < peddetect.getMinSize().height || rectMask.size().width < peddetect.getMinSize().width) {

      Mat re_objframe = objframe.clone();

      // hog's defaultPeopleDetector needs a person of at least 64,128 size
      if(rectMask.size().height < 128 || rectMask.size().width < 64) {
        resize(objframe, re_objframe, Size(64,128));
      }

      // check to make sure
      if(peddetect.detectPedestrian(re_objframe, rectMask.size())) {

        if(pedQueue.size() < pedsInPath) {
          pedQueue.push_back(objmask);
          redrawMask();
        } else {
          pedQueue.pop_front();
          pedQueue.push_back(objmask);
          redrawMask();
        }
        outType = TYPE_PED_ONPATH;
      } else outType = TYPE_UNCLASS;
    } else {
      if(pedQueue.size() < pedsInPath) {
        pedQueue.push_back(objmask);
        redrawMask();
      } else {
        pedQueue.pop_front();
        pedQueue.push_back(objmask);
        redrawMask();
      }
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

    distanceTransform(pedPath, pedPath, CV_DIST_L2, 3);
    normalize(pedPath, pedPath, 0, 255, NORM_MINMAX);
    threshold(pedPath, pedPath, 100, 255, THRESH_BINARY);
    dilate(pedPath, pedPath, Mat(), Point(-1,-1));
    pedPath.convertTo(pedPath, CV_8U);
}

