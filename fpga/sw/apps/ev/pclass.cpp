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

  recalibrate = false;

  carPathIsValid = false;
  pedPathIsValid = false;

  pedsInPath = 1000;
  carsInPath = 600;

  pedsInPathDivisor = 2;

  bgValid = false;
}

//int PathClassifier::classify(ConnectedComponent& ccomp, const Mat& objmask, const Mat& frame, const Mat& frame_hd) {
int PathClassifier::classify(ConnectedComponent& ccomp, const Mat& objmask, Mat& frame, const Mat& frame_hd) {

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

  if(recalibrate) {
    pedPathIsValid = false;
    pedQueue.clear();
    recalibrate = !recalibrate;
  }

  if(pedQueue.size() >= pedsInPath/pedsInPathDivisor) pedPathIsValid = true;
  if(carQueue.size() >= carsInPath/3) carPathIsValid = true;

  // second stage: Path Position
  if(bgValid) {
    Point cntd = ccomp.getCentroidBox();

    // check intersections
    if(pedPath.at<unsigned char>(cntd) > 50) {
      if(pedVotes > 0) pedVotes += 20;

      // reasonably sure this is a ped; on path with more votes. Update path
      // TODO: assign weights with updating path?
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED_ONPATH, outType, objmask, frame, frame_hd);
      if(outType != TYPE_PED_ONPATH) pedVotes -= 0;
    } else {
      if(pedVotes > carVotes) updatePath(ccomp, TYPE_PED, outType, objmask, frame, frame_hd);
      //if(outType != TYPE_PED || outType != TYPE_PED_ONPATH) pedVotes = 0;
      if(outType == TYPE_PED_ONPATH) pedVotes += 20;  // make sure outType is in line with what is returned
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

//void PathClassifier::updatePath(ConnectedComponent& ccomp, int type, int& outType, const Mat& objmask, const Mat& frame, const Mat& frame_hd) {
void PathClassifier::updatePath(ConnectedComponent& ccomp, int type, int& outType, const Mat& objmask, Mat& frame, const Mat& frame_hd) {

  outType = type; 

  int scale = 180;

  int redrawValue = 10;
  Scalar redrawColor = Scalar(redrawValue, redrawValue, redrawValue);

  Mat objframe;
  Rect rectMask = ccomp.getRectMask(frame.rows, frame.cols);
  objframe = frame(rectMask);

  /** @csi_enhance
    * 1) get centroid
    * 2) compute scaled offset within 320x240 frame
    * 3) compute size scaling for 320x240 frame
    * 4) apply both scales to HD frame to obtain HD person
    */

  bool hd = false;
  Point bbp = Point(ccomp.getBoundingBox().x, ccomp.getBoundingBox().y);

  double pos_scalex = (double)bbp.x / frame.cols;
  double pos_scaley = (double)bbp.y / frame.rows;

  double sze_scalex = (double)ccomp.getBoundingBox().width / frame.cols;
  double sze_scaley = (double)ccomp.getBoundingBox().height / frame.rows;

  // create secondary RectMask for HD
  int xx = frame_hd.cols*pos_scalex;
  int yy = frame_hd.rows*pos_scaley;
  int ww = frame_hd.cols*sze_scalex;
  int hh = frame_hd.rows*sze_scaley;

  xx = (xx-10 < 0) ? 0 : xx-10;
  yy = (yy-10 < 0) ? 0 : yy-10;
  ww = (xx+ww+20 > frame_hd.cols) ? frame_hd.cols-xx : ww+20;
  hh = (yy+hh+20 > frame_hd.rows) ? frame_hd.rows-yy : hh+20;

  Rect r_hd(Point(xx, yy), Size(ww, hh));

  Mat objframe_hd;
  Scalar color = Scalar(255,0,0);

  objframe_hd = frame_hd(r_hd);
  //if(objframe.size().height < 64 || objframe.size().width < 32) {
  if(objframe.size().height < 128 || objframe.size().width < 64) {
    color = Scalar(255,0,255);
    objframe = objframe_hd;
    hd = true;
  } else { color = Scalar(255,0,0); hd = false; }

  if(type == TYPE_PED) {

    if(!pedPathIsValid) {
      
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

      // need to find the centroids in image
      vector<Point> cntd_vec;

      if(peddetect.detectPedestrian(re_objframe, rectMask.size(), cntd_vec)) {
        //rectangle(frame, ccomp.getBoundingBox(), color, 3);
        rectangle(frame, ccomp.getBoundingBox(), color, 1);

        // prepare ctrd_mat
        Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);

        for(int i = 0; i < cntd_vec.size(); i++) {
          // add the offsets for the centroid
          if(hd) {
            circle(ctrd_mat, Point(ccomp.getCentroidBox().x+cntd_vec[i].x/3.2,ccomp.getCentroidBox().y+cntd_vec[i].y/3.2), MIN(ccomp.getBoundingBoxArea() / scale,10), redrawColor, CV_FILLED);
          } else {
            circle(ctrd_mat, ccomp.getCentroidBox()+cntd_vec[i], MIN(ccomp.getBoundingBoxArea() / scale,10), redrawColor, CV_FILLED);
          }
        }

        if(pedQueue.size() < pedsInPath) {
          pedQueue.push_back(ctrd_mat);
          redrawMask();
        } else {
          pedQueue.pop_front();
          pedQueue.push_back(ctrd_mat);
          redrawMask();
        }
        outType = TYPE_PED_ONPATH;
      } else outType = TYPE_PED;
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

      // need to find the centroids in image
      vector<Point> cntd_vec;

      // check to make sure
      if(peddetect.detectPedestrian(re_objframe, rectMask.size(), cntd_vec)) {

        rectangle(frame, ccomp.getBoundingBox(), color, 3);
        // prepare ctrd_mat
        Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);

        for(int i = 0; i < cntd_vec.size(); i++) {
          // add the offsets for the centroid
          if(hd) {
            circle(ctrd_mat, Point(ccomp.getCentroidBox().x+cntd_vec[i].x/3.2,ccomp.getCentroidBox().y+cntd_vec[i].y/3.2), MIN(ccomp.getBoundingBoxArea() / scale,10), redrawColor, CV_FILLED);
          } else {
            circle(ctrd_mat, ccomp.getCentroidBox()+cntd_vec[i], MIN(ccomp.getBoundingBoxArea() / scale,10), redrawColor, CV_FILLED);
          }
        }

        if(pedQueue.size() < pedsInPath) {
          pedQueue.push_back(ctrd_mat);
          redrawMask();
        } else {
          pedQueue.pop_front();
          pedQueue.push_back(ctrd_mat);
          redrawMask();
        }
        outType = TYPE_PED_ONPATH;
      } else outType = TYPE_PED;
    } else {
      if(pedQueue.size() < pedsInPath) {
        Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
        circle(ctrd_mat, ccomp.getCentroidBox(), MIN(ccomp.getBoundingBoxArea() / scale,10), Scalar(redrawValue/2,redrawValue/2,redrawValue/2), CV_FILLED);
        pedQueue.push_back(ctrd_mat);
        redrawMask();
      } else {
        pedQueue.pop_front();
        Mat ctrd_mat = Mat::zeros(prows, pcols, CV_8U);
        circle(ctrd_mat, ccomp.getCentroidBox(), MIN(ccomp.getBoundingBoxArea() / scale,10), Scalar(redrawValue/2,redrawValue/2,redrawValue/2), CV_FILLED);
        pedQueue.push_back(ctrd_mat);
        redrawMask();
      }
    }
  }

}

void PathClassifier::redrawMask() {

    /*
    carPath = Mat::zeros(prows, pcols, CV_8U);
    for(int i = 0; i < carQueue.size(); i++) {
        carPath |= carQueue[i];
    }
    */

    pedPath = Mat::zeros(prows, pcols, CV_8U);
    for(int i = 0; i < pedQueue.size(); i++) {
        // TODO: actual probabilities? +10 is too rigid
        pedPath += pedQueue[i];
    }

    Mat sE_d = getStructuringElement(MORPH_ELLIPSE, Size(5,5));
    dilate(pedPath, pedPath, sE_d, Point(-1,-1), 2);
}

int PathClassifier::getCurrentPedCount() {
  return pedQueue.size();
}

int PathClassifier::getPedCountCalibration() {
  return pedsInPath / pedsInPathDivisor;
}
