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
* @file video_lib.h
*
* This file provides video library interface. 
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

#ifndef VDF_LIB_H
#define VDF_LIB_H

#ifdef __cplusplus
extern "C"
{
#endif

#include "filter.h"

/* Default setup THIS MIGHT CHANGE @jdanner3*/
//#define OUTPUT_PIX_FMT v4l2_fourcc('M','J','P','G')
//#define INPUT_PIX_FMT  v4l2_fourcc('M','J','P','G')
//#define COLOR_SPACE  V4L2_COLORSPACE_SRGB
//#define BYTES_PER_PIXEL 3
#define OUTPUT_PIX_FMT v4l2_fourcc('Y','U','Y','V')
#define INPUT_PIX_FMT  v4l2_fourcc('Y','U','Y','V')
#define COLOR_SPACE  V4L2_COLORSPACE_SRGB
#define BYTES_PER_PIXEL 2
#define WRES 640
#define HRES 480

#define UVC
#define DEBUG_MODE
#define V4L2

/* Common interface  for video library*/

#define VIDEO_SRC_CNT 1

typedef enum
{
	VIDEO_SRC_UVC
} video_src;

typedef enum
{
	FILTER_MODE_OFF,
	FILTER_MODE_SW,
	FILTER_MODE_HW
} filter_mode;


#define BUFFER_CNT 3
#define MAX_BUFFER_CNT 5

#define VLIB_SUCCESS 0
#define VLIB_ERROR  -1


/* Initialize video library */
int vlib_init();
int vlib_uninit();

/* Setter/getter for output pipeline height*/
int vlib_set_active_height(int);
int vlib_get_active_height();

/* Setter/getter for output pipeline width*/
int vlib_set_active_width(int);
int vlib_get_active_width();

/* Stop the current running video input pipeline */
int vlib_pipeline_stop();

/* Configure video input and apply selected sobels modes */
int vlib_change_mode(video_src src, filter_func func, filter_mode mode);

/* Helper functions */
#define ERRSTR strerror(errno)
#define ASSERT(cond, ...) 					\
		do {							\
			if (cond) { 				\
				int errsv = errno;			\
				fprintf(stderr, "ERROR(%s:%d) : ",	\
						__FILE__, __LINE__);	\
				errno = errsv;				\
				fprintf(stderr,  __VA_ARGS__);		\
				abort();				\
			}						\
		} while(0)
#define WARN_ON(cond, ...) \
				((cond) ? warn(__FILE__, __LINE__, __VA_ARGS__) : 0)

#ifdef __cplusplus
}
#endif
#endif

