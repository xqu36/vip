#!/usr/bin/python

# Michael Capone
# Version 1.0 6/6/2016
# This script is used to assign version numbers to the BOOT.bin headerxs
# generated from build process. NOTE: There is very little error handling
# so ensure that your version input follows the standard xxxxx.xxxxx
# format (e.g. 10.0001). For usage instructions, simply execute this file 
# with the -h flag.

import sys, getopt

def main(argv):
	filename = 'BOOT.bin'
	version = '1.00'
	inputfile = ''
	try:
		opts, args = getopt.getopt(argv,"hf:v:i:",["filename=","version="])
	except getopt.GetoptError:
		print 'test.py -f <filename> (-v <version_number>|-i <input_file>)'
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			print 'test.py -f <filename> (-v <version_number>|-i <input_file>)'
			sys.exit()
		elif opt in ("-f", "--filename"):
			filename = arg
		elif opt in ("-v", "--version"):
			version = arg
		elif opt in ("-i", "--inputfile"):
			inputfile = arg

	fh = open(filename, "r+b")
	fh.seek(int("0x4c", 16))
	if inputfile:
		print("Ok! Altering \'" + filename + "\' to have the version info from \'" + inputfile + "\'")
		with open(inputfile, "rb") as f:
			byte = f.read(1)
			while byte != "":
				fh.write(byte)
				byte = f.read(1)
	else:	
		print("Ok! Altering \'" + filename + "\' to have the version \'" + version + "\'")
		version_str = "VIP_PROJECT_VERSION_NUMBER=" + version
		fh.write(version_str)
		fh.close()
	print("Success!")

if __name__ == "__main__":
	main(sys.argv[1:])

