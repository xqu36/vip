#include "opencv2/core/core.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>

using namespace cv;
using namespace std;
int main() {
    Mat imgPrevious;
    Mat output;
        VideoCapture cap(0); //capture the video from web cam

        if (!cap.isOpened())  // if not success, exit program
        {
            cout << "Cannot open the web cam" << endl;
            return -1;
        }
       
        bool test = true;

        while (true)
        {
            Mat imgOriginal;

            bool bSuccess = cap.read(imgOriginal); // read a new frame from video
            
            if (!bSuccess) //if not success, break loop
            {
                cout << "Cannot read a frame from video stream" << endl;
                break;
            }
            /*Handles the edge case of the first frame read (if its the first frame, set previous as original frame)*/
            if (test){
                imgPrevious = imgOriginal.clone();
                test = false;
            }

            Mat imgHSV;

            cvtColor(imgOriginal, imgHSV, COLOR_RGB2GRAY); //Convert the captured frame from BGR to HSV

            absdiff(imgOriginal, imgPrevious, output); // take the absolute difference and save it as the variable ouput
            imshow("Original", imgOriginal); //show the original image
            imshow("Output", output); // show the output
            imgPrevious = imgOriginal; // save the previous frame as the current frame

            if (waitKey(30) == 27) //wait for 'esc' key press for 30ms. If 'esc' key is pressed, break loop
            {
                cout << "esc key is pressed by user" << endl;
                break;
            }
        }

        return 0;

    
}

