/*
 * crowd_detect.cpp
 * 
 * Main program with which to experiment with crowd counting
 *
 */
#include "opencv2/objdetect/objdetect.hpp"
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <stdio.h>
#include <iostream>

using namespace std;
using namespace cv;

int main(int argc, char** argv) {

    if(argc < 2) { 
        cout << "Error: argument count invalid." << endl;
        cout << "Usage: ./crowd_detect [input image]" << endl;
        exit(0);
    }

    Mat img = imread(argv[1]);

    CascadeClassifier classifier;

    classifier.load("~/VIP/opencv-2.4.13/data/haarcscades");

    Mat imgGray;

    cvtColor(img, imgGray, COLOR_RGB2GRAY);

    vector<Rect> faces;

    classifier.detectMultiScale(imgGray, faces, 1.05, 3, 0 | CV_HAAR_SCALE_IMAGE, Size(30, 30));



    //iterate through vector faces
    //and draw them onto the img frames
    //Go through crowd photos see if they can detect faces
    //May change the max and min size of faces with alot smaller for crowds detection


    /////////////////////////////////
    /* INSERT PROCESSING CODE HERE */
    /////////////////////////////////

    for(;;) {
        imshow("img", imgGray);
        if(waitKey(30) >= 0) break;
    }

    return 0;
}
