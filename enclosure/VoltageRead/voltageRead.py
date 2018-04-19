from pynq import Overlay
Overlay("base.bit").download
from pynq.iop import ARDUINO
from pynq.iop import Arduino_Analog
#from pynq.iop import ARDUINO_GROVE_A1
#grove peripheral: groveA1 contains pinA0&pinA1 of pynq
analog1=Arduino_Analog(ARDUINO,[0]) #analog pin 0
value=analog1.read() 
print(value)