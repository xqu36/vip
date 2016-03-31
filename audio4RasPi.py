import pyaudio
import audioop
import analyse
import numpy

#This program takes the volume of the mic at different times and prints it to the screen
CHUNK = 8192 #Increased to end overflow errors
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 44100

p = pyaudio.PyAudio()

stream = p.open(format=FORMAT,      #in this example it takes the default mic input
                channels=CHANNELS,
                rate=RATE,
                input=True,
                frames_per_buffer=CHUNK)

while True:
    rawsamps = stream.read(CHUNK)
    samps = numpy.fromstring(rawsamps, dtype=numpy.int16)
    print analyse.loudness(samps)

stream.stop_stream()
stream.close()
p.terminate()