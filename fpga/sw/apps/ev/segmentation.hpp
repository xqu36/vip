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

#define INFILE "img/klaus_high.mp4"

#define DETECTSHADOWS 1
#define NMIXTURES 5
#define STABILIZE 1

#endif // SEGMENTATION_H
