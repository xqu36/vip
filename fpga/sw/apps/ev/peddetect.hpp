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
        PedestrianDetector();
        bool detectPedestrian(const Mat& objframe);

        Size getMinSize();
        Size getMaxSize();
};

#endif // PEDDETECT_H
