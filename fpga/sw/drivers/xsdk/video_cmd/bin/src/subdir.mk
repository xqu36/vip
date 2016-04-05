################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/video_cmd.c 

OBJS += \
./src/video_cmd.o 

C_DEPS += \
./src/video_cmd.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Linux gcc compiler'
	arm-xilinx-linux-gnueabi-gcc -Wall -O0 -g3 -I"/home/jdanner3/VIP/repos/vip/fpga/sw/drivers/xsdk/video_lib/include" -I"/opt/Xilinx/SDK/2015.1/data/embeddedsw/ThirdParty/opencv/include" -I"/home/jdanner3/VIP/repos/vip/fpga/sw/drivers/xsdk/filter_lib/include" -c -fmessage-length=0 -MT"$@" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


