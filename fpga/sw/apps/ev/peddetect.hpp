#ifndef PEDDETECT_H
#define PEDDETECT_H

#include "opencv2/opencv.hpp"
#include "opencv2/objdetect/objdetect.hpp"

using namespace std;
using namespace cv;

class PedestrianDetector {
    private:
        int minHeight;
        int minWidth;
        int maxHeight;
        int maxWidth;

    public:
        bool pedSizeValid;
        bool carSizeValid;

        PedestrianDetector();
        bool detectPedestrian(const Mat& objframe, const Size& objsize);
        bool detectCar(const Mat& objframe, const Size& objsize);
        Size getMinSize();
        Size getMaxSize();
};

#endif // PEDDETECT_H
