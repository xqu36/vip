CC=g++
CFLAGS=`pkg-config --cflags opencv`
LIBS=`pkg-config --libs opencv`
LIBDIR=-L/usr/local/include
OBJDIR=.obj

TARGETS=absDiffDemo colorDetectionDemo objectTrackingDemo opticalFlowDemo 


$(OBJDIR)/%.o: %.cpp ; $(CC) -c -o $@ $^ $(CFLAGS)

.PHONY: all
all: $(TARGETS)

absDiffDemo: $(OBJDIR)/absDiffDemo.o ; $(CC) $(CFLAGS) -o absDiffDemo $(OBJDIR)/absDiffDemo.o $(LIBS) $(LIBDIR)

colorDetectionDemo: $(OBJDIR)/colorDetectionDemo.o ; $(CC) $(CFLAGS) -o colorDetectionDemo $(OBJDIR)/colorDetectionDemo.o $(LIBS) $(LIBDIR)

objectTrackingDemo: $(OBJDIR)/objectTrackingDemo.o ; $(CC) $(CFLAGS) -o objectTrackingDemo $(OBJDIR)/objectTrackingDemo.o $(LIBS) $(LIBDIR)

opticalFlowDemo: $(OBJDIR)/opticalFlowDemo.o ; $(CC) $(CFLAGS) -o opticalFlowDemo $(OBJDIR)/opticalFlowDemo.o $(LIBS) $(LIBDIR)

.PHONY: clean
clean: ; rm -f $(OBJDIR)/*.o $(TARGETS)
