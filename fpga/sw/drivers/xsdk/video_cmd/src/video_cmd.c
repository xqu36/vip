/******************************************************************************
*
* (c) Copyright 2012-2014 Xilinx, Inc. All rights reserved.
*
* This file contains confidential and proprietary information of Xilinx, Inc.
* and is protected under U.S. and international copyright and other
* intellectual property laws.
*
* DISCLAIMER
* This disclaimer is not a license and does not grant any rights to the
* materials distributed herewith. Except as otherwise provided in a valid
* license issued to you by Xilinx, and to the maximum extent permitted by
* applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
* FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
* IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
* MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
* and (2) Xilinx shall not be liable (whether in contract or tort, including
* negligence, or under any other theory of liability) for any loss or damage
* of any kind or nature related to, arising under or in connection with these
* materials, including for any direct, or any indirect, special, incidental,
* or consequential loss or damage (including loss of data, profits, goodwill,
* or any type of loss or damage suffered as a result of any action brought by
* a third party) even if such damage or loss was reasonably foreseeable or
* Xilinx had been advised of the possibility of the same.
*
* CRITICAL APPLICATIONS
* Xilinx products are not designed or intended to be fail-safe, or for use in
* any application requiring fail-safe performance, such as life-support or
* safety devices or systems, Class III medical devices, nuclear facilities,
* applications related to the deployment of airbags, or any other applications
* that could lead to death, personal injury, or severe property or
* environmental damage (individually and collectively, "Critical
* Applications"). Customer assumes the sole risk and liability of any use of
* Xilinx products in Critical Applications, subject only to applicable laws
* and regulations governing limitations on product liability.
*
* THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
* AT ALL TIMES.
*
*******************************************************************************/

/*****************************************************************************
*
* @file video_cmd.c
*
* This file implements command line interface for Zynq Base TRD .
* 
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date        Changes
* ----- ---- -------- -------------------------------------------------------
* 1.00a RSP   14/07/14 Initial release
* </pre>
*
* @note
*
******************************************************************************/


#include <stdio.h>
#include <getopt.h>
#include <errno.h>
#include <stdlib.h>

#include "video.h"

#ifdef OPENCV_C
#include "opencv/cv.h"
#include "opencv2/highgui/highgui_c.h"
#endif

#ifdef OPENCV_CPP
#include "filter.h"
#endif

typedef enum {
	MENU_EXIT,
	MENU_STREAM
} menu;

int getInput(void)
{
	int ch;
	int ret = -1;

	ch = getchar();

	if (ch >= '0' && ch <= '9')
		ret = ch - '0';

	while ((ch = getchar()) != '\n' && ch != EOF);

	return ret;
}

int main(int argc, char *argv[])
{
	int choice = -1;

#ifdef V4L2
	filter_mode mode = FILTER_MODE_HW;
	filter_func func = FILTER_FUNC_SOBEL;
	video_src src = VIDEO_SRC_UVC;

	// Initialize video library
	vlib_init();
	vlib_set_active_height(HRES);
	vlib_set_active_width(WRES);
#endif

#ifdef OPENCV_C
	CvCapture* cap;
	int vinterface = 2;
	printf("Opening capture on video interface %d...", vinterface);
	fflush(stdout);
		cap = cvCaptureFromCAM(vinterface);
	printf("done!\n");
	IplImage* frame
#endif

	/* Main control menu */
	do {
		printf("------------- Menu Application -----------------\n");
		printf("%d -> Stream USB\n\n", MENU_STREAM);
		printf("------------- Exit Application -----------------\n");
		printf("%d -> Exit\n\n", MENU_EXIT);

		choice = getInput();

		switch(choice) {
		case MENU_EXIT:
#ifdef V4L2
			printf("Exiting v4l2...");
			fflush(stdout);
				vlib_pipeline_stop();
				vlib_uninit();
			printf("done!\n");
#endif

#ifdef OPENCV_C
			printf("Releasing capture...");
			fflush(stdout);
				cvReleaseCapture(&cap);
			printf("done!\n");
#endif
			printf("Exiting application.\n");
			exit(0);
		case MENU_STREAM:
#ifdef V4L2
			printf("Starting v4l2 application...\n");
			// Start default src/mode
			vlib_change_mode(src, func, mode);
#endif

#ifdef OPENCV_C
			printf("Starting C application...\n");
			for(;;) {
				printf("Attempting to read frame...");
				fflush(stdout);
					frame = cvQueryFrame(cap);
				printf("done!\r");
				fflush(stdout);

				char c = cvWaitKey(30);
				if(c == 27) printf("***** ESC received *****\n"); break;
			}
#endif

#ifdef OPENCV_CPP
			printf("Starting CPP application...\n");
			opencv_func();
#endif
			break;
		default:
			printf("\n\n ********* Invalid input, Please try Again ***********\n");
			continue;
		}
	} while (choice != 0);

	return 0;
}
