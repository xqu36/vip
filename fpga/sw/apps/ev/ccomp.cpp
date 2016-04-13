//connected_components.cpp
#include "ccomp.hpp"

using namespace std;
/** DisjointSet **/
DisjointSet::DisjointSet() :
  m_disjoint_array(),
  m_subset_num(0)
{  }

DisjointSet::DisjointSet(int size) :
  m_disjoint_array(),
  m_subset_num(0)
{
  m_disjoint_array.reserve(size);
}

DisjointSet::~DisjointSet()
{  }

//add a new element, which is a subset by itself;
int DisjointSet::add()
{
  int cur_size = m_disjoint_array.size();
  m_disjoint_array.push_back(cur_size);
  m_subset_num ++;
  return cur_size;
}
//return the root of x
int DisjointSet::find(int x)
{
  if (m_disjoint_array[x] < 0 || m_disjoint_array[x] == x)
    return x;
  else {
    m_disjoint_array[x] = this->find(m_disjoint_array[x]);
    return m_disjoint_array[x];
  }
}
// point the x and y to smaller root of the two
void DisjointSet::unite(int x, int y)
{
  if (x==y) {
    return;
  }
  int xRoot = find(x);
  int yRoot = find(y);
  if (xRoot == yRoot)
    return;
  else if (xRoot < yRoot) {
    m_disjoint_array[yRoot] = xRoot;
  }
  else {
    m_disjoint_array[xRoot] = yRoot;
  }
  m_subset_num--;
}

int DisjointSet::getSubsetNum()
{
  return m_subset_num;
}

/** ConnectedComponent **/
ConnectedComponent::ConnectedComponent() :
  m_bb(0,0,0,0),
  m_pixel_count(0),
  m_pixels()
{
  m_pixels = std::make_shared< std::vector<cv::Point2i> > ();
}

ConnectedComponent::ConnectedComponent(int x, int y) :
  m_bb(x,y,1,1),
  m_pixel_count(1),
  m_pixels()
{
  m_pixels = std::make_shared< std::vector<cv::Point2i> > ();
}

ConnectedComponent::~ConnectedComponent(void)
{ }

void ConnectedComponent::addPixel(int x, int y) {
  m_pixel_count++;
  // new bounding box;
  if (m_pixel_count == 0) {
    m_bb = cv::Rect(x,y,1,1);
  }
  // extend bounding box if necessary
  else {
    if (x < m_bb.x ) {
      m_bb.width+=(m_bb.x-x);
      m_bb.x = x;
    }
    else if ( x > (m_bb.x+m_bb.width) ) {
      m_bb.width=(x-m_bb.x);
    }
    if (y < m_bb.y ) {
      m_bb.height+=(m_bb.y-y);
      m_bb.y = y;
    }
    else if ( y > (m_bb.y+m_bb.height) ) {
      m_bb.height=(y-m_bb.y);
    }
  }
  m_pixels->push_back(cv::Point(x,y));
}

int ConnectedComponent::getBoundingBoxArea(void) const {
  return (m_bb.width*m_bb.height);
}

int ConnectedComponent::getBoundingBoxWidth(void) const {
  return m_bb.width;
}

int ConnectedComponent::getBoundingBoxHeight(void) const {
  return m_bb.height;
}

cv::Rect ConnectedComponent::getBoundingBox(void) const {
  return m_bb;
}

std::shared_ptr< const std::vector<cv::Point2i> > ConnectedComponent::getPixels(void) const {
  return m_pixels;
}

// @jdanner3
cv::Mat ConnectedComponent::getMask(int rows, int cols){
    cv::Mat mask = cv::Mat::zeros(rows, cols, CV_8UC1);

    vector< cv::Point2i >::iterator it = m_pixels->begin();
    while(it != m_pixels->end()) {
        mask.at<unsigned char>(*it) = 0xff;
        *it++;
    }
    return mask;
}

// @jdanner3
cv::Point ConnectedComponent::getCentroidBox(void) {
  return cv::Point(m_bb.x+(m_bb.width/2) , m_bb.y+(m_bb.height/2));
}

// @jdanner3
cv::Point ConnectedComponent::getCentroidExact(cv::Mat mask) {
  int maxRow;
  int maxCol;

  //find max pixel per row
  int maxPixelPerRow = 0;
  for(int k = 0; k<mask.rows; k++) {
    int numofPixPerRow = 0;

    for(int j = 0; j<mask.cols; j++){
      if(mask.at<unsigned char>(k,j) == 0xff){
        numofPixPerRow++;
      }
    }
    if(numofPixPerRow > maxPixelPerRow){
      maxPixelPerRow = numofPixPerRow;
      maxRow = k;
    }
  }

  //find max pixel for col
  int maxPixelPerCol = 0;
  for(int m= 0; m<mask.cols; m++){
    int numofPixPerCol = 0;
    for(int n=0; n<mask.rows; n++){
      if(mask.at<unsigned char>(n,m) == 0xff){
        numofPixPerCol++;
      }
    }
    if(numofPixPerCol > maxPixelPerCol){
      maxPixelPerCol = numofPixPerCol;
      maxCol = m;
    }
  }

  return cv::Point(maxCol, maxRow);
}

int ConnectedComponent::getPixelCount(void) const {
  return m_pixel_count;
}

/** find connected components **/

void findCC(const cv::Mat& src, std::vector<ConnectedComponent>& cc) {
  if (src.empty()) return;
  CV_Assert(src.type() == CV_8U);
  cc.clear();
  int total_pix = src.total();
  int frame_label[total_pix];
  DisjointSet labels(total_pix);
  int root_map[total_pix];
  int x, y;
  const uchar* cur_p;
  const uchar* prev_p = src.ptr<uchar>(0);
  int left_val, up_val;
  int cur_idx, left_idx, up_idx;
  cur_idx = 0;
  //first logic loop
  for (y = 0; y < src.rows; y++ ) {
    cur_p = src.ptr<uchar>(y);
    for (x = 0; x < src.cols; x++, cur_idx++) {
      left_idx = cur_idx - 1;
      up_idx = cur_idx - src.size().width;
      if ( x == 0)
        left_val = 0;
      else
        left_val = cur_p[x-1];
      if (y == 0)
        up_val = 0;
      else
        up_val = prev_p[x];
      if (cur_p[x] > 0) {
        //current pixel is foreground and has no connected neighbors
        if (left_val == 0 && up_val == 0) {
          frame_label[cur_idx] = (int)labels.add();
          root_map[frame_label[cur_idx]] = -1;
        }
        //current pixel is foreground and has left neighbor connected
        else if (left_val != 0 && up_val == 0) {
          frame_label[cur_idx] = frame_label[left_idx];
        }
        //current pixel is foreground and has up neighbor connect
        else if (up_val != 0 && left_val == 0) {
          frame_label[cur_idx] = frame_label[up_idx];
        }
        //current pixel is foreground and is connected to left and up neighbors
        else {
          frame_label[cur_idx] = (frame_label[left_idx] > frame_label[up_idx]) ? frame_label[up_idx] : frame_label[left_idx];
          labels.unite(frame_label[left_idx], frame_label[up_idx]);
        }
      }//endif
      else {
        frame_label[cur_idx] = -1;
      }
    } //end for x
    prev_p = cur_p;
  }//end for y
  //second loop logic
  cur_idx = 0;
  int curLabel;
  int connCompIdx = 0;
  for (y = 0; y < src.size().height; y++ ) {
    for (x = 0; x < src.size().width; x++, cur_idx++) {
      curLabel = frame_label[cur_idx];
      if (curLabel != -1) {
        curLabel = labels.find(curLabel);
        if( root_map[curLabel] != -1 ) {
          cc[root_map[curLabel]].addPixel(x, y);
        }
        else {
          cc.push_back(ConnectedComponent(x,y));
          root_map[curLabel] = connCompIdx;
          connCompIdx++;
        }
      }
    }//end for x
  }//end for y
}
