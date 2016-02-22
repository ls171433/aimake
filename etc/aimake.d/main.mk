BUILD_STATIC_LIBRARY = $(AIMAKE_HOME)/$(TARGET_PLATFORM)/build_static_library.mk
BUILD_SHARED_LIBRARY = $(AIMAKE_HOME)/$(TARGET_PLATFORM)/build_shared_library.mk
BUILD_EXECUTABLE     = $(AIMAKE_HOME)/$(TARGET_PLATFORM)/build_executable.mk

CC    = cc
LD    = ld
CPP   = cpp
CXX   = c++
AR    = ar
AS    = as
NM    = nm
STRIP = strip

include $(AIMAKE_HOME)/$(TARGET_PLATFORM)/init.mk
include $(AIMAKEFILE)
include $(AIMAKE_HOME)/$(TARGET_PLATFORM)/build_all.mk
