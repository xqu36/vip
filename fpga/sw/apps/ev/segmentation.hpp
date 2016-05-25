#ifndef SEGMENTATION_H
#define SEGMENTATION_H

/*
 * segmentation.hpp 
 * 
 * Main program with which to experiment with segmentation
 *
 */

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/video/video.hpp>
#include <opencv2/video/background_segm.hpp>

#include <signal.h>
#include <stdio.h>
#include <iostream>
#include <string>

//#define MAX(x,y) (((x)>(y))?(x):(y))
//#define MIN(x,y) (((x)<(y))?(x):(y))

#define INFILE "img/klaus_high_320x240.mp4"

#define DETECTSHADOWS 0
#define NMIXTURES 3

#define STABILIZE 0
#define RIGID_STABILIZE 0
#define OPENCV_STABILIZE 0

#endif // SEGMENTATION_H
