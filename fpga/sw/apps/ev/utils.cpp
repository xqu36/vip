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

// calculations in float 0-1
void getHeatMapColor(float value, float *red, float *green, float *blue)
{
  const int NUM_COLORS = 4;
  static float color[NUM_COLORS][3] = { {0,0,1}, {0,1,0}, {1,1,0}, {1,0,0} };
    // A static array of 4 colors:  (blue,   green,  yellow,  red) using {r,g,b} for each.
 
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
 
  *red   = (color[idx2][0] - color[idx1][0])*fractBetween + color[idx1][0];
  *green = (color[idx2][1] - color[idx1][1])*fractBetween + color[idx1][1];
  *blue  = (color[idx2][2] - color[idx1][2])*fractBetween + color[idx1][2];
}
