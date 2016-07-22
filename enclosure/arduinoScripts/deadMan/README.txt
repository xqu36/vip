--deadMan.ino
--Current Version: 1.0
--Arduino script for power control to the ZedBoard, and simple response monitoring.

--Response Monitoring -> Once Every Hour
The arduino sends out a high signal, and waits for a high response from the ZedBoard. If no response is recieved after 900 seconds, the arduino forces the power off through the power relay. If the response pin flips, high->low, or low->high, then the arduino stops the response countdown and does not reset the FPGA power.

--Force Shutdown -> Once Every Day
The arduino sends a high signal to the zedboard forcing the FPGA to shutdown and wait for a power cycle. After waiting 1 minute, the arduino resets the power to the board.

--Setup and Programming
The arduino must be programmed twice before losing power in order to setup the device for accurate time measurements. The arduino must be connected to the RTC according to the enclosure schematics, and then the arduino should be programmed with the setTime() function on line 46 enabled. Once programmed, the setTime() function should be re-commented, and the arduino should be programmed a second time. If the settime() function remains enabled, the time will reset back to the oringally programmed time each power cycle.
