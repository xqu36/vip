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

  pedsInPath = 1000;
  carsInPath = 600;

  bgValid = false;

  pstats.openLog("pclass.log");
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

  // pedestrian: ~1.618 PHI
  if(ccomp.getBoundingBoxHeight() > ccomp.getBoundingBoxWidth()) { 
    //if(ccomp.getBoundingBoxHeight() / ccomp.getBoundingBoxWidth() > 1.25)  pedVotes += 300;
    double ratio = (double)ccomp.getBoundingBoxHeight() / (double)ccomp.getBoundingBoxWidth();
    if(ratio > 1.25)  pedVotes += 30;
  } else carVotes += 30;

  if(pedQueue.size() >= pedsInPath/2) pedPathIsValid = true;
  if(carQueue.size() >= carsInPath/3) carPathIsValid = true;

  // second stage: Path Position
  if(bgValid) {
    Point cntd = ccomp.getCentroidBox();

    // check intersections
    if(pedPath.at<unsigned char>(cntd) > 100) {
      if(pedVotes > 0) pedVotes += 20;

      // reasonably sure this is a ped; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED_ONPATH, outType, objmask, frame);
      if(outType != TYPE_PED_ONPATH) pedVotes -= 0;
    } else {
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, outType, objmask, frame);
      //if(outType != TYPE_PED || outType != TYPE_PED_ONPATH) pedVotes = 0;
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

  int scale = 180;

  int redrawValue = 10;
  Scalar redrawColor = Scalar(redrawValue, redrawValue, redrawValue);

  Mat objframe;
  Rect rectMask = ccomp.getRectMask(frame.rows, frame.cols);
  objframe = frame(rectMask);

  if(type == TYPE_PED) {

    if(!pedPathIsValid) {
      
pstats.prepareWriteLog();

      // find cropped image of obj
      // HoG to determine if pedestrian
      Mat re_objframe = objframe.clone();

      // hog's defaultPeopleDetector needs a person of at least 64,128 size
      if(objframe.size().height < 128) {
        resize(objframe, re_objframe, Size(objframe.size().width,128));
        if(re_objframe.size().width < 64) resize(re_objframe, re_objframe, Size(64,re_objframe.size().height));
      }
      if(objframe.size().width < 64) {
        resize(objframe, re_objframe, Size(64,objframe.size().height));
        if(re_objframe.size().height < 128) resize(re_objframe, re_objframe, Size(re_objframe.size().width,128));
      }

      if(peddetect.detectPedestrian(re_objframe, rectMask.size())) {
        if(pedQueue.size() < pedsInPath) {
          Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
          circle(ctrd_mat, ccomp.getCentroidBox(), ccomp.getBoundingBoxArea() / scale, redrawColor, CV_FILLED);
          pedQueue.push_back(ctrd_mat);
          redrawMask();
        } else {
          pedQueue.pop_front();
          Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
          circle(ctrd_mat, ccomp.getCentroidBox(), ccomp.getBoundingBoxArea() / scale, redrawColor, CV_FILLED);
          pedQueue.push_back(ctrd_mat);
          redrawMask();
        }
        outType = TYPE_PED_ONPATH;
      } else outType = TYPE_PED;
      
pstats.writeLog("HoG", 0);

    }

  } else if(type == TYPE_PED_ONPATH) {

    /* TODO: REPLACE WITH STD DEV */
    int scaledMaxHeight = 1.2 * peddetect.getMaxSize().height;
    int scaledMaxWidth = 1.2 * peddetect.getMaxSize().width;
    int scaledMinHeight = 0.8 * peddetect.getMinSize().height;
    int scaledMinWidth = 0.8 * peddetect.getMinSize().width;

    if(rectMask.size().height > scaledMaxHeight && rectMask.size().width > scaledMaxWidth ||
       rectMask.size().height < scaledMinHeight && rectMask.size().width < scaledMinWidth ||
       !pedPathIsValid) {

      Mat re_objframe = objframe.clone();

      if(objframe.size().height < 128) {
        resize(objframe, re_objframe, Size(objframe.size().width,128));
        if(re_objframe.size().width < 64) resize(re_objframe, re_objframe, Size(64,re_objframe.size().height));
      }
      if(objframe.size().width < 64) {
        resize(objframe, re_objframe, Size(64,objframe.size().height));
        if(re_objframe.size().height < 128) resize(re_objframe, re_objframe, Size(re_objframe.size().width,128));
      }

pstats.prepareWriteLog();

      // check to make sure
      if(peddetect.detectPedestrian(re_objframe, rectMask.size())) {

        if(pedQueue.size() < pedsInPath) {
          Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
          circle(ctrd_mat, ccomp.getCentroidBox(), ccomp.getBoundingBoxArea() / scale, redrawColor, CV_FILLED);
          pedQueue.push_back(ctrd_mat);
          //pedQueue.push_back(objframe);
          redrawMask();
        } else {
          pedQueue.pop_front();
          Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
          circle(ctrd_mat, ccomp.getCentroidBox(), ccomp.getBoundingBoxArea() / scale, redrawColor, CV_FILLED);
          pedQueue.push_back(ctrd_mat);
          //pedQueue.push_back(objframe);
          redrawMask();
        }
        outType = TYPE_PED_ONPATH;
      } else outType = TYPE_PED;
    } else {
      if(pedQueue.size() < pedsInPath) {
        Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
        circle(ctrd_mat, ccomp.getCentroidBox(), ccomp.getBoundingBoxArea() / scale, redrawColor, CV_FILLED);
        pedQueue.push_back(ctrd_mat);
        //pedQueue.push_back(objframe);
        redrawMask();
      } else {
        pedQueue.pop_front();
        Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
        circle(ctrd_mat, ccomp.getCentroidBox(), ccomp.getBoundingBoxArea() / scale, redrawColor, CV_FILLED);
        pedQueue.push_back(ctrd_mat);
        //pedQueue.push_back(objframe);
        redrawMask();
      }
    }
pstats.writeLog("HoG confirm", 0);
  }

}

void PathClassifier::redrawMask() {

pstats.prepareWriteLog();

    carPath = Mat::zeros(prows, pcols, CV_8U);
    for(int i = 0; i < carQueue.size(); i++) {
        carPath |= carQueue[i];
    }

    pedPath = Mat::zeros(prows, pcols, CV_8U);
    for(int i = 0; i < pedQueue.size(); i++) {
        // TODO: actual probabilities? +10 is too rigid
        pedPath += pedQueue[i];
    }

    Mat sE_d = getStructuringElement(MORPH_ELLIPSE, Size(5,5));
    dilate(pedPath, pedPath, sE_d, Point(-1,-1), 2);

    // normalize the path and update
    if(pedPathIsValid) {
      normalize(pedPath,pedPath, 0, 255, NORM_MINMAX);
      //threshold(pedPath, pedPath, 50, 255, THRESH_BINARY);
    }

pstats.writeLog("redrawMask", 0);

}

