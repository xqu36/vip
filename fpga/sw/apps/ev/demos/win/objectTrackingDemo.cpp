/*
	Object Tracking Program
	--- to make this program work, download a video from PETS and replace 
		wherever you see "XXX.avi" with the file name of the video that you just downloaded
	--- The Gaussian Modeling right now is a blackbox as I am not sure how it was implemented (might want to look more into it)
	--- Also next step would be to count the people in the frames
*/


#include "opencv2\core\core.hpp"
#include <opencv2\imgproc\imgproc.hpp>
#include <opencv2\highgui\highgui.hpp>
#include <iostream>
#include <conio.h>
#include <opencv2\features2d\features2d.hpp>
#include <vector>




//Some constants for the algorithm
const double pi = 3.14;
const double alpha = 0.002;
const double cT = 0.05;
const double covariance0 = 11.0;
const double cf = 0.1;
const double cfbar = 1.0 - cf;
const double temp_thr = 9.0*covariance0*covariance0;
const double prune = -alpha*cT;
const double alpha_bar = 1.0 - alpha;

//Structure used for saving various components for each pixel
struct gaussian
{
	double mean[3], covariance;
	double weight;                              // Represents the measure to which a particular component defines the pixel value
	gaussian* Next;
	gaussian* Previous;
} *ptr, *start, *rear, *g_temp, *save, *next, *previous, *nptr, *temp_ptr;

struct Node
{
	gaussian* pixel_s;
	gaussian* pixel_r;
	int no_of_components;
	Node* Next;
} *N_ptr, *N_start, *N_rear;



//Initializes Functions
Node* Create_Node(double info1, double info2, double info3);
void Insert_End_Node(Node* np);
gaussian* Create_gaussian(double info1, double info2, double info3);

// Creates the node for the Gaussian
Node* Create_Node(double info1, double info2, double info3)
{
	N_ptr = new Node;
	if (N_ptr != NULL)
	{
		N_ptr->Next = NULL;
		N_ptr->no_of_components = 1;
		N_ptr->pixel_s = N_ptr->pixel_r = Create_gaussian(info1, info2, info3);
	}
	return N_ptr;
}

// creates the Gaussian
gaussian* Create_gaussian(double info1, double info2, double info3)
{
	ptr = new gaussian;
	if (ptr != NULL)
	{
		ptr->mean[0] = info1;
		ptr->mean[1] = info2;
		ptr->mean[2] = info3;
		ptr->covariance = covariance0;
		ptr->weight = alpha;
		ptr->Next = NULL;
		ptr->Previous = NULL;
	}
	return ptr;
}

// Function that inserts the end node for the gaussian
void Insert_End_Node(Node* np)
{
	if (N_start != NULL)
	{
		N_rear->Next = np;
		N_rear = np;
	}
	else
		N_start = N_rear = np;
}
// Function that inserts the end gaussian to terminate the gaussian
void Insert_End_gaussian(gaussian* nptr)
{
	if (start != NULL)
	{
		rear->Next = nptr;
		nptr->Previous = rear;
		rear = nptr;
	}
	else
		start = rear = nptr;
}

// Function that deltes the Gaussian
gaussian* Delete_gaussian(gaussian* nptr)
{
	previous = nptr->Previous;
	next = nptr->Next;
	if (start != NULL)
	{
		if (nptr == start && nptr == rear)
		{
			start = rear = NULL;
			delete nptr;
		}
		else if (nptr == start)
		{
			next->Previous = NULL;
			start = next;
			delete nptr;
			nptr = start;
		}
		else if (nptr == rear)
		{
			previous->Next = NULL;
			rear = previous;
			delete nptr;
			nptr = rear;
		}
		else
		{
			previous->Next = next;
			next->Previous = previous;
			delete nptr;
			nptr = next;
		}
	}
	else
	{
		std::cout << "Underflow........";
		_getch();
		exit(0);
	}
	return nptr;
}

void main()
{
	int i, j, k;
	i = j = k = 0;

	// Declare matrices to store original and resultant binary image
	cv::Mat orig_img, bin_img;

	//Declare a VideoCapture object to store incoming frame and initialize it
	cv::VideoCapture capture("XXX.avi");

	//Recieveing input from the source and converting it to grayscale
	capture.read(orig_img);
	cv::resize(orig_img, orig_img, cv::Size(340, 260));
	cv::cvtColor(orig_img, orig_img, CV_BGR2YCrCb);

	//Initializing the binary image with the same dimensions as original image
	bin_img = cv::Mat(orig_img.rows, orig_img.cols, CV_8U, cv::Scalar(0));


	//Step 1: initializing with one gaussian for the first time and keeping the no. of models as 1
	cv::Vec3f val;
	uchar* rowPtr;
	uchar* binaryPtr;
	// loops through original image so that the gaussian can be calculated for the background
	for (i = 0; i <orig_img.rows; i++) {
		rowPtr = orig_img.ptr(i);
		for (j = 0; j<orig_img.cols; j++) {
			// calls the Create_Node to actually create the gaussian node
			N_ptr = Create_Node(*rowPtr, *(rowPtr + 1), *(rowPtr + 2));
			if (N_ptr != NULL){
				N_ptr->pixel_s->weight = 1.0;
				Insert_End_Node(N_ptr);
			}
			else {
				std::cout << "Memory limit reached... ";
				_getch();
				exit(0);
			}
		}
	}
	// reads in the image
	capture.read(orig_img);

	int rowLength, rowColumns;
	// makes sure the image is continuous and initialize length and row of Gaussian
	if (orig_img.isContinuous() == true)
	{
		rowLength = 1;
		rowColumns = orig_img.rows*orig_img.cols*orig_img.channels();
	}

	else
	{
		rowLength = orig_img.rows;
		rowColumns = orig_img.cols*orig_img.channels();
	}

	// temporary variables for modeling each pixel with Gaussian
	double  mal_dist;
	double sum = 0.0;
	bool close = false;
	int background;
	double mult;
	double temp_cov = 0.0;
	double weight = 0.0;
	double var = 0.0;
	double muR, muG, muB, dR, dG, dB, rVal, gVal, bVal;

	//Step 2: Modelling each pixel with Gaussian
	// converts it to binary
	bin_img = cv::Mat(orig_img.rows, orig_img.cols, CV_8UC1, cv::Scalar(0));
	while (1)
	{
		if (!capture.read(orig_img)){
			break;
			capture.release();
			// captures the video from PETS
			capture = cv::VideoCapture("XXX.avi");
			capture.read(orig_img);
		}
		// For loop that computes the Gaussian ---not quite sure how it works
		N_ptr = N_start;
		for (i = 0; i< rowLength; i++)
		{
			rowPtr = orig_img.ptr(i);
			binaryPtr = bin_img.ptr(i);
			for (j = 0; j<rowColumns; j += 3)
			{
				sum = 0.0;
				close = false;
				background = 0;


				rVal = *(rowPtr++);
				gVal = *(rowPtr++);
				bVal = *(rowPtr++);

				start = N_ptr->pixel_s;
				rear = N_ptr->pixel_r;
				ptr = start;

				temp_ptr = NULL;

				if (N_ptr->no_of_components > 4)
				{
					Delete_gaussian(rear);
					N_ptr->no_of_components--;
				}

				for (k = 0; k<N_ptr->no_of_components; k++)
				{


					weight = ptr->weight;
					mult = alpha / weight;
					weight = weight*alpha_bar + prune;
					if (close == false)
					{
						muR = ptr->mean[0];
						muG = ptr->mean[1];
						muB = ptr->mean[2];

						dR = rVal - muR;
						dG = gVal - muG;
						dB = bVal - muB;
						var = ptr->covariance;

						mal_dist = (dR*dR + dG*dG + dB*dB);

						if ((sum < cfbar) && (mal_dist < 16.0*var*var))
							background = 255;

						if (mal_dist < 9.0*var*var)
						{
							weight += alpha;
							close = true;

							ptr->mean[0] = muR + mult*dR;
							ptr->mean[1] = muG + mult*dG;
							ptr->mean[2] = muB + mult*dB;
							temp_cov = var + mult*(mal_dist - var);
							ptr->covariance = temp_cov<5.0 ? 5.0 : (temp_cov>20.0 ? 20.0 : temp_cov);
							temp_ptr = ptr;
						}

					}

					if (weight < -prune)
					{
						ptr = Delete_gaussian(ptr);
						weight = 0;
						N_ptr->no_of_components--;
					}
					else
					{
						sum += weight;
						ptr->weight = weight;
					}
					ptr = ptr->Next;
				}
				if (close == false)
				{
					ptr = new gaussian;
					ptr->weight = alpha;
					ptr->mean[0] = rVal;
					ptr->mean[1] = gVal;
					ptr->mean[2] = bVal;
					ptr->covariance = covariance0;
					ptr->Next = NULL;
					ptr->Previous = NULL;
					if (start == NULL)
						start = rear = NULL;
					else
					{
						ptr->Previous = rear;
						rear->Next = ptr;
						rear = ptr;
					}
					temp_ptr = ptr;
					N_ptr->no_of_components++;
				}

				ptr = start;
				while (ptr != NULL)
				{
					ptr->weight /= sum;
					ptr = ptr->Next;
				}

				while (temp_ptr != NULL && temp_ptr->Previous != NULL)
				{
					if (temp_ptr->weight <= temp_ptr->Previous->weight)
						break;
					else
					{
						next = temp_ptr->Next;
						previous = temp_ptr->Previous;
						if (start == previous)
							start = temp_ptr;
						previous->Next = next;
						temp_ptr->Previous = previous->Previous;
						temp_ptr->Next = previous;
						if (previous->Previous != NULL)
							previous->Previous->Next = temp_ptr;
						if (next != NULL)
							next->Previous = previous;
						else
							rear = previous;
						previous->Previous = temp_ptr;
					}
					temp_ptr = temp_ptr->Previous;
				}
				N_ptr->pixel_s = start;
				N_ptr->pixel_r = rear;

				*binaryPtr++ = background;

				N_ptr = N_ptr->Next;
			}
		}
		// shows the videos
		cv::imshow("Actual Video", orig_img);
		cv::imshow("Binary Video", bin_img);
		if (cv::waitKey(1)>0)
			break;
	}
	_getch();
}
