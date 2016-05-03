#ifndef UTILS_H
#define UTILS_H

/*
 * Class declarations
 *
 */

#include <iostream>
#include <fstream>
#include <cstdio>
#include <climits>

using namespace std;

class VideoStats {
private:
  int counter; 
  int width_res, height_res;

  double fps;
  double sec, _sec;

  char display[20];

  time_t start, end;
  time_t _start, _end;  // for writing to log

  ofstream log;

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
  void openLog();
  void closeLog();
  void prepareWriteLog();
  void writeLog(string func, int level);
};

#endif // UTILS_H
