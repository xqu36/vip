//connected_components.h
#ifndef CONNECTED_COMPONENTS_H
#define CONNECTED_COMPONENTS_H
#include "segmentation.hpp"
#include <opencv2/core/core.hpp>
#include <memory>

class DisjointSet {
  private:
    std::vector<int> m_disjoint_array;
    int m_subset_num;
  public:
    DisjointSet();
    DisjointSet(int size);
    ~DisjointSet();
    int add(); //add a new element, which is a subset by itself;
    int find(int x); //return the root of x
    void unite(int x, int y);
    int getSubsetNum(void);
};

class ConnectedComponent {
private:
  cv::Rect m_bb;
  int m_pixel_count;
  std::shared_ptr< std::vector<cv::Point2i> > m_pixels;
public:
  ConnectedComponent();
  ConnectedComponent(int x, int y);
  ~ConnectedComponent();

  void addPixel(int x, int y);
  int getBoundingBoxArea(void) const;
  cv::Rect getBoundingBox(void) const;
  int getBoundingBoxWidth(void) const;
  int getBoundingBoxHeight(void) const;
  int getPixelCount(void) const;
  std::shared_ptr< const std::vector<cv::Point2i> > getPixels(void) const;
  cv::Mat getMask(int rows, int cols);
};

void findCC(const cv::Mat& src, std::vector<ConnectedComponent>& cc);
#endif //CONNECTED_COMPONENTS_H
