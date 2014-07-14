MINGWABI=i686

$(warning build for MINGWABI: $(MINGWABI))
$(shell sleep 1)

ifeq ($(MINGWABI), i686)

    TOOLCHAINS = /mingw32

    CC  = $(TOOLCHAINS)/bin/i686-w64-mingw32-gcc
    LD  = $(TOOLCHAINS)/bin/i686-w64-mingw32-ld
    CPP = $(TOOLCHAINS)/bin/i686-w64-mingw32-cpp
    CXX = $(TOOLCHAINS)/bin/i686-w64-mingw32-g++
    AR  = $(TOOLCHAINS)/bin/ar
    AS  = $(TOOLCHAINS)/bin/as
    NM  = $(TOOLCHAINS)/bin/i686-w64-mingw32-gcc-nm
    STRIP = $(TOOLCHAINS)/bin/strip
    WINDRES = $(TOOLCHAINS)/bin/windres

    CFLAGS = -I $(TOOLCHAINS)/i686-w64-mingw32/include

else ifeq ($(MINGWABI), x86_64)

    TOOLCHAINS = /mingw64

    CC  = $(TOOLCHAINS)/bin/gcc
    LD  = $(TOOLCHAINS)/bin/ld  
    CPP = $(TOOLCHAINS)/bin/cpp
    CXX = $(TOOLCHAINS)/bin/g++
    AR  = $(TOOLCHAINS)/bin/ar
    AS  = $(TOOLCHAINS)/bin/as
    NM  = $(TOOLCHAINS)/bin/nm
    STRIP = $(TOOLCHAINS)/bin/strip
    WINDRES = $(TOOLCHAINS)/bin/windres

    CFLAGS = -I $(TOOLCHAINS)/x86_64-w64-mingw32/include

else
    $(error only support MINGWABI: i686, x86_64)
endif

CFLAGS   += -D WIN32 #-fPIC -pipe
CXXFLAGS += $(CFLAGS)
LDFLAGS += -static-libgcc -static-libstdc++ 
