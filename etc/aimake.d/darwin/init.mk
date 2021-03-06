CC  = gcc
LD  = ld
CPP = cpp
CXX = g++
AR  = ar
AS  = as
NM  = nm
STRIP = strip

CFLAGS   := -D __APPLE__ -D RUSAGE_THREAD=0 #-fPIC -pipe
CXXFLAGS := $(CFLAGS)
LDFLAGS := -lstdc++ 
#
# explict rules
#
%.o : %.c
	$(CC) $(LOCAL_CFLAGS) $(CFLAGS) -c $< -o $@

%.o : %.cc
	$(CXX) $(LOCAL_CXXFLAGS) $(CXXFLAGS) -c $< -o $@

%.o : %.cpp
	$(CXX) $(LOCAL_CXXFLAGS) $(CXXFLAGS) -c $< -o $@


#
# building targets
#
EXECUTABLE = $(LOCAL_MODULE)
SHARED_LIBRARY  = lib$(LOCAL_MODULE).so
STATIC_LIBRARY  = lib$(LOCAL_MODULE).a
PACKAGE  = $(LOCAL_MODULE)-$(TARGET_PLATFORM)-$(VERSION)-$(TIMESTAMP).tar.gz
