CC=g++
#CFLAGS=`pkg-config --cflags opencv`
CFLAGS=-I/usr/include/opencv -I/usr/include/opencv2
LIBS=`pkg-config --libs opencv`
LIBDIR=-L/usr/local/include
OBJDIR=.obj

TARGETS=absDiffDemo colorDetectionDemo

$(OBJDIR)/%.o: %.cpp ; $(CC) -c -o $@ $^ $(CFLAGS)

.PHONY: all
all: $(TARGETS)

absDiffDemo: $(OBJDIR)/absDiffDemo.o ; $(CC) $(CFLAGS) -o absDiffDemo $(OBJDIR)/absDiffDemo.o $(LIBS) $(LIBDIR)

colorDetectionDemo: $(OBJDIR)/colorDetectionDemo.o ; $(CC) $(CFLAGS) -o colorDetectionDemo $(OBJDIR)/colorDetectionDemo.o $(LIBS) $(LIBDIR)

.PHONY: clean
clean: ; rm -f $(OBJDIR)/*.o $(TARGETS)
