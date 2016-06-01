/*
 * HOG based Pedestrian Detector. Used in the calibration phase to
 * 1) determine validity of ped votes
 * 2) establish ped path
 * 3) establish acceptable ranges of ped size
 *
 **/

#include "peddetect.hpp"

PedestrianDetector::PedestrianDetector() {
    minHeight = INT_MAX;
    minWidth = INT_MAX;
    maxHeight = 0;
    maxWidth = 0;

    pedSizeValid = false;
    carSizeValid = false;
}

bool PedestrianDetector::detectPedestrian(const Mat& objframe, const Size& objsize) {

    vector<Rect> detected;

    HOGDescriptor hog;
    hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());

    // FIXME
    hog.detectMultiScale(objframe, detected, 0, Size(2,2), Size(8,8), 1.05, 2);

    // pedestrian is detected 
    // TODO / FIXME: use non-maximal suppression to extrapolate small false positives as one box
    if(detected.size() != 0 ) {
    //if(detected.size() == 1 ) {
        if(objsize.width < minWidth) minWidth = objsize.width;
        if(objsize.width > maxWidth) maxWidth = objsize.width;
        if(objsize.height < minHeight) minHeight = objsize.height;
        if(objsize.height > maxHeight) maxHeight = objsize.height;
        pedSizeValid = true;
        return true;
    } else return false;
}

bool PedestrianDetector::detectCar(const Mat& objframe, const Size& objsize) {

    vector<Rect> detected;

    CascadeClassifier cascade;
    if(!cascade.load("cars3.xml")) cout << "can't load xml file for car detection" << endl;

    Mat frame_gray;
    cvtColor(objframe, frame_gray, CV_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);

    cascade.detectMultiScale(frame_gray, detected, 1.05, 1, 0|CV_HAAR_SCALE_IMAGE, Size(30,30));

    // car is detected 
    // TODO / FIXME: use non-maximal suppression to extrapolate small false positives as one box
    if(detected.size() == 1 ) {
        if(objsize.width < minWidth) minWidth = objsize.width;
        if(objsize.width > maxWidth) maxWidth = objsize.width;
        if(objsize.height < minHeight) minHeight = objsize.height;
        if(objsize.height > maxHeight) maxHeight = objsize.height;
        carSizeValid = true;
        return true;
    } else return false;
}

Size PedestrianDetector::getMinSize() {
    return Size(minWidth, minHeight);
}

Size PedestrianDetector::getMaxSize() {
    return Size(maxWidth, maxHeight);
}
