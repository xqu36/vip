CC=g++
CFLAGS=-I/usr/include/opencv -I/usr/include/opencv2 -std=c++0x
LIBS=`pkg-config --libs opencv`
LIBDIR=-L/usr/local/include
OBJDIR=.obj

SOURCES=segmentation.cpp vidstab.cpp utils.cpp ccomp.cpp pclass.cpp

TARGETS=segmentation xwalkdetect

$(OBJDIR)/%.o: %.cpp
	@mkdir -p $(OBJDIR)
	$(CC) -c -o $@ $^ $(CFLAGS)

.PHONY: all
all: $(TARGETS)

segmentation: $(OBJDIR)/segmentation.o $(OBJDIR)/vidstab.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(OBJDIR)/pclass.o
	$(CC) $(CFLAGS) -o segmentation $(OBJDIR)/segmentation.o $(OBJDIR)/vidstab.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(OBJDIR)/pclass.o $(LIBS) $(LIBDIR)

xwalkdetect: $(OBJDIR)/xwalkdetect.o $(OBJDIR)/rgrow.o
	$(CC) $(CFLAGS) -o xwalkdetect $(OBJDIR)/xwalkdetect.o $(OBJDIR)/rgrow.o $(LIBS) $(LIBDIR)

.PHONY: clean
clean: ; rm -rf $(OBJDIR) $(TARGETS)
