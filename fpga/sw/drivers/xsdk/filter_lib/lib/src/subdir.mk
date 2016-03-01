################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/filter.c \
../src/v4l2_sobel.c 

CPP_SRCS += \
../src/opencv_sobel.cpp 

OBJS += \
./src/filter.o \
./src/opencv_sobel.o \
./src/v4l2_sobel.o 

C_DEPS += \
./src/filter.d \
./src/v4l2_sobel.d 

CPP_DEPS += \
./src/opencv_sobel.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux g++ compiler'
	arm-xilinx-linux-gnueabi-g++ -Wall -O3 -I"/home/jdanner3/VIP/repos/vip/fpga/sw/drivers/xsdk/filter_lib/include" -I"../../../pre-built/include" -I"/opt/Xilinx/SDK/2014.4/data/embeddedsw/ThirdParty/opencv/include" -c -fmessage-length=0 -MT"$@" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux g++ compiler'
	arm-xilinx-linux-gnueabi-g++ -Wall -O3 -I"/home/jdanner3/VIP/repos/vip/fpga/sw/drivers/xsdk/filter_lib/include" -I"../../../pre-built/include" -I"/opt/Xilinx/SDK/2014.4/data/embeddedsw/ThirdParty/opencv/include" -c -fmessage-length=0 -MT"$@" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


