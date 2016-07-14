--sentinel2.sh
--Current Version: 1.0
--Controls the health monitoring for the FPGA.

The script is at each boot as a cronjob, which can be accessed through the crontab -e command while using the board. The FPGA recieves high signals through the JA pmod bank, and responds by copying the new value of the gpio input, to the gpio output pin. When the arduino recieves the signal change from the fpga, it will response with a low signal, which the FPGA will then mirror to the gpio output pin. Additionally when the FPGA recieves the forceDown signal from the arduino, the sentinel2.sh script will use the poweroff command to shutdown the board allowing for a clean reboot.
