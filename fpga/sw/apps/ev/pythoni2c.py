import os
import time


#Convert unsigned to signed value

def signed(value):
        if value > 32767:
                value -= 65536
        return value

#Read value from internal addr from chip. chip is the actual I2C slave address and addr the internal address of the device

def read_address(chip,addr):
        l='i2cget -y 1 '+str(chip)+' '+str(addr)+' b'
        p = os.popen(l)
        s = p.readline()
        p.close()
        return s

#Read 2 byte(16b) from internal addr(addr,addr+1) from chip.


def read_word_data(chip,addr):
        lsb = int(read_address(chip,addr),0)
        msb = int(read_address(chip,addr+1),0)
        value = (msb << 8) + lsb
        return value


#Write data into the addr of chip. chip is the actual I2C slave address and addr the internal address of the device

def write_address(chip,addr,data):
        l='i2cset -y 1 '+str(chip)+' '+str(addr)+' '+str(data)+' b'
        p = os.popen(l)
        p.close()

#Read unsigned 8 bits from internal addr of chip. chip is the actual I2C slave address and addr the internal address of the $


def readU8(chip,addr):
        result = int(read_address(chip,addr),0) & 0xFF
        return result

#Write 8 bit value into internal addr of chip. chip is the actual I2C slave address and addr the internal address of the dev$

def write8(chip, addr, value):
        value = value & 0xFF
        write_address(chip, addr, value)

