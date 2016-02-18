#
# android ndk configuration
#
ANDROID_NDK_HOME = /usr/local/android-ndk

ANDABI = armv6-vfp
$(warning build for ANDABI: $(ANDABI))
$(shell sleep 1)

ifeq ($(ANDABI), armv5te)
    #CFLAGS :=  -march=armv5te -marm -mfloat-abi=soft
    CFLAGS :=  -march=armv5te -mthumb -mfloat-abi=soft
else ifeq ($(ANDABI), armv6-vfp)
    CFLAGS := -march=armv6 -marm -mfloat-abi=softfp -mfpu=vfp
else ifeq ($(ANDABI), armv7a-vfpv3)
    CFLAGS := -march=armv7-a -marm -mfloat-abi=softfp -mfpu=vfpv3
else ifeq ($(ANDABI), armv7a-neon)
    CFLAGS := -march=armv7-a -marm -mfloat-abi=softfp -mfpu=neon -ftree-vectorize
else ifeq ($(ANDABI), aarch64)
    CFLAGS := -march=armv8-a
else ifeq ($(ANDABI), mips)
else ifeq ($(ANDABI), mips64)
else ifeq ($(ANDABI), i686)
    CFLAGS :=  -march=atom -mtune=atom -msse3
else ifeq ($(ANDABI), x86_64)
    CFLAGS :=  -march=x86-64 -msse4.2 -mpopcnt -m64 -mtune=intel
else
    $(error only support ANDABI: armv5te, armv6-vfp, armv7a-vfpv3, armv7a-neon, aarch64, mips, i686, x86_64, default is armv6-vfp)
endif

ifeq (arm, $(findstring arm, $(ANDABI)))

    TOOLCHAINS = $(ANDROID_NDK_HOME)/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
    PLATFORM = $(ANDROID_NDK_HOME)/platforms/android-9/arch-arm
    CXX_STL = $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.9
    
    CC  = $(TOOLCHAINS)/bin/arm-linux-androideabi-gcc
    LD  = $(TOOLCHAINS)/bin/arm-linux-androideabi-ld
    CPP = $(TOOLCHAINS)/bin/arm-linux-androideabi-cpp
    CXX = $(TOOLCHAINS)/bin/arm-linux-androideabi-g++
    AR  = $(TOOLCHAINS)/bin/arm-linux-androideabi-ar
    AS  = $(TOOLCHAINS)/bin/arm-linux-androideabi-as
    NM  = $(TOOLCHAINS)/bin/arm-linux-androideabi-nm
    STRIP = $(TOOLCHAINS)/bin/arm-linux-androideabi-strip
    
    # optimize and debug flags should be set in 'aimakefile'
    # -Os -O3 -DNDEBUG -g
    # -fpic
    # -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__ 
    # -ffunction-sections -funwind-tables -fstack-protector -Wno-psabi -fomit-frame-pointer -fno-strict-aliasing -finline-limit=300 -Wa,--noexecstack 
    # -I$(ANDROID_NDK_HOME)/sources/android/cpufeatures
    #
    #
    CFLAGS   += -fsigned-char -I$(PLATFORM)/usr/include 
    CXXFLAGS := $(CFLAGS) -I $(CXX_STL)/include -I $(CXX_STL)/libs/armeabi/include -I $(CXX_STL)/armeabi-fexceptions -frtti
    #-Wl,--fix-cortex-a8 -Wl,-z,nocopyreloc -Wl,--no-undefined -Wl,-z,noexecstack -Wl,--gc-sections 
    LDFLAGS := --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib -llog -lc $(CXX_STL)/libs/armeabi/libgnustl_static.a
    #libsupc++.a

    #LDFLAGS := -Wl,-z,nocopyreloc -Wl,--no-undefined -Wl,-z,noexecstack -Wl,--gc-sections --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib -llog -lc -lsupc++ $(CXX_STL)/libs/armeabi/libstdc++.a $(TOOLCHAINS)/lib/gcc/arm-linux-androideabi/4.4.3/libgcc.a

else ifeq (aarch64, $(findstring aarch64, $(ANDABI)))

    TOOLCHAINS = $(ANDROID_NDK_HOME)/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
    PLATFORM = $(ANDROID_NDK_HOME)/platforms/android-21/arch-arm64
    CXX_STL = $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.9
    
    CC  = $(TOOLCHAINS)/bin/aarch64-linux-android-gcc
    LD  = $(TOOLCHAINS)/bin/aarch64-linux-android-ld
    CPP = $(TOOLCHAINS)/bin/aarch64-linux-android-cpp
    CXX = $(TOOLCHAINS)/bin/aarch64-linux-android-g++
    AR  = $(TOOLCHAINS)/bin/aarch64-linux-android-ar
    AS  = $(TOOLCHAINS)/bin/aarch64-linux-android-as
    NM  = $(TOOLCHAINS)/bin/aarch64-linux-android-nm
    STRIP = $(TOOLCHAINS)/bin/aarch64-linux-android-strip
    
    # optimize and debug flags should be set in 'aimakefile'
    # -Os -O3 -DNDEBUG -g
    # -fpic
    # -D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__ 
    # -ffunction-sections -funwind-tables -fstack-protector -Wno-psabi -fomit-frame-pointer -fno-strict-aliasing -finline-limit=300 -Wa,--noexecstack 
    # -I$(ANDROID_NDK_HOME)/sources/android/cpufeatures
    #
    #
    CFLAGS   += -fsigned-char -I$(PLATFORM)/usr/include 
    CXXFLAGS := $(CFLAGS) -I $(CXX_STL)/include -I $(CXX_STL)/libs/arm64-v8a/include -I $(CXX_STL)/arm64-v8a-fexceptions -frtti
    #-Wl,--fix-cortex-a8 -Wl,-z,nocopyreloc -Wl,--no-undefined -Wl,-z,noexecstack -Wl,--gc-sections 
    LDFLAGS := --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib -llog -lc $(CXX_STL)/libs/arm64-v8a/libgnustl_static.a
	
else ifeq (mips64, $(findstring mips64, $(ANDABI)))

    TOOLCHAINS = $(ANDROID_NDK_HOME)/toolchains/mips64el-linux-android-4.9/prebuilt/linux-x86_64
    PLATFORM = $(ANDROID_NDK_HOME)/platforms/android-21/arch-mips64
    CXX_STL = $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.9
    
    CC  = $(TOOLCHAINS)/bin/mips64el-linux-android-gcc
    LD  = $(TOOLCHAINS)/bin/mips64el-linux-android-ld
    CPP = $(TOOLCHAINS)/bin/mips64el-linux-android-cpp
    CXX = $(TOOLCHAINS)/bin/mips64el-linux-android-g++
    AR  = $(TOOLCHAINS)/bin/mips64el-linux-android-ar
    AS  = $(TOOLCHAINS)/bin/mips64el-linux-android-as
    NM  = $(TOOLCHAINS)/bin/mips64el-linux-android-nm
    STRIP = $(TOOLCHAINS)/bin/mips64el-linux-android-strip

    CFLAGS   += -fsigned-char -I$(PLATFORM)/usr/include 
    CXXFLAGS := $(CFLAGS) -I $(CXX_STL)/include -I $(CXX_STL)/libs/mips64/include -I $(CXX_STL)/mips64-fexceptions -frtti
    LDFLAGS  := --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib64 -llog -lc $(CXX_STL)/libs/mips64/libgnustl_static.a
	
else ifeq (mips, $(findstring mips, $(ANDABI)))

    TOOLCHAINS = $(ANDROID_NDK_HOME)/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64
    PLATFORM = $(ANDROID_NDK_HOME)/platforms/android-9/arch-mips
    CXX_STL = $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.9
    
    CC  = $(TOOLCHAINS)/bin/mipsel-linux-android-gcc
    LD  = $(TOOLCHAINS)/bin/mipsel-linux-android-ld
    CPP = $(TOOLCHAINS)/bin/mipsel-linux-android-cpp
    CXX = $(TOOLCHAINS)/bin/mipsel-linux-android-g++
    AR  = $(TOOLCHAINS)/bin/mipsel-linux-android-ar
    AS  = $(TOOLCHAINS)/bin/mipsel-linux-android-as
    NM  = $(TOOLCHAINS)/bin/mipsel-linux-android-nm
    STRIP = $(TOOLCHAINS)/bin/mipsel-linux-android-strip

    CFLAGS   += -fsigned-char -I$(PLATFORM)/usr/include 
    CXXFLAGS := $(CFLAGS) -I $(CXX_STL)/include -I $(CXX_STL)/libs/mips/include -I $(CXX_STL)/mips-fexceptions -frtti
    LDFLAGS  := --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib -llog -lc $(CXX_STL)/libs/mips/libgnustl_static.a

else ifeq (i686, $(findstring i686, $(ANDABI)))

    TOOLCHAINS = $(ANDROID_NDK_HOME)/toolchains/x86-4.9/prebuilt/linux-x86_64
    PLATFORM = $(ANDROID_NDK_HOME)/platforms/android-9/arch-x86
    CXX_STL = $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.9
    
    CC  = $(TOOLCHAINS)/bin/i686-linux-android-gcc
    LD  = $(TOOLCHAINS)/bin/i686-linux-android-ld
    CPP = $(TOOLCHAINS)/bin/i686-linux-android-cpp
    CXX = $(TOOLCHAINS)/bin/i686-linux-android-g++
    AR  = $(TOOLCHAINS)/bin/i686-linux-android-ar
    AS  = $(TOOLCHAINS)/bin/i686-linux-android-as
    NM  = $(TOOLCHAINS)/bin/i686-linux-android-nm
    STRIP = $(TOOLCHAINS)/bin/i686-linux-android-strip

    CFLAGS   += -fsigned-char -I$(PLATFORM)/usr/include 
    CXXFLAGS := $(CFLAGS) -I $(CXX_STL)/include -I $(CXX_STL)/libs/x86/include -I $(CXX_STL)/x86-fexceptions -frtti
    LDFLAGS  := --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib -llog -lc $(CXX_STL)/libs/x86/libgnustl_static.a
    
else ifeq (x86_64, $(findstring x86_64, $(ANDABI)))

    TOOLCHAINS = $(ANDROID_NDK_HOME)/toolchains/x86_64-4.9/prebuilt/linux-x86_64
    PLATFORM = $(ANDROID_NDK_HOME)/platforms/android-21/arch-x86_64
    CXX_STL = $(ANDROID_NDK_HOME)/sources/cxx-stl/gnu-libstdc++/4.9
    
    CC  = $(TOOLCHAINS)/bin/x86_64-linux-android-gcc
    LD  = $(TOOLCHAINS)/bin/x86_64-linux-android-ld
    CPP = $(TOOLCHAINS)/bin/x86_64-linux-android-cpp
    CXX = $(TOOLCHAINS)/bin/x86_64-linux-android-g++
    AR  = $(TOOLCHAINS)/bin/x86_64-linux-android-ar
    AS  = $(TOOLCHAINS)/bin/x86_64-linux-android-as
    NM  = $(TOOLCHAINS)/bin/x86_64-linux-android-nm
    STRIP = $(TOOLCHAINS)/bin/x86_64-linux-android-strip

    CFLAGS   += -fsigned-char -I$(PLATFORM)/usr/include 
    CXXFLAGS := $(CFLAGS) -I $(CXX_STL)/include -I $(CXX_STL)/libs/x86_64/include -I $(CXX_STL)/x86_64-fexceptions -frtti
    LDFLAGS  := --sysroot=$(PLATFORM) -L$(PLATFORM)/usr/lib64 -llog -lc $(CXX_STL)/libs/x86_64/libgnustl_static.a

endif


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
