import pyaudio
import wave
import numpy as np
import math

stamp = 0 #this is used to index the multiple .125s recordings
FORMAT = pyaudio.paInt16
CHANNELS = 2
RATE = 44100
CHUNK = 1024
RECORD_SECONDS = .125 #each recording is 1/8 sec long
audio = pyaudio.PyAudio()
rms = 0

while True:
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

    #setting the parameters for the .WAV file

    waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
    waveFile.setnchannels(CHANNELS) #set channels
    waveFile.setsampwidth(audio.get_sample_size(FORMAT))
    waveFile.setframerate(RATE)
    waveFile.writeframes(b''.join(frames))
    waveFile.close()

    if stamp == 15:
        stamp = 0 #change this later to "stamp = 0"

    #Find the rms value
    f = wave.open(WAVE_OUTPUT_FILENAME,'rb')
    nchannels, sampwidth, framerate, nframes, comptype, compname = f.getparams()[:6]
    byteList = np.fromstring(f.readframes(nframes), dtype = np.int16)
    byteList = byteList.astype(np.float)
    f.close()
    print len(byteList)
    print nframes
    avg = sum(byteList) / len(byteList)
    amp = avg / 32767 #Il est parce que le nombre de bits est de 16.. zéro à une
    dB = 20 * log10(amp)
    print('dB = {}'.format(dB))

# stop Recording
stream.stop_stream()
stream.close()
audio.terminate()