/*
 * Util classes and methods
 *
 */

#include "utils.hpp"

VideoStats::VideoStats() {
  counter = 0;
  sec = 0.0;
  fps = 0.0;
  ifps = 0.0;

  width_res = 0;
  height_res = 0;

  time(&start);
  time(&end);
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
void VideoStats::updateFPS() {
  iend = clock();

  ifps = 1 / ((iend - istart) / (double)CLOCKS_PER_SEC);
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
  time(&end);

  sec = difftime(end, start);
  return sec;
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
