CC=g++
CFLAGS=-I/usr/include/opencv -I/usr/include/opencv2 -std=c++0x
LIBS=`pkg-config --libs opencv`
LIBDIR=-L/usr/local/include
OBJDIR=.obj

TARGETS=segmentation xwalkdetect

$(OBJDIR)/%.o: %.cpp
	@mkdir -p $(OBJDIR)
	$(CC) -c -o $@ $^ $(CFLAGS)

.PHONY: all
all: $(TARGETS)

segmentation: $(OBJDIR)/segmentation.o $(OBJDIR)/vidstab.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o
	$(CC) $(CFLAGS) -o segmentation $(OBJDIR)/segmentation.o $(OBJDIR)/vidstab.o $(OBJDIR)/utils.o $(OBJDIR)/ccomp.o $(LIBS) $(LIBDIR)

xwalkdetect: $(OBJDIR)/xwalkdetect.o
	$(CC) $(CFLAGS) -o xwalkdetect $(OBJDIR)/xwalkdetect.o $(LIBS) $(LIBDIR)

.PHONY: clean
clean: ; rm -rf $(OBJDIR) $(TARGETS)
