CC=g++
CFLAGS=-I/usr/include/opencv -I/usr/include/opencv2 -std=c++0x
LIBS=`pkg-config --libs opencv` -lpthread
LIBDIR=-L/usr/local/include
OBJDIR=.obj

SOURCES=segmentation.cpp vidstab.cpp utils.cpp ccomp.cpp pclass.cpp peddetect.cpp kalman.cpp

TARGETS=segmentation

$(OBJDIR)/%.o: %.cpp
	@mkdir -p $(OBJDIR)
	$(CC) -c -o $@ $^ $(CFLAGS)

.PHONY: all
all: $(TARGETS)

segmentation: $(OBJDIR)/segmentation.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(OBJDIR)/pclass.o $(OBJDIR)/peddetect.o $(OBJDIR)/kalman.o 
	$(CC) $(CFLAGS) -o segmentation $(OBJDIR)/segmentation.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(OBJDIR)/pclass.o $(OBJDIR)/peddetect.o $(OBJDIR)/kalman.o $(LIBS) $(LIBDIR)

.PHONY: clean
clean: ; rm -rf $(OBJDIR) $(TARGETS) *.log calibrations/*.jpg
