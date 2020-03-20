################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/m2m_hw_pipeline.c \
../src/m2m_sw_pipeline.c \
../src/mediactl_helper.c \
../src/v4l2_helper.c \
../src/video.c 

OBJS += \
./src/m2m_hw_pipeline.o \
./src/m2m_sw_pipeline.o \
./src/mediactl_helper.o \
./src/v4l2_helper.o \
./src/video.o 

C_DEPS += \
./src/m2m_hw_pipeline.d \
./src/m2m_sw_pipeline.d \
./src/mediactl_helper.d \
./src/v4l2_helper.d \
./src/video.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux gcc compiler'
	arm-xilinx-linux-gnueabi-gcc -Wall -O3 -I"/home/jdanner3/VIP/repos/vip/fpga/sw/drivers/xsdk/video_lib/include" -I"/opt/Xilinx/SDK/2015.1/data/embeddedsw/ThirdParty/opencv/include" -I"/home/jdanner3/VIP/repos/vip/fpga/sw/drivers/xsdk/filter_lib/include" -I"../../../pre-built/include" -c -fmessage-length=0 -MT"$@" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


