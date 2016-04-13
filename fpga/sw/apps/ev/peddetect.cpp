/*
 * HOG based Pedestrian Detector. Used in the calibration phase to
 * 1) determine validity of ped votes
 * 2) establish ped path
 * 3) establish acceptable ranges of ped size
 *
 **/

#include "peddetect.hpp"

PedestrianDetector::PedestrianDetector() {
    minHeight = 0;
    minWidth = 0;
    maxHeight = 0;
    maxWidth = 0;
}

bool PedestrianDetector::detectPedestrian(const Mat& objframe) {

    vector<Rect> detected;

    imwrite("try.jpg", objframe);

    HOGDescriptor hog;
    hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());

    hog.detectMultiScale(objframe, detected, 0, Size(4,4), Size(16,16), 1.05, 2);

    // pedestrian is detected 
    // TODO / FIXME: use non-maximal suppression to extrapolate small false positives as one box
    if(detected.size() != 0 ) {
        if(detected[0].width < minWidth) minWidth = detected[0].width;
        if(detected[0].width > maxWidth) maxWidth = detected[0].width;
        if(detected[0].height < minHeight) minHeight = detected[0].height;
        if(detected[0].height > maxHeight) maxHeight = detected[0].height;
        return true;
    } else return false;
}

Size PedestrianDetector::getMinSize() {
    return Size(minWidth, minHeight);
}

Size PedestrianDetector::getMaxSize() {
    return Size(maxWidth, maxHeight);
}
