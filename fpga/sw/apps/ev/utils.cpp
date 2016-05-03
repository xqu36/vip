/*
 * Util classes and methods
 *
 */

#include "utils.hpp"

VideoStats::VideoStats() {
  counter = 0;
  sec = 0.0;
  fps = 0.0;

  width_res = 0;
  height_res = 0;

  time(&start);
  time(&end);
}

void VideoStats::updateFPS() {
  time(&end);
  counter++;  

  sec = difftime(end, start);
  fps = counter/sec;

  if(counter == (INT_MAX - 1000)){
    counter = 0;
  }
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

void VideoStats::displayStats() {
  sprintf(display, "%.2f fps", fps);
  cout << "\r[" 
       << width_res << "x" << height_res << "] - " 
       << display << "\tUptime: " << sec << flush;
}

int VideoStats::getCounter() {
  return counter;
}

double VideoStats::getUptime() {
  time(&end);

  sec = difftime(end, start);
  return sec;
}

void VideoStats::openLog() {
  log.open("perf.log", ios::out | ios::app);
}

void VideoStats::closeLog() {
  log.close();
}

void VideoStats::prepareWriteLog() {
  time(&_start);
}

void VideoStats::writeLog(string func, int level) {
  time(&_end);

  _sec = difftime(_end, _start);

  switch(level) {
    case 0:
      log << func << ":\t\t" << _sec*1000 << "ms" << endl;
      break;
    case 1:
      log << "--> " << func << ":\t\t" << _sec*1000 << "ms" << endl;
      break;
    case 2:
      log << "------> " << func << ":\t\t" << _sec*1000 << "ms" << endl;
      break;
    default:
      break;
  }
}
