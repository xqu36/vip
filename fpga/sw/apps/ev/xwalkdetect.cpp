/*
 * xwalkdetect.cpp 
 * 
 * Main program with which to detect crosswalks/loiter zones
 *
 */
//
#include "opencv2/imgproc/imgproc.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/video/video.hpp>

#include <stdio.h>
#include <iostream>
#include <string>
#include <vector>

using namespace cv;
using namespace std;

int main() {

  /* IN */

  string infile = "/home/ableemer/vip/fpga/sw/apps/ev/klaus_low_snapshot2.JPG";

  VideoCapture capture(infile);

  string infile2 = "/home/ableemer/vip/fpga/sw/apps/ev/klaus_low_snapshot2_car2.JPG";

  VideoCapture carPath(infile2);

  string infile3 = "/home/ableemer/vip/fpga/sw/apps/ev/klaus_low_snapshot2_ppl2.JPG";

  VideoCapture pplPath(infile3);

  Mat frame, frame_r, frame_g, frame_b, avgframe, frame_bw, blur_frame, out_blur_frame, avg_background, out_avg_background, frame_diff, out_frame_diff, bk_frame, out_bk_frame;
  //Mat out_frame_r, out_frame_g, out_frame_b, frame_road, frame_road_bw;
  //Mat road_bw_otsu, road_bw_adapt_gauss, road_bw_adapt, centers;
  Mat carP, pplP, frame_r2, frame_g2, frame_b2, frame_r3, frame_g3, frame_b3;
  capture >> frame;
  carPath >> carP;
  pplPath >> pplP;
  imshow("carP", carP);

  //Mat frame_og = frame.clone();
  //frame = imread(infile, 1);

  if (!frame.data) { cout << "No image data." << endl; return -1; }
 //Split frame into red, green and blue images.
  Mat rgbSplit[3];
  Mat rgbSplit2[3];
  Mat rgbSplit3[3];
  //Mat rgbSplit2[3];
  split(carP, rgbSplit);
  split(pplP, rgbSplit2);
  split(frame, rgbSplit3);
  //rgbSplit2 = rgbSplit;
  /*threshold(rgbSplit[0], frame_r, 50, 255, THRESH_TOZERO);
  threshold(rgbSplit[1], frame_g, 50, 255, THRESH_TOZERO);
  threshold(rgbSplit[2], frame_b, 50, 255, THRESH_TOZERO);

  threshold(rgbSplit2[0], frame_r2, 50, 255, THRESH_TOZERO);
  threshold(rgbSplit2[1], frame_g2, 50, 255, THRESH_TOZERO);
  threshold(rgbSplit2[2], frame_b2, 50, 255, THRESH_TOZERO);  
*/
  frame_r = rgbSplit[0];
  frame_g = rgbSplit[1];
  frame_b = rgbSplit[2];

  frame_r2 = rgbSplit2[0];
  frame_g2 = rgbSplit2[1];
  frame_b2 = rgbSplit2[2];

  frame_r3 = rgbSplit3[0];
  frame_g3 = rgbSplit3[1];
  frame_b3 = rgbSplit3[2];

  int r = frame_r.rows;
  int c = frame_r.cols;
  for(int i = 0; i < r; i++){
    for(int j = 0; j < c; j++){
      if(frame_r.at<int>(i, j) == 0)
        if(frame_r2.at<int>(i, j) == 0){
        frame_r3.at<int>(i, j) = 0;
        frame_g3.at<int>(i, j) = 0;
        frame_b3.at<int>(i, j) = 0;
      }
      /*else if(frame_g.at<int>(i, j) != 0 || frame_g2.at<int>(i, j) != 0){
        frame_r3.at<int>(i, j) = 0;
        frame_g3.at<int>(i, j) = 0;
        frame_b3.at<int>(i, j) = 0;
      }
      else if(frame_b.at<int>(i, j) != 0 || frame_b2.at<int>(i, j) != 0){
        frame_r3.at<int>(i, j) = 0;
        frame_g3.at<int>(i, j) = 0;
        frame_b3.at<int>(i, j) = 0;
      }*/
    }
  }

  rgbSplit3[0]=frame_r3;
  rgbSplit3[1]=frame_g3;
  rgbSplit3[2]=frame_b3;

  merge(rgbSplit3, 3, frame);

  frame.convertTo(frame, CV_8U);
  imshow("people danger path?", frame);
  imwrite("/home/ableemer/vip/fpga/sw/apps/ev/dangerPath1.JPG", frame);


  /*//Split frame into red, green and blue images.
  Mat rgbSplit[3];
  //Mat rgbSplit2[3];
  split(frame, rgbSplit);
  //rgbSplit2 = rgbSplit;
  threshold(rgbSplit[0], frame_r, 32, 255, THRESH_TOZERO);
  threshold(frame_r, frame_r, 48, 255, THRESH_TOZERO_INV);
  threshold(rgbSplit[1], frame_g, 37, 255, THRESH_TOZERO);
  threshold(frame_g, frame_g, 58, 255, THRESH_TOZERO_INV);
  threshold(rgbSplit[2], frame_b, 30, 255, THRESH_TOZERO);
  threshold(frame_b, frame_b, 50, 255, THRESH_TOZERO_INV);

  int r = frame_r.rows;
  int c = frame_r.cols;
  for(int i = 0; i < r; i++){
    for(int j = 0; j < c; j++){
      if(frame_r.at<int>(i, j) == 0){
        frame_g.at<int>(i, j) = 0;
        frame_b.at<int>(i, j) = 0;
      }
      else if(frame_g.at<int>(i, j) == 0){
        frame_r.at<int>(i, j) = 0;
        frame_b.at<int>(i, j) = 0;
      }
      else if(frame_b.at<int>(i, j) == 0){
        frame_g.at<int>(i, j) = 0;
        frame_r.at<int>(i, j) = 0;
      }
    }
  }


  //cout << r << " " << c << endl;
  //cout << frame_r.rows << " " << frame_r.cols << endl;
  //cout << frame_g.rows << " " << frame_g.cols << endl;
  //cout << frame_b.rows << " " << frame_b.cols << endl;

  rgbSplit[0]=frame_r;
  rgbSplit[1]=frame_g;
  rgbSplit[2]=frame_b;
  merge(rgbSplit, 3, frame);

  imshow("frame post-thresh", frame);
*/
  /* PROCESSING */
    // Create black and white frame
    //cvtColor(frame, frame_bw, CV_BGR2GRAY);
    

    /* Thresh black and white image, morpho that image, blur black
        and white image, thresh that image to compare the two.
    //accumulateWeighted(frame_bw, avg_background, 0.05); //.05
    //frame_bw.convertTo(frame_bw, CV_32F);
    //absdiff(avg_background, frame_bw, frame_diff);
    threshold(frame_bw, bk_frame, 60, 255, THRESH_BINARY);
    */
    
  /*
MORPHOLOGICAL
  for(int j = 0; j < 3; j++){
    for(int i = 0; i < 3; i++){
          dilate(frame, frame, Mat(), Point(-1,-1), 2,1,1);
          erode(frame, frame, Mat(), Point(-1,-1), 2,1,1);
    }
    for(int i = 0; i < 3; i++){
          //dilate(frame, frame, Mat(), Point(-1,-1), 2,1,1);
          //erode(frame, frame, Mat(), Point(-1,-1), 2,1,1);
    }
  }
  cvtColor(frame, frame, CV_BGR2GRAY);
  frame.convertTo(frame, CV_8U);
  imshow("frame", frame);*/
/*
  Mat dist;
  distanceTransform(frame, dist, CV_DIST_L2, 3);
  normalize(dist, dist, 0, 1., NORM_MINMAX);
  //dist.convertTo(dist, CV_8U);
  //imshow("Distance Transform", dist);
  threshold(dist, dist, .25, 1., CV_THRESH_BINARY);
  Mat kernel = Mat::ones(3, 3, CV_8UC1);
  dilate(dist, dist, kernel);
  imshow("peaks", dist);
  //imwrite("/home/ableemer/vip/fpga/sw/apps/ev/distTransform.JPG", dist);
  Mat dist_8u;
  dist.convertTo(dist_8u, CV_8U);
  vector<vector<Point>> contours;
  findContours(dist_8u, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE);
  Mat markers = Mat::zeros(dist.size(), CV_32SC1);
  for(size_t i = 0; i< contours.size(); i++)
    drawContours(markers, contours, static_cast<int>(i), Scalar::all(static_cast<int>(i) + 1), -1);
  circle(markers, Point(5,5), 3, CV_RGB(255, 255, 255), -1);
  watershed(frame_og, markers);
  Mat mark = Mat::zeros(markers.size(), CV_8UC1);
  markers.convertTo(mark, CV_8UC1);
  bitwise_not(mark, mark);
  vector<Vec3b> colors;
  for(size_t i = 0; i < contours.size(); i++)
  {
    int b = theRNG().uniform(0,255);
    int g = theRNG().uniform(0,255);
    int r = theRNG().uniform(0,255);

    colors.push_back(Vec3b((uchar)b, (uchar)g, (uchar)r));
  }

  Mat dst = Mat::zeros(markers.size(), CV_8UC3);

  for(int i = 0; i < markers.rows; i++)
  {
    for(int j = 0; j < markers.cols; j++)
    {
      int index = markers.at<int>(i,j);
      if(index > 0 && index <= static_cast<int>(contours.size()))
        dst.at<Vec3b>(i, j) = colors[index - 1];
      else
        dst.at<Vec3b>(i, j) = Vec3b(0,0,0);
    }
  }
  imshow("Final Result", dst);
  imshow("OG frame", frame_og);
  imwrite("/home/ableemer/vip/fpga/sw/apps/ev/klaus_high_watershed25.JPG", dst);
  /*dist.convertTo(dist, CV_32S);
  watershed(frame_og, dist);
  dist.convertTo(dist, CV_8U);
  imshow("watershed", dist);
  */
  //imwrite("/home/ableemer/vip/fpga/sw/apps/ev/klaus_high_roadDetect.JPG", frame);
/*
    for(int i = 1; i < 10; i+=2){
      GaussianBlur(frame_bw, blur_frame, Size(i,i), 0, 0);
    }

    threshold(blur_frame, blur_frame, 60, 255, THRESH_BINARY);

    /*for(int i = 0; i < 10; i++){
          dilate(blur_frame, blur_frame, Mat(), Point(-1,-1), 2,1,1);
          //erode(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
    }
    for(int i = 0; i < 10; i++){
          //dilate(bk_frame, bk_frame, Mat(), Point(-1,-1), 2,1,1);
          erode(blur_frame, blur_frame, Mat(), Point(-1,-1), 2,1,1);
    }
    */

    //avg_background.convertTo(out_avg_background, CV_8U);
    //frame_diff.convertTo(out_frame_diff, CV_8U);

    /* Convert threshed and blurred frames to saveable/viewable
    bk_frame.convertTo(out_bk_frame, CV_8U);
    blur_frame.convertTo(out_blur_frame, CV_8U);
    */
    /*frame_r.convertTo(out_frame_r, CV_8U);
    frame_g.convertTo(out_frame_g, CV_8U);
    frame_b.convertTo(out_frame_b, CV_8U);

    merge(rgbSplit, 3, frame_road);
*/
    //cvtColor(frame, frame_road_bw, CV_BGR2GRAY);

    //threshold(frame_road_bw, road_bw_otsu, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);

    //threshold(frame_road_bw, frame_road_bw, 80, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
    //adaptiveThreshold(frame_road_bw, road_bw_adapt_gauss, 255, CV_ADAPTIVE_THRESH_GAUSSIAN_C, CV_THRESH_BINARY, 11, 2);

    //imwrite("/home/ableemer/vip/fpga/sw/apps/ev/hemphill_low_roadDetect.JPG", frame_road);
/*
    KMEANS
    Mat frame2 = frame;
    vector<Mat> channels;
    split(frame2, channels);
    equalizeHist(channels[0], channels[0]);
    merge(channels, frame2);

    frame2.convertTo(frame2, -1, 1.5, 0);
    imshow("contrast", frame2);

    //cvtColor(frame2, frame2, CV_YCrCb2BGR);

    //equalizeHist(dst, dst);
    
    Mat samples(frame2.rows * frame2.cols, 3, CV_32F);
    for( int y = 0; y < frame2.rows; y++ )
      for( int x = 0; x < frame2.cols; x++ )
        for( int z = 0; z < 3; z++)
          samples.at<float>(y + x*frame2.rows, z) = frame2.at<Vec3b>(y,x)[z];



    int clusterCount = 3;
    Mat labels;
    int attempts = 5;
    kmeans(samples, clusterCount, labels, TermCriteria(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 10000, 0.0001), attempts, KMEANS_PP_CENTERS, centers );


    Mat new_image( frame2.size(), frame2.type() );
    for( int y = 0; y < frame2.rows; y++ )
      for( int x = 0; x < frame2.cols; x++ )
      { 
        int cluster_idx = labels.at<int>(y + x*frame2.rows,0);
        new_image.at<Vec3b>(y,x)[0] = centers.at<float>(cluster_idx, 0);
        new_image.at<Vec3b>(y,x)[1] = centers.at<float>(cluster_idx, 1);
        new_image.at<Vec3b>(y,x)[2] = centers.at<float>(cluster_idx, 2);
      }
*/


    /* Save morpho/threshed image and blurred image
    imwrite("/home/ableemer/vip/fpga/sw/apps/ev/morpho_thresh.JPG", out_bk_frame);
    imwrite("/home/ableemer/vip/fpga/sw/apps/ev/gauss_thresh.JPG", out_blur_frame);
    */
    /*Mat label, center, res;
    //rgbSplit2.convertTo(rgbSplit2, CV_32F);
    Mat frame2 = frame.reshape((-1,3));
    frame2.convertTo(frame2, CV_32F);
    kmeans(frame2, 3, label, TermCriteria(TermCriteria::EPS + TermCriteria::COUNT, 10, 1.0), 3, KMEANS_RANDOM_CENTERS, center);
    cout << "label " << label.rows << " " << label.cols << endl;
    cout << "center " << center.rows << " " << center.cols << endl;
    //center.convertTo(center, CV_8U);
    cout << center << endl;
    cout << "center type " << center.type() << endl;
    Mat ret(frame2.size(), frame2.type());
    cout << "frame2 " << frame2.rows << " " << frame2.cols << endl;
    for(int y = 0; y < frame2.rows; y++)
      for(int x = 0; x < frame2.cols; x++)
      {
        //cout << "iteration start" << endl;
        int cluster_idx = x + frame2.cols*label.at<int>(y, 0);
        //cout << cluster_idx << " " << center.at<float>(0, cluster_idx) << " " << (uint8_t) round(center.at<float>(0, cluster_idx)) << endl;
        //cout << "cluster_idx " << cluster_idx << " " << center.at<float>(0, cluster_idx) << " " << center.at<float>(1, cluster_idx) << " " << center.at<float>(2, cluster_idx) << endl;
        //cout << "row " << y << " col " << x << " cluster_idx " << cluster_idx << endl;
        ret.at<Vec3b>(y,x)[0] = center.at<float>(0, cluster_idx);
        ret.at<Vec3b>(y,x)[1] = center.at<float>(1, cluster_idx);
        ret.at<Vec3b>(y,x)[2] = center.at<float>(2, cluster_idx);
        //cout << "iteration end" << endl;
      }
    //ret.convertTo(ret, CV_8U);*/  
    //imshow("kmeans", new_image);
    //imwrite("/home/ableemer/vip/fpga/sw/apps/ev/klausHigh_splitKmeans.JPG", new_image);
/*    imshow("frame_r", out_frame_r);
    imshow("frame_g", out_frame_g);
    imshow("frame_b", out_frame_b);
*/
    //imshow("frame_road", frame_road);
    //imshow("frame_road_bw", frame_road_bw);
    //imshow("road_bw_adapt_gauss", road_bw_adapt_gauss);
    //imshow("road_bw_otsu", road_bw_otsu);

    /* Show black and white, threshed and blurred frames.
    imshow("frame_bw", frame_bw);
    imshow("threshold", out_bk_frame);
    imshow("Gaussian Blur", out_blur_frame);
    */
  /*
   * YOUR CODE GOES HERE
   * 
   * 1) Threshold; color or b&w?
   * 2) Can you extract the road?
   * 3) Determine geometry of image (HoughLines)
   * 4) Find areas of high contrast in close proximity (repeating?)
   * 5) Given this info, can you find the crosswalk?
   * 6) With the crosswalk and road identifed, can you extract the loiter zones?
   *
   */ 

  /* OUT */
  //imshow("frame", frame);

  waitKey(0);
  return 0;
}

    
  
