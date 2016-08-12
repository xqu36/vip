CC=g++
CFLAGS=-I/usr/include/opencv -I/usr/include/opencv2 -std=c++0x -D DEBUG
LIBS=`pkg-config --libs opencv` -lpthread
LIBDIR=-L/usr/local/include
OBJDIR=.obj

SOURCES=segmentation.cpp vidstab.cpp utils.cpp ccomp.cpp pclass.cpp peddetect.cpp

TARGETS=segmentation

$(OBJDIR)/%.o: %.cpp
	@mkdir -p $(OBJDIR)
	$(CC) -c -o $@ $^ $(CFLAGS)

.PHONY: all
all: $(TARGETS)

segmentation: $(OBJDIR)/segmentation.o $(OBJDIR)/vidstab.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(OBJDIR)/pclass.o $(OBJDIR)/peddetect.o
	$(CC) $(CFLAGS) -o segmentation $(OBJDIR)/segmentation.o $(OBJDIR)/vidstab.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(OBJDIR)/pclass.o $(OBJDIR)/peddetect.o $(LIBS) $(LIBDIR)

.PHONY: clean
clean: ; rm -rf $(OBJDIR) $(TARGETS) *.log
