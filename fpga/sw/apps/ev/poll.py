import subprocess
import sys
import os
import signal
import atexit

def exitall(signal, frame):
  print "Took a 'kill [pid]' right to the face."
  sys.exit(0)

def start_proc(cmd):
  process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  global child_pid
  child_pid = process.pid
  return process

def kill_child():
  if child_pid is None:
    pass
  else:
    os.kill(child_pid, signal.SIGINT)
 
def main():
  process = start_proc("./segmentation")
  atexit.register(kill_child)

  for line in iter(process.stdout.readline, ''):
    sys.stdout.write(line)

if __name__ == "__main__":
  signal.signal(signal.SIGTERM, exitall)
  main()
