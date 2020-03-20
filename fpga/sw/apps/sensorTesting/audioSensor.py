import pyaudio
import wave
import numpy as np
import math

FORMAT = pyaudio.paInt16
CHANNELS = 2
RATE = 44100
RECORD_SECONDS = .125 #each recording is 1/8 sec long
CHUNK = 1024
WAVE_OUTPUT_FILENAME = "file0.wav"

while True:
            
      audio = pyaudio.PyAudio()
      stream = audio.open(format=FORMAT, channels=CHANNELS,
                  rate=RATE, input=True,
                  frames_per_buffer=CHUNK)
    
      frames = []

      for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
          datai = stream.read(CHUNK)
          frames.append(datai)
    
      #setting the parameters for the .WAV file

      waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
      waveFile.setnchannels(CHANNELS) #set channels
      waveFile.setsampwidth(audio.get_sample_size(FORMAT))
      waveFile.setframerate(RATE)
      waveFile.writeframes(b''.join(frames))
      waveFile.close()

      #Find the dB value...........Not complete yet but works
      f = wave.open(WAVE_OUTPUT_FILENAME,'rb')
      nchannels, sampwidth, framerate, nframes, comptype, compname = f.getparams()[:6]
      byteList = np.fromstring(f.readframes(nframes), dtype = np.int16)
      byteList = byteList.astype(np.float)
      f.close()
      avg = sum(byteList) / nframes #or len(byteList)
      amp = abs(avg / 32767) #This is becase it is a 16 bit number (2^15 -1)
      dB = 20 * math.log10(amp)
      print('dB = {}'.format(dB))
      stream.close()
stream.stop_stream()
stream.close()
audio.terminate()