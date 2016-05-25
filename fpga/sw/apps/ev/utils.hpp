#ifndef UTILS_H
#define UTILS_H

/*
 * Class declarations
 *
 */

#include <iostream>
#include <cstdio>
#include <climits>
#include <math.h>

using namespace std;

class VideoStats {
private:
  int counter; 
  int width_res, height_res;

  double fps;
  double sec;

  char display[20];

  time_t start, end;

public:
  VideoStats();
  void updateFPS();
  void setWidth(int w);
  void setHeight(int h);
  int getWidth();
  int getHeight();
  void displayStats();
  int getCounter();
  double getUptime();
  void getHeatMapColor(float value, float* red, float* green, float* blue);
};

#endif // UTILS_H
