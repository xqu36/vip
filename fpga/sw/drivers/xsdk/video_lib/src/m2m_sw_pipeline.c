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
* @file m2m_sw_pipeline.c
*
* This file implements the  interface for memory to memory sw processing pipeline.
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

#include "common.h"
#include "m2m_sw_pipeline.h"
#include "mediactl_helper.h"
#include "v4l2_helper.h"
#include "filter.h"

#include "opencv/cv.h"
#include "opencv2/highgui/highgui_c.h"

static struct m2m_sw_stream m2m_sw_stream_handle;

int init_m2m_sw_pipeline(struct video_pipeline *s, filter_func func)
{
	printf("[m2m_sw_pipeline] init_m2m_sw_pipeline started.\n");
	int ret = 0;
 	memset(&m2m_sw_stream_handle, 0, sizeof (struct m2m_sw_stream));

	/* Configure media pipelines */
	//set_media_control(s, MEDIA_NODE_1);

	/* Set v4l2 device name */
	ret = v4l2_parse_node(s->vid_dev, m2m_sw_stream_handle.video_in.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", s->vid_dev, ret);

	/* Initialize v4l2 video input device */
	m2m_sw_stream_handle.video_in.format.pixelformat = s->in_fourcc;
	m2m_sw_stream_handle.video_in.format.width = s->w;
	m2m_sw_stream_handle.video_in.format.height = s->h;
	m2m_sw_stream_handle.video_in.format.bytesperline = s->stride;
	m2m_sw_stream_handle.video_in.format.colorspace = s->colorspace;
	m2m_sw_stream_handle.video_in.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	m2m_sw_stream_handle.video_in.mem_type = V4L2_MEMORY_MMAP;
	m2m_sw_stream_handle.video_in.setup_ptr = s;

#ifdef DEBUG_MODE
	printf("[m2m_sw_pipeline] width = %u, height = %u, bytes per line = %u, 4cc = %.4s, color space = %u\n",
			   m2m_sw_stream_handle.video_in.format.width,
			   m2m_sw_stream_handle.video_in.format.height,
			   m2m_sw_stream_handle.video_in.format.bytesperline,
			   (char*) &m2m_sw_stream_handle.video_in.format.pixelformat,
			   m2m_sw_stream_handle.video_in.format.colorspace);
#endif

	/* Set processing function */
	m2m_sw_stream_handle.func = func;

	return VLIB_SUCCESS;
}

/* Process m2m sw pipeline input/output events .
TPG/External --> Software Processing -->DRM 
Video input device allocate buffer - mmap that to userspace
DRM allocate framebuffer  -mmap that to userspace
Software processing logic uses these handles for reading/writing
raw/processed video frames.
*/

void *process_m2m_sw_event_loop(void *ptr)
{
	printf("[m2m_sw_pipeline] sw pipeline started.\n");

	int ret=0,i=0;

	/* Initialize video input pipeline */
	ret = v4l2_init(&m2m_sw_stream_handle.video_in, BUFFER_CNT);
	ASSERT(ret < 0, "v4l2_init failed\n");

#ifdef DEBUG_MODE
	printf("[m2m_sw_pipeline] v4l2_init succeeded.\n");
#endif

	/* push cleanup handler */
	pthread_cleanup_push(uninit_m2m_sw_pipeline, ptr);

	for (i = 0; i < BUFFER_CNT; ++i)  {
	 	struct v4l2_buffer buffer;
		memset(&buffer, 0, sizeof(buffer));
		buffer.type =V4L2_BUF_TYPE_VIDEO_CAPTURE;
		buffer.memory = V4L2_MEMORY_MMAP;
		buffer.index = i;
		if (-1 == ioctl (m2m_sw_stream_handle.video_in.fd, VIDIOC_QUERYBUF, &buffer)) {
			perror("VIDIOC_QUERYBUF");
			exit(EXIT_FAILURE);
		}

		m2m_sw_stream_handle.video_in.vid_buf[i].v4l2_buff_length=buffer.length;


#ifdef DEBUG_MODE
		printf("[m2m_sw_pipeline] mmap to userspace\n");
#endif
		/* remember for munmap() */
		/* TODO: THIS is the user space mapping */
		m2m_sw_stream_handle.video_in.vid_buf[i].v4l2_buff = mmap(NULL,
				buffer.length, PROT_READ|PROT_WRITE, MAP_SHARED,
				m2m_sw_stream_handle.video_in.fd, buffer.m.offset);

		/* If you do not exit here you should unmap() and free()
		the buffers mapped so far. */

		ASSERT(MAP_FAILED == m2m_sw_stream_handle.video_in.vid_buf[i].v4l2_buff , "mmap failed ");
		m2m_sw_stream_handle.video_in.vid_buf[i].index = i;

	 }


	/* Assigning buffer index and set exported buff handle */
	for(i=0;i<BUFFER_CNT;i++) {
		v4l2_queue_buffer(&m2m_sw_stream_handle.video_in,
				& (m2m_sw_stream_handle.video_in.vid_buf[i]));
	}

	/* Start streaming */
#ifdef DEBUG_MODE
	printf("[m2m_sw_pipeline] turn v4l2 device on\n");
#endif
	ret = v4l2_device_on(& m2m_sw_stream_handle.video_in);
	ASSERT (ret < 0, "v4l2_device_on [video_in] failed %d \n",ret);

#ifdef DEBUG_MODE
		printf("vlib :: Video Capture Pipeline :: started !!\n");
#endif

	/* Set current buffer index */
	m2m_sw_stream_handle.current_buffer=-1;

	struct pollfd fds[] = {
		{.fd = m2m_sw_stream_handle.video_in.fd, .events = POLLIN},
	};

	unsigned int tpg_s2m_count=0;
	/* NOTE : VDMA doesn't issue EOF interrupt , as a result even on the first frame done,
            interrupt , it still updating it , current solution is to skip the first frame 
	    done notification */

	/* poll and pass buffers */
	while ((ret = poll(fds, ARRAY_SIZE(fds), POLL_TIMEOUT_MSEC)) > 0 ) {
		struct buffer *b;
		if (fds[0].revents & POLLIN) {
			if ( tpg_s2m_count != VDMA_SKIP_FRM_INDEX ){
				/* getting buffer FROM mmap memory */
				printf("DQBUF...");
				fflush(stdout);
					b = v4l2_dequeue_buffer(&m2m_sw_stream_handle.video_in,
							m2m_sw_stream_handle.video_in.vid_buf);
				printf("done!\n");

				printf("ptr = b->v4l2_buff...");
				fflush(stdout);
					unsigned char* ptr = b->v4l2_buff;
				printf("done!\n");

			   	// constructing OpenCV interface
				printf("cvCreateImageHeader...");
				fflush(stdout);
					IplImage* src_dma = cvCreateImageHeader(cvSize(m2m_sw_stream_handle.video_in.format.width,
														 m2m_sw_stream_handle.video_in.format.height),
														IPL_DEPTH_8U, 2);
				printf("done!\n");

				printf("src_dma->imageData = (char *)ptr...");
				fflush(stdout);
					src_dma->imageData = (char *)ptr;
					src_dma->widthStep = m2m_sw_stream_handle.video_in.format.bytesperline;
				printf("done!\n");

				printf("cvSplit & cvMerge...");
				fflush(stdout);
					IplImage* saveimg = cvCreateImage(cvGetSize(src_dma), src_dma->depth, 3);
					IplImage* c1 = cvCreateImage(cvGetSize(saveimg), saveimg->depth, 1);
					IplImage* c2 = cvCreateImage(cvGetSize(saveimg), saveimg->depth, 1);
					cvSplit(src_dma, c1, c2, NULL, NULL);
					cvMerge(c1, NULL, NULL, NULL, saveimg);
				printf("done!\n");

				printf("cvSaveImage...");
				fflush(stdout);
					ret = cvSaveImage("/home/c1.bmp", saveimg, 0);
				printf("done!\n");

				printf("cvReleaseImage...");
				fflush(stdout);
					cvReleaseImage(&src_dma);
					cvReleaseImage(&saveimg);
					cvReleaseImage(&c1);
					cvReleaseImage(&c2);
				printf("done!\n");

				if(tpg_s2m_count >= 30) {
					printf("Count is past 30, exiting...\n");
					break;
				}

				printf("QBUF...");
				fflush(stdout);
					v4l2_queue_buffer(&m2m_sw_stream_handle.video_in,b) ;
				printf("done!\n");
			}
			tpg_s2m_count++;
		}
	}
	printf("Cleaning up!\n");

	/* push cleanup handler */
	pthread_cleanup_pop(1);

	return VLIB_SUCCESS;
}

/* Un-init m2m sw pipeline ->unmap buffers,stop the video stream and close video device*/
void uninit_m2m_sw_pipeline(void *ptr)
{
	int i=0,ret=0;
	ret= v4l2_device_off(& m2m_sw_stream_handle.video_in);
	ASSERT(ret< 0 ,"v4l2_device stream-off failed \n");

	/* unmap v4l2 mapped buffer */
	for ( i=0;i< BUFFER_CNT ;i++) {
		munmap (m2m_sw_stream_handle.video_in.vid_buf[i].v4l2_buff,
				m2m_sw_stream_handle.video_in.vid_buf[i].v4l2_buff_length);
	}

	close(m2m_sw_stream_handle.video_in.fd);
}

