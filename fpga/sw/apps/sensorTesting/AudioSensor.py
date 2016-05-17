import pyaudio
import wave
import numpy as np
import math

numb = 1 #used in infinite loop
stamp = 0 #this is used to index the multiple .125s recordings
FORMAT = pyaudio.paInt16
CHANNELS = 2
RATE = 44100
CHUNK = 1024
RECORD_SECONDS = .125 #each recording is 1/8 sec long
audio = pyaudio.PyAudio()
rms = 0

while numb == 1: #infinite loop
    if stamp == 0:
        WAVE_OUTPUT_FILENAME = "file0.wav"
        rms15 = rms #stores the last index's rms value to be compared later
    if stamp == 1:
        WAVE_OUTPUT_FILENAME = "file1.wav"
        rms0 = rms
    if stamp == 2:
        WAVE_OUTPUT_FILENAME = "file2.wav"
        rms1 = rms
    if stamp == 3:
        WAVE_OUTPUT_FILENAME = "file3.wav"
        rms2 = rms
    if stamp == 4:
        WAVE_OUTPUT_FILENAME = "file4.wav"
        rms3 = rms
    if stamp == 5:
        WAVE_OUTPUT_FILENAME = "file5.wav"
        rms4 = rms
    if stamp == 6:
        WAVE_OUTPUT_FILENAME = "file6.wav"
        rms5 = rms
    if stamp == 7:
        WAVE_OUTPUT_FILENAME = "file7.wav"
        rms6 = rms
    if stamp == 8:
        WAVE_OUTPUT_FILENAME = "file8.wav"
        rms7 = rms
    if stamp == 9:
        WAVE_OUTPUT_FILENAME = "file9.wav"
        rms8 = rms
    if stamp == 10:
        WAVE_OUTPUT_FILENAME = "file10.wav"
        rms9 = rms
    if stamp == 11:
        WAVE_OUTPUT_FILENAME = "file11.wav"
        rms10 = rms
    if stamp == 12:
        WAVE_OUTPUT_FILENAME = "file12.wav"
        rms11 = rms
    if stamp == 13:
        WAVE_OUTPUT_FILENAME = "file13.wav"
        rms12 = rms
    if stamp == 14:
        WAVE_OUTPUT_FILENAME = "file14.wav"
        rms13 = rms
    if stamp == 15:
        WAVE_OUTPUT_FILENAME = "file15.wav"
        rms14 = rms
        
    stream = audio.open(format=FORMAT, channels=CHANNELS,
                rate=RATE, input=True,
                frames_per_buffer=CHUNK)
    
    frames = []

    for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
        data = stream.read(CHUNK)
        frames.append(data)
    
    stamp = stamp = stamp + 1

    waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
    waveFile.setnchannels(CHANNELS)
    waveFile.setsampwidth(audio.get_sample_size(FORMAT))
    waveFile.setframerate(RATE)
    waveFile.writeframes(b''.join(frames))
    waveFile.close()

    if stamp == 15:
        numb = 0 #change this later to "stamp = 0"

    #Find the rms value
    f = wave.open(WAVE_OUTPUT_FILENAME,'rb')
    nchannels, sampwidth, framerate, nframes, comptype, compname = f.getparams()[:6] #This caucluation is completely unneccessary. In revisions detlete this bc you know the parameters
    byteList = np.fromstring(f.readframes(nframes), dtype = np.int16)
    byteList = byteList.astype(np.float)
    f.close()
    maximum = max(byteList)
    minimum = min(byteList)
    peak = (abs(maximum)+abs(minimum))/2
    total = 0
    for i in byteList[0:nframes]:
        total+=(((byteList[i])/peak))**2
    rms = math.sqrt(total/nframes) #Find the rms value
    print('This is rms: {}'.format(rms))

# stop Recording
stream.stop_stream()
stream.close()
audio.terminate()

#The following calculation takes way too much time
slope0 = (rms0 - rms1)/2
slope1 = (rms1 - rms2)/2
slope2 = (rms2 - rms3)/2
slope3 = (rms3 - rms4)/2
slope4 = (rms4 - rms5)/2
slope5 = (rms5 - rms6)/2
slope6 = (rms6 - rms7)/2
slope7 = (rms7 - rms8)/2
slope8 = (rms8 - rms9)/2
slope9 = (rms9 - rms10)/2
slope10 = (rms10 - rms11)/2
slope11 = (rms11 - rms12)/2
slope12 = (rms12 - rms13)/2
avj = (slope0 + slope1 + slope2 + slope3 + slope4 + slope5 + slope6 + slope7 + slope8 + slope9 + slope10 + slope11 + slope12)/13
print avj
