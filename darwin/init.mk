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
