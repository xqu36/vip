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

#include <stdio.h>
#include <iostream>
#include <string>

#define INFILE "img/klaus_high_320x240.mp4"

#define DETECTSHADOWS 1
#define NMIXTURES 3

#define STABILIZE 1
#define RIGID_STABILIZE 0
#define OPENCV_STABILIZE 0

#define MIN_NUM_PIXELS 400
#define CAR_SIZE_THRESHOLD 700 
#define MIN_AREA 250

#endif // SEGMENTATION_H
