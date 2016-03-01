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
* @file m2m_hw_pipeline.c
*
* This file implements the  interface for memory to memory hw processing pipeline.
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
#include "m2m_hw_pipeline.h"
#include "v4l2_helper.h"
#include "mediactl_helper.h"

static struct m2m_hw_stream m2m_hw_stream_handle;

int init_m2m_hw_pipeline(struct video_pipeline *s)
{
	int ret = 0;

	memset(&m2m_hw_stream_handle, 0, sizeof (struct m2m_hw_stream));

	/* Configure media pipelines */
	set_media_control(s, MEDIA_NODE_1);

	/* Set v4l2 device names */
	/* UVCVIDEO */
	ret = v4l2_parse_node(s->vid_dev, m2m_hw_stream_handle.video_in.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", s->vid_dev, ret);

	/* TODO CARD NAMES */
	ret = v4l2_parse_node(XLNX_SOBEL_IN_CARD_NAME, m2m_hw_stream_handle.video_post_process_in.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", XLNX_SOBEL_IN_CARD_NAME, ret);

	ret = v4l2_parse_node(XLNX_SOBEL_OUT_CARD_NAME, m2m_hw_stream_handle.video_post_process_out.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", XLNX_SOBEL_OUT_CARD_NAME, ret);

	/* Initialize v4l2 video input device */
	m2m_hw_stream_handle.video_in.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_in.format.width = s->w;
	m2m_hw_stream_handle.video_in.format.height = s->h;
	m2m_hw_stream_handle.video_in.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_in.format.colorspace = s->colorspace;
	m2m_hw_stream_handle.video_in.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	m2m_hw_stream_handle.video_in.mem_type =V4L2_MEMORY_DMABUF ;
	m2m_hw_stream_handle.video_in.setup_ptr = s;

	/* Initialize v4l2 video sobel-in device */
	m2m_hw_stream_handle.video_post_process_in.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_post_process_in.format.width = s->w;
	m2m_hw_stream_handle.video_post_process_in.format.height = s->h;
	m2m_hw_stream_handle.video_post_process_in.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_post_process_in.format.colorspace = s->colorspace;
	m2m_hw_stream_handle.video_post_process_in.buf_type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
	m2m_hw_stream_handle.video_post_process_in.mem_type = V4L2_MEMORY_MMAP;

	/* Initialize v4l2 video sobel-out device*/
	m2m_hw_stream_handle.video_post_process_out.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_post_process_out.format.width = s->w;
	m2m_hw_stream_handle.video_post_process_out.format.height = s->h;
	m2m_hw_stream_handle.video_post_process_out.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_post_process_out.format.colorspace = s->colorspace;
	m2m_hw_stream_handle.video_post_process_out.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	m2m_hw_stream_handle.video_post_process_out.mem_type = V4L2_MEMORY_DMABUF;

	return VLIB_SUCCESS;
}

/* Video input device allocate buffer - mmap that to userspace
Sobel input device re-uses that buffer using v4l2 export buffer interface.
DRM allocate framebuffer.
Sobel output device re-uses that buffer using DMA buffer sharing mechanism.
*/
void *process_m2m_hw_event_loop(void *ptr)
{
	int i = 0 , ret = 0;
	struct v4l2_exportbuffer eb;

	/* Initialize capture pipeline */
	/* GETS BUFFER FROM V4L2 CAM */
	ret = v4l2_init(&m2m_hw_stream_handle.video_in, BUFFER_CNT);
	ASSERT(ret < 0, "v4l2_init failed (video in)\n");

	/* Initialize hls processing pipeline */
	/* SHOULD BE SAME VDMA, JUST TWO STREAMS */
	ret = v4l2_init(&m2m_hw_stream_handle.video_post_process_in, BUFFER_CNT);
	ASSERT(ret < 0, "v4l2_init failed (post process in)\n");
	ret = v4l2_init(&m2m_hw_stream_handle.video_post_process_out, BUFFER_CNT);
	ASSERT(ret < 0, "v4l2_init failed (post process out)\n");

	/* push cleanup handler */
	pthread_cleanup_push(uninit_m2m_hw_pipeline, ptr);

	/* Assigning buffer index and set exported buff handle */
	for(i=0;i<BUFFER_CNT;i++) {
		m2m_hw_stream_handle.video_in.vid_buf[i].index =i ;
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].index=i;
		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].index =i;

		/* Assign DRM buffer buff-sharing handle */
		/* TODO: @jdanner3 -- mmap back to userspace? */

		/* export buffer for sharing buffer between two v4l2 devices*/
		memset(&eb, 0, sizeof(eb));
		eb.type = m2m_hw_stream_handle.video_post_process_in.buf_type;
		eb.index = i;
		ret = ioctl(m2m_hw_stream_handle.video_post_process_in.fd, VIDIOC_EXPBUF, &eb);
		ASSERT(ret< 0, "VIDIOC_EXPBUF failed: %s\n", ERRSTR);
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].dbuf_fd =eb.fd;

		/*Queue buffer from CAM to post process in */
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_in,
				& (m2m_hw_stream_handle.video_post_process_in.vid_buf[i]));

		/* Queue buffer for out pipeline */
		/* TODO: should this just mmap back to user space? */
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,
						& (m2m_hw_stream_handle.video_post_process_out.vid_buf[i]));
	}

	/* Start streaming */
	ret = v4l2_device_on(& m2m_hw_stream_handle.video_in);
	ASSERT (ret < 0, "v4l2_device_on [video_in] failed %d \n",ret);
	ret = v4l2_device_on (&m2m_hw_stream_handle.video_post_process_in);
	ASSERT (ret < 0, "v4l2_device_on [video_post_process_in] failed %d \n",ret);
	ret = v4l2_device_on (&m2m_hw_stream_handle.video_post_process_out);
	ASSERT (ret < 0, "v4l2_device_on [video_post_process_out] failed %d \n",ret);

#ifdef DEBUG_MODE
	printf("vlib :: Video Capture Pipeline :: started !!");
#endif
	/* Set current buffer index */
	m2m_hw_stream_handle.current_buffer=-1;

	/* TODO? */
	struct pollfd fds[] = {
		{.fd = m2m_hw_stream_handle.video_in.fd, .events = POLLIN},
		{.fd = m2m_hw_stream_handle.video_post_process_in.fd, .events = POLLOUT},
		{.fd = m2m_hw_stream_handle.video_post_process_out.fd, .events = POLLIN},
	};
	int filter_m2s_qbuf_count=0;
	unsigned int tpg_s2m_count=0,filter_m2s_count=0,filter_s2m_count=0;

	/* NOTE : VDMA doesn't issue EOF interrupt , as a result even on the first frame done,
		 interrupt , it still updating it , current solution is to skip the first frame
		 done notification*/

	/* poll and pass buffers */
	while ((ret = poll(fds, ARRAY_SIZE(fds), POLL_TIMEOUT_MSEC)) > 0 ) {
		struct buffer *b;

		if (fds[0].revents & POLLIN) {
			if (tpg_s2m_count != VDMA_SKIP_FRM_INDEX) {
				b = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_in, m2m_hw_stream_handle.video_in.vid_buf);
				v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_in, b);
				filter_m2s_qbuf_count++;
			}
			tpg_s2m_count++;
		}
		if (fds[1].revents & POLLOUT && filter_m2s_qbuf_count > 0) {
			if (filter_m2s_count != VDMA_SKIP_FRM_INDEX) {
				b = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_post_process_in, m2m_hw_stream_handle.video_post_process_in.vid_buf);

				// @jdanner3 -- adding intercept
				/*
				printf("Intercepting buffer to write after hw process\n");
				Mat dst;
				imdecode(b, 0, &dst);
    				imwrite("/home/image-hw.bmp", dst);
				*/

				v4l2_queue_buffer(&m2m_hw_stream_handle.video_in, b);
				filter_m2s_qbuf_count--;
			}
			filter_m2s_count ++;
		}
		if (fds[2].revents & POLLIN) {
			/*
			 * TODO: From here, we want to mmap back to userspace instead of out to DRM
			 */
			struct buffer *buffer;
			if (filter_s2m_count != VDMA_SKIP_FRM_INDEX ) {
				buffer = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_post_process_out,
							m2m_hw_stream_handle.video_post_process_out.vid_buf);
				v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,buffer);

				// TODO: mmap to userspace?
			}
			filter_s2m_count++;

		}
	}

	/* push cleanup handler */
	pthread_cleanup_pop(1);

	return VLIB_SUCCESS;
}

/* Un-init m2m hw pipeline ->uninit HLS sobel module , stop the video stream and close video devices */
void uninit_m2m_hw_pipeline(void *ptr)
{
	int ret =0,i=0;

	ret= v4l2_device_off(& m2m_hw_stream_handle.video_in);
	ASSERT(ret< 0 ,"video_in   ::  stream-off failed \n");

	ret= v4l2_device_off(& m2m_hw_stream_handle.video_post_process_in);
	ASSERT(ret< 0 ,"video_post_process_in :: stream-off failed \n");

	ret= v4l2_device_off(& m2m_hw_stream_handle.video_post_process_out);
	ASSERT(ret< 0 ,"post_process_out ::  stream-off failed \n");

	/* delete dumb buffers */
	for (i=0;i< BUFFER_CNT ;i++) {
		close (m2m_hw_stream_handle.video_post_process_in.vid_buf[i].dbuf_fd);
	}

	close(m2m_hw_stream_handle.video_in.fd);
	close(m2m_hw_stream_handle.video_post_process_in.fd);
	close(m2m_hw_stream_handle.video_post_process_out.fd);
}



