/*
 * Util classes and methods
 *
 */

#include "utils.hpp"

VideoStats::VideoStats() {
  counter = 0;
  sec = 0;
  uptime_msec = 0;
  fps = 0.0;
  ifps = 0.0;

  width_res = 0;
  height_res = 0;

  // start Uptime timers
  time(&start);
  time(&end);

  // start msec Uptime timers
  gettimeofday(&mstart, 0);
}

void VideoStats::updateAverageFPS() {
  time(&end);
  counter++;  

  sec = difftime(end, start);
  fps = counter/sec;

  if(counter == (INT_MAX - 1000)){
    counter = 0;
  }
}

void VideoStats::prepareFPS() {
  istart = clock();
}

// this current impl ignores imshow and waitKey as part of its calculations
/*
void VideoStats::updateFPS() {
  iend = clock();

  ifps = 1 / ((iend - istart) / (double)CLOCKS_PER_SEC);
}
*/

double VideoStats::updateFPS() {
  iend = clock();

  ifps = 1 / ((iend - istart) / (double)CLOCKS_PER_SEC);
  return ifps;
}

void VideoStats::setWidth(int w) {
  width_res = w;
}

void VideoStats::setHeight(int h) {
  height_res = h;
}

int VideoStats::getWidth() {
  return width_res;
}

int VideoStats::getHeight() {
  return height_res;
}

void VideoStats::displayStats(string type, int result) {

  if(type == "average") sprintf(display, "%.2f average fps", fps);
  else if(type == "inst")  sprintf(display, "%.2f instant fps", ifps);

  cout << "\r[" 
      << width_res << "x" << height_res << "] - " 
      << setfill('0') << setw(17) << display
      << "\tUptime: " << sec << "s"
      << "\t[" << setfill('+') << setw(2) << result << "]" << flush;
}

int VideoStats::getCounter() {
  return counter;
}

double VideoStats::getUptime() {
  //time(&end);
  gettimeofday(&mend, 0);

  //sec = difftime(end, start);
  sec = mend.tv_sec - mstart.tv_sec;
  return sec;
}

void VideoStats::resetUptime() {
  time(&start);
}

double VideoStats::getMillisecUptime() {
  gettimeofday(&mend, 0);

  long seconds = mend.tv_sec - mstart.tv_sec;
  long useconds = mend.tv_usec - mstart.tv_usec;
  uptime_msec = ((seconds)*1000 + useconds/1000.0);
  return uptime_msec;
}

void VideoStats::openLog(string name) {
  log.open(name, ios::out);
}

void VideoStats::closeLog() {
  log.close();
}

void VideoStats::seekLog(ios_base::seekdir p) {
  log.seekp(0, p);
}

void VideoStats::prepareWriteLog() {
  _start = clock();
}

void VideoStats::writeLog(string func, int level) {
  _end = clock();

  msec = (_end - _start) / (double)CLOCKS_PER_SEC;

  switch(level) {
    case 0:
      log << func << ":" << setfill(' ') << setw(40 - func.size()) << msec*1000 << "ms" << endl;
      break;
    default:
      break;
  }
}

void VideoStats::getHeatMapColor(float value, float& red, float& green, float& blue)
{
  const int NUM_COLORS = 5;
  static float color[NUM_COLORS][3] = { {0,0,1}, {0,1,1}, {0,1,0}, {1,1,0}, {1,0,0} };
 
  int idx1;        // |-- Our desired color will be between these two indexes in "color".
  int idx2;        // |
  float fractBetween = 0;  // Fraction between "idx1" and "idx2" where our value is.
 
  if(value <= 0)      {  idx1 = idx2 = 0;            }    // accounts for an input <=0
  else if(value >= 1)  {  idx1 = idx2 = NUM_COLORS-1; }    // accounts for an input >=0
  else
  {
    value = value * (NUM_COLORS-1);        // Will multiply value by 3.
    idx1  = floor(value);                  // Our desired color will be after this index.
    idx2  = idx1+1;                        // ... and before this index (inclusive).
    fractBetween = value - float(idx1);    // Distance between the two indexes (0-1).
  }
 
  red   = (color[idx2][0] - color[idx1][0])*fractBetween + color[idx1][0];
  green = (color[idx2][1] - color[idx1][1])*fractBetween + color[idx1][1];
  blue  = (color[idx2][2] - color[idx1][2])*fractBetween + color[idx1][2];
}
