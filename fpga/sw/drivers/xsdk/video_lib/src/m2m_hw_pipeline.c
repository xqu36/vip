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

#include "opencv/cv.h"
#include "opencv2/highgui/highgui_c.h"

static struct m2m_hw_stream m2m_hw_stream_handle;

int init_m2m_hw_pipeline(struct video_pipeline *s)
{
	int ret = 0;

	memset(&m2m_hw_stream_handle, 0, sizeof (struct m2m_hw_stream));

	/* Configure media pipelines */
	set_media_control(s, MEDIA_NODE_0);

	/* Set v4l2 device names */
	/* UVCVIDEO */
	ret = v4l2_parse_node(s->vid_dev, m2m_hw_stream_handle.video_in.devname);
	ASSERT(ret < 0, "No video node matching device name %s (%d)\n", s->vid_dev, ret);

	/* CARD NAMES */
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
	m2m_hw_stream_handle.video_in.mem_type =V4L2_MEMORY_MMAP;
	m2m_hw_stream_handle.video_in.setup_ptr = s;

	/* Initialize v4l2 video sandbox-in device */
	m2m_hw_stream_handle.video_post_process_in.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_post_process_in.format.width = s->w;
	m2m_hw_stream_handle.video_post_process_in.format.height = s->h;
	m2m_hw_stream_handle.video_post_process_in.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_post_process_in.format.colorspace = s->colorspace;
	m2m_hw_stream_handle.video_post_process_in.buf_type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
	m2m_hw_stream_handle.video_post_process_in.mem_type = V4L2_MEMORY_MMAP;

	/* Initialize v4l2 video sandbox-out device*/
	m2m_hw_stream_handle.video_post_process_out.format.pixelformat = s->in_fourcc;
	m2m_hw_stream_handle.video_post_process_out.format.width = s->w;
	m2m_hw_stream_handle.video_post_process_out.format.height = s->h;
	m2m_hw_stream_handle.video_post_process_out.format.bytesperline = s->stride;
	m2m_hw_stream_handle.video_post_process_out.format.colorspace = s->colorspace;
	m2m_hw_stream_handle.video_post_process_out.buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
	// jdanner3 edit 331
	//m2m_hw_stream_handle.video_post_process_out.mem_type = V4L2_MEMORY_MMAP;
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
	// jdanner3 331 uncommented below
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

	/* VIDEO IN */
	for (i = 0; i < BUFFER_CNT; ++i)  {
	 	struct v4l2_buffer buffer;
		memset(&buffer, 0, sizeof(buffer));
		buffer.type =V4L2_BUF_TYPE_VIDEO_CAPTURE;
		buffer.memory = V4L2_MEMORY_MMAP;
		buffer.index = i;
		if (-1 == ioctl (m2m_hw_stream_handle.video_in.fd, VIDIOC_QUERYBUF, &buffer)) {
			perror("VIDIOC_QUERYBUF");
			exit(EXIT_FAILURE);
		}

		m2m_hw_stream_handle.video_in.vid_buf[i].v4l2_buff_length=buffer.length;

		/* remember for munmap() */
		m2m_hw_stream_handle.video_in.vid_buf[i].v4l2_buff = mmap(NULL,
				buffer.length, PROT_READ|PROT_WRITE, MAP_SHARED,
				m2m_hw_stream_handle.video_in.fd, buffer.m.offset);

		ASSERT(MAP_FAILED == m2m_hw_stream_handle.video_in.vid_buf[i].v4l2_buff , "mmap failed ");
		m2m_hw_stream_handle.video_in.vid_buf[i].index = i;

	 }

	/* POST PROCESS IN */
	for (i = 0; i < BUFFER_CNT; ++i)  {
	 	struct v4l2_buffer buffer;
		memset(&buffer, 0, sizeof(buffer));
		buffer.type =V4L2_BUF_TYPE_VIDEO_OUTPUT;
		buffer.memory = V4L2_MEMORY_MMAP;
		buffer.index = i;
		if (-1 == ioctl (m2m_hw_stream_handle.video_post_process_in.fd, VIDIOC_QUERYBUF, &buffer)) {
			perror("VIDIOC_QUERYBUF");
			exit(EXIT_FAILURE);
		}

		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].v4l2_buff_length=buffer.length;

		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].v4l2_buff = mmap(NULL,
						buffer.length, PROT_READ|PROT_WRITE, MAP_SHARED,
						m2m_hw_stream_handle.video_post_process_in.fd, buffer.m.offset);

		ASSERT(MAP_FAILED == m2m_hw_stream_handle.video_post_process_in.vid_buf[i].v4l2_buff , "mmap failed ");
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].index = i;

	 }

	// POST PROCESS OUT
	/*
	for (i = 0; i < BUFFER_CNT; ++i)  {
	 	struct v4l2_buffer buffer;
		memset(&buffer, 0, sizeof(buffer));
		// jdanner3 331
		buffer.type =V4L2_BUF_TYPE_VIDEO_CAPTURE;
		buffer.memory = V4L2_MEMORY_DMABUF;
		buffer.index = i;
		if (-1 == ioctl (m2m_hw_stream_handle.video_post_process_out.fd, VIDIOC_QUERYBUF, &buffer)) {
			perror("VIDIOC_QUERYBUF");
			exit(EXIT_FAILURE);
		}

		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].v4l2_buff_length=buffer.length;

		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].v4l2_buff = mmap(NULL,
				buffer.length, PROT_READ|PROT_WRITE, MAP_SHARED,
				m2m_hw_stream_handle.video_post_process_out.fd, buffer.m.offset);

		ASSERT(MAP_FAILED == m2m_hw_stream_handle.video_post_process_out.vid_buf[i].v4l2_buff , "mmap failed ");
		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].index = i;
	 }
	*/

	/* Assigning buffer index and set exported buff handle */
	for(i=0;i<BUFFER_CNT;i++) {
		m2m_hw_stream_handle.video_in.vid_buf[i].index =i ;
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].index=i;
		m2m_hw_stream_handle.video_post_process_out.vid_buf[i].index =i;

		// export buffer for sharing buffer between two v4l2 devices
		memset(&eb, 0, sizeof(eb));
		// jdanner3 331 changed to out
		eb.type = m2m_hw_stream_handle.video_post_process_in.buf_type;
		eb.index = i;
		ret = ioctl(m2m_hw_stream_handle.video_post_process_in.fd, VIDIOC_EXPBUF, &eb);
		ASSERT(ret< 0, "VIDIOC_EXPBUF failed: %s\n", ERRSTR);
		m2m_hw_stream_handle.video_post_process_in.vid_buf[i].dbuf_fd =eb.fd;

		/* MISSING FIXME */
				/* Assign DRM buffer buff-sharing handle */
				m2m_hw_stream_handle.video_post_process_out.vid_buf[i].dbuf_fd  =
						m2m_hw_stream_handle.video_post_process_in.vid_buf[i].dbuf_fd;

#ifdef DEBUG_MODE
		printf("[m2m_hw_pipeline] queue from CAM to fabric\n");
#endif

		// THIS ONLY HAPPENS BECAUSE OF BUFFER SHARING
		/*
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_in,
				& (m2m_hw_stream_handle.video_post_process_in.vid_buf[i]));
		*/
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_in,
				& (m2m_hw_stream_handle.video_in.vid_buf[i]));


		// need to assign dbuf first

		// Queue buffer for out pipeline

		v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,
						& (m2m_hw_stream_handle.video_post_process_out.vid_buf[i]));
		/*
		v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,
						& (m2m_hw_stream_handle.video_post_process_in.vid_buf[i]));
*/

	}

	/* Start streaming */
	ret = v4l2_device_on(& m2m_hw_stream_handle.video_in);
	ASSERT (ret < 0, "v4l2_device_on [video_in] failed %d \n",ret);
	ret = v4l2_device_on (&m2m_hw_stream_handle.video_post_process_in);
	ASSERT (ret < 0, "v4l2_device_on [video_post_process_in] failed %d \n",ret);
	ret = v4l2_device_on (&m2m_hw_stream_handle.video_post_process_out);
	ASSERT (ret < 0, "v4l2_device_on [video_post_process_out] failed %d \n",ret);

#ifdef DEBUG_MODE
	printf("vlib :: Video Capture Pipeline :: started !!\n\n");
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

				printf("video_in: %d\n", tpg_s2m_count);
				if(!b->v4l2_buff) printf("video_in!b is NULL\n");

				unsigned char* ptr = b->v4l2_buff;
				if(!ptr) printf("[[ ptr is NULL ]]\n");

				// constructing OpenCV interface
				IplImage* src_dma = cvCreateImageHeader(cvSize(m2m_hw_stream_handle.video_post_process_out.format.width,
														m2m_hw_stream_handle.video_post_process_out.format.height),
														IPL_DEPTH_8U, 2);

				src_dma->widthStep = m2m_hw_stream_handle.video_post_process_out.format.bytesperline;
				cvSetData(src_dma, ptr, src_dma->widthStep);

				IplImage* saveimg = cvCreateImage(cvGetSize(src_dma), src_dma->depth, 3);
				IplImage* c1 = cvCreateImage(cvGetSize(saveimg), saveimg->depth, 1);
				IplImage* c2 = cvCreateImage(cvGetSize(saveimg), saveimg->depth, 1);
					if(!src_dma->imageData) printf("src_dma is NULL\n");
					cvSplit(src_dma, c1, c2, NULL, NULL);
					cvMerge(c1, NULL, NULL, NULL, saveimg);

				printf("\tcvSaveImage...");
				fflush(stdout);
					ret = cvSaveImage("/home/c1_video_in.bmp", saveimg, 0);
				printf("done!\n");

				printf("\tcvReleaseImage...");
				fflush(stdout);
					cvReleaseImage(&src_dma);
					cvReleaseImage(&saveimg);
					cvReleaseImage(&c1);
					cvReleaseImage(&c2);
				printf("done!\n");

				for(i=0;i<BUFFER_CNT;i++) {
					m2m_hw_stream_handle.video_post_process_in.vid_buf[i].v4l2_buff =
							m2m_hw_stream_handle.video_in.vid_buf[i].v4l2_buff;
				}

				v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_in, b);

				filter_m2s_qbuf_count++;
			}
			tpg_s2m_count++;
		}
		if (fds[1].revents & POLLOUT && filter_m2s_qbuf_count > 0) {
			if (filter_m2s_count != VDMA_SKIP_FRM_INDEX) {
				b = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_post_process_in, m2m_hw_stream_handle.video_post_process_in.vid_buf);

				printf("post_process_in: %d\n", filter_m2s_count);
				if(!b->v4l2_buff) printf("video_post_process_in!b is NULL\n");

				unsigned char* ptr = b->v4l2_buff;
				if(!ptr) printf("[[ ptr is NULL ]]\n");

				// constructing OpenCV interface
				IplImage* src_dma = cvCreateImageHeader(cvSize(m2m_hw_stream_handle.video_post_process_out.format.width,
														m2m_hw_stream_handle.video_post_process_out.format.height),
														IPL_DEPTH_8U, 2);

				src_dma->widthStep = m2m_hw_stream_handle.video_post_process_out.format.bytesperline;
				cvSetData(src_dma, ptr, src_dma->widthStep);

				IplImage* saveimg = cvCreateImage(cvGetSize(src_dma), src_dma->depth, 3);
				IplImage* c1 = cvCreateImage(cvGetSize(saveimg), saveimg->depth, 1);
				IplImage* c2 = cvCreateImage(cvGetSize(saveimg), saveimg->depth, 1);
					if(!src_dma->imageData) printf("src_dma is NULL\n");
					cvSplit(src_dma, c1, c2, NULL, NULL);
					cvMerge(c1, NULL, NULL, NULL, saveimg);

				printf("\tcvSaveImage...");
				fflush(stdout);
					ret = cvSaveImage("/home/c1_pp_in.bmp", saveimg, 0);
				printf("done!\n");

				printf("\tcvReleaseImage...");
				fflush(stdout);
					cvReleaseImage(&src_dma);
					cvReleaseImage(&saveimg);
					cvReleaseImage(&c1);
					cvReleaseImage(&c2);
				printf("done!\n");
				v4l2_queue_buffer(&m2m_hw_stream_handle.video_in, b);
				filter_m2s_qbuf_count--;
			}
			filter_m2s_count++;
		}
		if (fds[2].revents & POLLIN) {
			struct buffer *buffer;
			if (filter_s2m_count != VDMA_SKIP_FRM_INDEX ) {
				printf("post_process_out: %d\n", filter_s2m_count);
				buffer = v4l2_dequeue_buffer(&m2m_hw_stream_handle.video_post_process_out,
							m2m_hw_stream_handle.video_post_process_out.vid_buf);
				if(!buffer->v4l2_buff) printf("video_post_process_out!b is NULL\n");
				v4l2_queue_buffer(&m2m_hw_stream_handle.video_post_process_out,buffer);
			}
			filter_s2m_count++;
		}
	}
	printf("Cleaning up!\n");
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



