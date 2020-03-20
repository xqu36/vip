//Contours

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/video/video.hpp>


#include <stdio.h>
#include <iostream>
#include <string>


using namespace cv;
using namespace std;

int main(int argc, char const *argv[])
{
	RNG rng(12345);
	//int thresh = 100;
	//int max_thresh = 255;
	//load image
	Mat frame; Mat frame_gray;
	frame = imread("/home/mia/Desktop/EV/penguin.jpg");
	//printf("%s\n", frame.channels());
	Mat dst = Mat::zeros(frame.rows, frame.cols, CV_8UC3);
    
    //Convert image to gray and blur it
    cvtColor(frame, frame_gray, CV_BGR2GRAY);
    blur(frame_gray, frame_gray, Size(3,3));
	
	//frame = frame > 1;
	namedWindow("Original Frame", WINDOW_NORMAL);
	imshow("Original Frame", frame_gray);

	//countours- detected contours, each contour stored as vector of points
	vector<vector<Point> > contours;
	//heirarchy optional output vector
	//information about image topology
	vector<Vec4i> heirarchy;

	findContours(frame_gray, contours, heirarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE  );


	for(int idx = 0;idx < contours.size(); idx++) {
		Scalar color = Scalar( rng.uniform(0, 255), rng.uniform(0,255), rng.uniform(0,255) );
		drawContours( dst, contours, idx, color, CV_RETR_EXTERNAL, 8, heirarchy);
	}
	namedWindow("Contours", WINDOW_NORMAL);
	imshow("Contours", dst);
	waitKey(0);
	return 0;
}

// opencv_source_code/samples/cpp/contours2.cpp