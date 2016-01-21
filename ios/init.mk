#
# ios sdk configuration
# ios6 does not support armv6, so I removed it
#
#DEVROOT_DEV = /Developer/Platforms/iPhoneOS.platform/Developer
#DEVROOT_SIM = /Developer/Platforms/iPhoneSimulator.platform/Developer

#SDKROOT_DEV = $(DEVROOT_DEV)/SDKs/iPhoneOS5.0.sdk
#SDKROOT_SIM = $(DEVROOT_SIM)/SDKs/iPhoneSimulator5.0.sdk

#DEVROOT_DEV = /Applications/Xcode\ 2.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
#DEVROOT_SIM = /Applications/Xcode\ 2.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer

#SDKROOT_DEV = $(DEVROOT_DEV)/SDKs/iPhoneOS6.1.sdk
#SDKROOT_SIM = $(DEVROOT_SIM)/SDKs/iPhoneSimulator6.1.sdk

DEVROOT_DEV = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
DEVROOT_SIM = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer

SDKROOT_DEV = $(DEVROOT_DEV)/SDKs/iPhoneOS.sdk
SDKROOT_SIM = $(DEVROOT_SIM)/SDKs/iPhoneSimulator.sdk


#
# optimize configuration
#
CFLAGS_ARMV7_OPTIMIZE = -mcpu=cortex-a8 -mfpu=neon -ftree-vectorize -mfloat-abi=softfp #-ffast-math
CFLAGS_ARMV7S_OPTIMIZE = $(CFLAGS_ARMV7_OPTIMIZE)

CFLAGS_ARMV8_OPTIMIZE = -ftree-vectorize #-ffast-math
CFLAGS_ARMV8S_OPTIMIZE = $(CFLAGS_ARMV8_OPTIMIZE)

#-fsingle-precision-constant

#
# build variables
#

# device armv7, armv7s
CC_DEV      = /Applications/Xcode.app/Contents/Developer/usr/bin/gcc #$(DEVROOT_DEV)/usr/bin/llvm-gcc
LD_DEV      = $(DEVROOT_DEV)/usr/bin/ld
#CPP_DEV     = $(DEVROOT_DEV)/usr/bin/cpp
CXX_DEV     = /Applications/Xcode.app/Contents/Developer/usr/bin/g++ #$(DEVROOT_DEV)/usr/bin/llvm-g++
AR_DEV      = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ar
AS_DEV      = $(DEVROOT_DEV)/usr/bin/as
NM_DEV      = $(DEVROOT_DEV)/usr/bin/nm
#CXXCPP_DEV  = $(DEVROOT_DEV)/usr/bin/cpp
RANLIB_DEV  = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib

#CFLAGS_DEV  = -std=gnu99 -no-cpp-precomp -isysroot $(SDKROOT_DEV) -I$(SDKROOT_DEV)/usr/include -D__IPHONE_OS__
CFLAGS_DEV  = -no-cpp-precomp -isysroot $(SDKROOT_DEV) -I$(SDKROOT_DEV)/usr/include -D__IPHONE_OS__ -miphoneos-version-min=4.0 -fembed-bitcode-marker
LDFLAGS_DEV = -L$(SDKROOT_DEV)/usr/lib -lstdc++

CFLAGS_ARMV7 = -arch armv7 $(CFLAGS_ARMV7_OPTIMIZE) $(CFLAGS_DEV)
CFLAGS_ARMV7S = -arch armv7s $(CFLAGS_ARMV7S_OPTIMIZE) $(CFLAGS_DEV)
CFLAGS_ARMV8 = -arch arm64 $(CFLAGS_ARMV8_OPTIMIZE) $(CFLAGS_DEV)

CXXFLAGS_ARMV7 = $(CFLAGS_ARMV7)
CXXFLAGS_ARMV7S = $(CFLAGS_ARMV7S)
CXXFLAGS_ARMV8 = $(CFLAGS_ARMV8)

# simulator
CC_SIM      = /Applications/Xcode.app/Contents/Developer/usr/bin/gcc #$(DEVROOT_SIM)/usr/bin/gcc
LD_SIM      = /Applications/Xcode.app/Contents/Developer/usr/bin/ld #$(DEVROOT_SIM)/usr/bin/ld
#CPP_SIM     = $(DEVROOT_SIM)/usr/bin/cpp
CXX_SIM     = /Applications/Xcode.app/Contents/Developer/usr/bin/g++ #$(DEVROOT_SIM)/usr/bin/g++
AR_SIM      = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ar #$(DEVROOT_SIM)/usr/bin/ar
AS_SIM      = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/as #$(DEVROOT_SIM)/usr/bin/as
NM_SIM      = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm #$(DEVROOT_SIM)/usr/bin/nm
#CXXCPP_SIM  = $(DEVROOT_SIM)/usr/bin/cpp
RANLIB_SIM  = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib #$(DEVROOT_SIM)/usr/bin/ranlib

CFLAGS_SIM  := -no-cpp-precomp -isysroot $(SDKROOT_SIM) -I$(SDKROOT_SIM)/usr/include  -D__IPHONE_OS__ -miphoneos-version-min=4.0 -fembed-bitcode-marker
LDFLAGS_SIM := -L$(SDKROOT_SIM)/usr/lib -lstdc++

CFLAGS_I386   := -arch i386 $(CFLAGS_SIM)
CXXFLAGS_I386 := $(CFLAGS_I386)

CFLAGS_X86_64   := -arch x86_64 $(CFLAGS_SIM)
CXXFLAGS_X86_64 := $(CFLAGS_X86_64)


#
# explict rules
#
%.armv7.o : %.c
	$(CC_DEV) $(LOCAL_CFLAGS) $(CFLAGS_ARMV7) -c $< -o $@

%.armv7s.o : %.c
	$(CC_DEV) $(LOCAL_CFLAGS) $(CFLAGS_ARMV7S) -c $< -o $@

%.armv8.o : %.c
	$(CC_DEV) $(LOCAL_CFLAGS) $(CFLAGS_ARMV8) -c $< -o $@

%.i386.o  : %.c
	$(CC_SIM) $(LOCAL_CFLAGS) $(CFLAGS_I386) -c $< -o $@

%.x86_64.o  : %.c
	$(CC_SIM) $(LOCAL_CFLAGS) $(CFLAGS_X86_64) -c $< -o $@

%.armv7.o : %.cc
	$(CXX_DEV) $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7) -c $< -o $@

%.armv7s.o : %.cc
	$(CXX_DEV) $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7S) -c $< -o $@

%.armv8.o : %.cc
	$(CXX_DEV) $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV8) -c $< -o $@

%.i386.o  : %.cc
	$(CXX_SIM) $(LOCAL_CXXFLAGS) $(CXXFLAGS_I386) -c $< -o $@

%.x86_64.o  : %.cc
	$(CXX_SIM) $(LOCAL_CXXFLAGS) $(CXXFLAGS_X86_64) -c $< -o $@

%.armv7.o : %.cpp
	$(CXX_DEV) $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7) -c $< -o $@

%.armv7s.o : %.cpp
	$(CXX_DEV) $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7S) -c $< -o $@

%.armv8.o : %.cpp
	$(CXX_DEV) $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV8) -c $< -o $@

%.i386.o  : %.cpp
	$(CXX_SIM) $(LOCAL_CXXFLAGS) $(CXXFLAGS_I386) -c $< -o $@

%.x86_64.o  : %.cpp
	$(CXX_SIM) $(LOCAL_CXXFLAGS) $(CXXFLAGS_X86_64) -c $< -o $@

%.armv7.o : %.m
	$(CC_DEV) -x objective-c -std=gnu99 -D__IPHONE_OS_VERSION_MIN_REQUIRED=30100 -fobjc-abi-version=2 -fobjc-legacy-dispatch $(LOCAL_CFLAGS) $(CFLAGS_ARMV7) -std=gnu99 -c $< -o $@

%.armv7s.o : %.m
	$(CC_DEV) -x objective-c -std=gnu99 -D__IPHONE_OS_VERSION_MIN_REQUIRED=30100 -fobjc-abi-version=2 -fobjc-legacy-dispatch $(LOCAL_CFLAGS) $(CFLAGS_ARMV7S) -std=gnu99 -c $< -o $@

%.armv8.o : %.m
	$(CC_DEV) -x objective-c -std=gnu99 -D__IPHONE_OS_VERSION_MIN_REQUIRED=30100 -fobjc-abi-version=2 -fobjc-legacy-dispatch $(LOCAL_CFLAGS) $(CFLAGS_ARMV8) -std=gnu99 -c $< -o $@

%.i386.o  : %.m
	$(CC_SIM) -x objective-c -std=gnu99 -D__IPHONE_OS_VERSION_MIN_REQUIRED=30100 -fobjc-abi-version=2 -fobjc-legacy-dispatch $(LOCAL_CFLAGS) $(CFLAGS_I386) -std=gnu99 -c $< -o $@

%.x86_64.o  : %.m
	$(CC_SIM) -x objective-c -std=gnu99 -D__IPHONE_OS_VERSION_MIN_REQUIRED=30100 -fobjc-abi-version=2 -fobjc-legacy-dispatch $(LOCAL_CFLAGS) $(CFLAGS_X86_64) -std=gnu99 -c $< -o $@


#
# build targets
#
EXECUTABLE        = $(LOCAL_MODULE)
EXECUTABLE_ARMV7  = $(LOCAL_MODULE).armv7
EXECUTABLE_ARMV7S = $(LOCAL_MODULE).armv7s
EXECUTABLE_I386   = $(LOCAL_MODULE).i386
EXECUTABLE_X86_64 = $(LOCAL_MODULE).x86_64

STATIC_LIBRARY        = lib$(LOCAL_MODULE).a
STATIC_LIBRARY_ARMV7  = lib$(LOCAL_MODULE).armv7.a
STATIC_LIBRARY_ARMV7S = lib$(LOCAL_MODULE).armv7s.a
STATIC_LIBRARY_I386   = lib$(LOCAL_MODULE).i386.a
STATIC_LIBRARY_X86_64 = lib$(LOCAL_MODULE).x86_64.a

SHARED_LIBRARY        = lib$(LOCAL_MODULE).dylib
SHARED_LIBRARY_ARMV7  = lib$(LOCAL_MODULE).armv7.dylib
SHARED_LIBRARY_ARMV7S = lib$(LOCAL_MODULE).armv7s.dylib
SHARED_LIBRARY_I386   = lib$(LOCAL_MODULE).i386.dylib
SHARED_LIBRARY_X86_64 = lib$(LOCAL_MODULE).x86_64.dylib

PACKAGE  = $(LOCAL_MODULE)-$(TARGET_PLATFORM)-$(VERSION)-$(TIMESTAMP).tar.gz
