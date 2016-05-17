#ifndef VIDSTAB_H
#define VIDSTAB_H

#include <iostream>
#include <iomanip>
#include <time.h>
#include <limits.h>
#include <cstdio>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include "opencv2/core/core.hpp"

#define PI 3.14159265359
#define ALPHA 0.1
#define THRESH_NOISE 5
#define NUM_DIVS 1

#define MOTIONSMOOTHING 75

using namespace cv;
using namespace std;

extern Point2d phase_diff;

// returned Scalars represent x and y components of motion
Mat estimateMotion(Mat*, Mat*);

#endif // VIDSTAB_H
