#ifndef UTILS_H
#define UTILS_H

/*
 * Class declarations
 *
 */

#include <iostream>
#include <iomanip>
#include <fstream>
#include <cstdio>
#include <climits>
#include <time.h>

using namespace std;

class VideoStats {
private:
  int counter; 
  int width_res, height_res;

  double fps, ifps;
  double sec, msec, imsec;

  char display[20];

  time_t start, end;
  clock_t _start, _end;
  clock_t istart, iend;

  ofstream log;

public:
  VideoStats();
  void updateAverageFPS();
  void prepareFPS();
  void updateFPS();
  void setWidth(int w);
  void setHeight(int h);
  int getWidth();
  int getHeight();
  void displayStats(string type, int result);
  int getCounter();
  double getUptime();
  void openLog();
  void closeLog();
  void seekLog(ios_base::seekdir p);
  void prepareWriteLog();
  void writeLog(string func, int level);
};

#endif // UTILS_H
