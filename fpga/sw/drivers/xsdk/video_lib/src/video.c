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
* @file video_lib.c
*
*  This file implements video library interface. 
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


#include "video.h"
#include "common.h"
#include "m2m_sw_pipeline.h"
#include "m2m_hw_pipeline.h"
#include "mediactl_helper.h"

static struct video_pipeline *video_setup;

int vlib_init()
{
	printf("[video] vlib_init\n");
	int ret;

	/* Allocate video_setup struct and zero out memory */
	video_setup = calloc ( 1 ,sizeof (*video_setup));
	video_setup->app_state = MODE_INIT;
	video_setup->in_fourcc = INPUT_PIX_FMT;
	video_setup->out_fourcc = OUTPUT_PIX_FMT;
	video_setup->colorspace = COLOR_SPACE;

	/* Detect and configure HLS subdev */
	ret = v4l2_hls_init(&video_setup->subdev, XLNX_HLS_SOBEL_MODEL_NAME);

	return ret;
}

int vlib_set_active_height(int h)
{
	video_setup->h = h;
	return VLIB_SUCCESS;
}

int vlib_get_active_height()
{
	return video_setup->h;
}

int vlib_set_active_width(int w)
{
	video_setup->w = w;
	video_setup->stride = (video_setup->w * BYTES_PER_PIXEL);

	return VLIB_SUCCESS;
}

int vlib_get_active_width()
{
	return video_setup->w;
}

int vlib_pipeline_stop()
{
	int ret =VLIB_ERROR;
	/* Add cleanup code */
	if(video_setup->eventloop != 0) {
		/* Set application state */
		video_setup->app_state = MODE_EXIT;
		ret=pthread_cancel(video_setup->eventloop);
		ret= pthread_join(video_setup->eventloop,NULL);
#ifdef DEBUG_MODE
		printf("vlib_pipeline_stop (pthread_join):: %d \n",ret);
#endif
	}
	return ret;
}

int vlib_uninit()
{
	/* close HLS subdev */
	v4l2_hls_uninit(&video_setup->subdev);

	free (video_setup);
	return VLIB_SUCCESS;
}

int vlib_change_mode(video_src src, filter_func func, filter_mode mode)
{
	int ret=0;
	void *(*process_thread_fptr)(void *);

	/* Select input source */
	switch(src) {
	case VIDEO_SRC_UVC:
		video_setup->vid_dev = XLNX_UVC_DRIVER_NAME;
		break;
	default:
		printf("[info] :: No valid card/driver name found for selection\n");
		printf("[info] :: Continue with previous mode\n");
		return VLIB_ERROR;
	}

	if(video_setup->eventloop != 0) {
		/* Set application state */
		video_setup->app_state = MODE_CHANGE;
		/* Stop previous running mode if any */
		ret = pthread_cancel(video_setup->eventloop);
		ret = pthread_join(video_setup->eventloop, NULL);
	}

	/* Initialize filter mode */
	switch(mode) {
	case FILTER_MODE_SW:
		init_m2m_sw_pipeline(video_setup, func);
		process_thread_fptr = process_m2m_sw_event_loop;
		break;
	case FILTER_MODE_HW:
		init_m2m_hw_pipeline(video_setup);
		process_thread_fptr = process_m2m_hw_event_loop;
		break;
	default:
		ASSERT(1, "Invalid application mode!\n");
	}

	/* Start the processing loop */
	ret = pthread_create(&video_setup->eventloop, NULL, process_thread_fptr, video_setup);
	ASSERT( ret < 0 , "thread creation failed \n");

	return VLIB_SUCCESS;
}
