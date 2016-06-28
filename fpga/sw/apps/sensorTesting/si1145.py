import time
from pythoni2c import read_address
from pythoni2c import read_word_data
from pythoni2c import write_address
from pythoni2c import readU8
from pythoni2c import write8


def write_param(address,p,v):
        write_address(address,0x17,v)
        write_address(address,0x18,p | 0xA0)
        value = read_address(address,0x2E)
        return value

def reset():
        write_address(0x60,0x08,0x00)
        write_address(0x60,0x09,0x00)
        write_address(0x60,0x04,0x00)
        write_address(0x60,0x05,0x00)
        write_address(0x60,0x06,0x00)
        write_address(0x60,0x03,0x00)
        write_address(0x60,0x21,0xFF)
        write_address(0x60,0x18,0x01)
        time.sleep(0.01)
        write_address(0x60,0x07,0x17)
        time.sleep(0.01)

def calibration():
        write_address(0x60,0x13,0x29)
        write_address(0x60,0x14,0x89)
        write_address(0x60,0x15,0x02)
        write_address(0x60,0x16,0x00)
        write_param(0x60,0x01,0x80 | 0x20 | 0x10 | 0x01)
        write_address(0x60,0x03,0x01)
        write_address(0x60,0x04,0x01)
        write_address(0x60,0x0F,0x03)
        write_param(0x60,0x07,0x03)
        write_param(0x60,0x02,0x01)
        write_param(0x60,0x0B,0x00)
        write_param(0x60,0x0A,0x70)
        write_param(0x60,0x0C,0x20 | 0x04)
        write_param(0x60,0x1E,0x00)
        write_param(0x60,0x1D,0x70)
        write_param(0x60,0x1F,0x20)
        write_param(0x60,0x11,0x00)
        write_param(0x60,0x10,0x70)
        write_param(0x60,0x12,0x20)
        write_address(0x60,0x08,0xFF)
        write_address(0x60,0x18,0x0F)


def readU16(address, register, little_endian=True):
        result = read_word_data(address,register) & 0xFFFF
        if not little_endian:
                result = ((result << 8) & 0xFF00) + (result >> 8)
        return result


def readU16LE(address, register):
        return readU16(address,register, little_endian=True)

reset()
calibration()

while True:
    uv = readU16LE(0x60,0x2C)/100
    print(uv)
    vis = ((readU16LE(0x60,0x22)) - (readU16LE(0x60,0x24))) * -1
    print(vis)
    ir = readU16LE(0x60,0x24)
    print(ir)





