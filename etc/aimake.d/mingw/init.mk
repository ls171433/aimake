TOOLCHAIN_DIR=/opt/bin
TOOLCHAIN_PREFIX=i686-w64-mingw32-

MINGWABI=$(shell uname -m)

$(warning build for MINGWABI: $(MINGWABI))
$(shell sleep 1)

ifeq ($(MINGWABI), i686)

    TOOLCHAINS = /opt/bin
    PREFIX=i686-w64-mingw32-

else ifeq ($(MINGWABI), x86_64)

    TOOLCHAINS = /opt/bin
    PREFIX=x86_64-w64-mingw32-

else
    $(error only support MINGWABI: i686, x86_64)
endif

CC    = $(TOOLCHAINS)/$(PREFIX)gcc
LD    = $(TOOLCHAINS)/$(PREFIX)ld
CPP   = $(TOOLCHAINS)/$(PREFIX)cpp
CXX   = $(TOOLCHAINS)/$(PREFIX)g++
AR    = $(TOOLCHAINS)/$(PREFIX)ar
AS    = $(TOOLCHAINS)/$(PREFIX)as
NM    = $(TOOLCHAINS)/$(PREFIX)gcc-nm
STRIP = $(TOOLCHAINS)/$(PREFIX)strip

WINDRES = $(TOOLCHAINS)/$(PREFIX)windres

CFLAGS   += #-D __WIN32__ -DWIN32 #-fPIC -pipe
CXXFLAGS += $(CFLAGS)
LDFLAGS  += -static-libgcc -static-libstdc++


#
# explict rules
#
%.o : %.c
	$(CC) $(LOCAL_CFLAGS) $(CFLAGS) -c $< -o $@

%.o : %.cc
	$(CXX) $(LOCAL_CXXFLAGS) $(CXXFLAGS) -c $< -o $@

%.o : %.cpp
	$(CXX) $(LOCAL_CXXFLAGS) $(CXXFLAGS) -c $< -o $@

%.o : %.rc
	$(WINDRES) -J rc -O coff -i $< -o $@


#
# building targets
#
EXECUTABLE = $(LOCAL_MODULE).exe
SHARED_LIBRARY  = $(LOCAL_MODULE).dll
STATIC_LIBRARY  = $(LOCAL_MODULE).lib
PACKAGE  = $(shell basename .t/$(LOCAL_MODULE))-$(TARGET_PLATFORM)-$(VERSION)-$(TIMESTAMP).zip
