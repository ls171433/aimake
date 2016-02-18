#
# objects
#
ifneq ($(LOCAL_SRC_DIRS),)
    LOCAL_SRC_FILES += $(shell find $(LOCAL_SRC_DIRS) -name "*.c" -or -name "*.cpp" -or -name "*.cc" -or -name "*.m")
endif
ifneq ($(LOCAL_SRC_DIRS_EXCLUDE),)
    LOCAL_SRC_FILES_EXCLUDE += $(shell find $(LOCAL_SRC_DIRS_EXCLUDE) -name "*.c" -or -name "*.cpp" -or -name "*.cc" -r -name "*.m")
endif

LOCAL_SRC_FILES  := $(filter-out $(LOCAL_SRC_FILES_EXCLUDE), $(LOCAL_SRC_FILES))


OBJECTS_ARMV7  = $(subst .c,.armv7.o,  $(subst .cpp,.armv7.o,  $(subst .cc,.armv7.o,  $(subst .m,.armv7.o,  $(LOCAL_SRC_FILES)))))
OBJECTS_ARMV7S = $(subst .c,.armv7s.o, $(subst .cpp,.armv7s.o, $(subst .cc,.armv7s.o, $(subst .m,.armv7s.o, $(LOCAL_SRC_FILES)))))
OBJECTS_I386   = $(subst .c,.i386.o,   $(subst .cpp,.i386.o,   $(subst .cc,.i386.o,   $(subst .m,.i386.o,   $(LOCAL_SRC_FILES)))))
OBJECTS_X86_64 = $(subst .c,.x86_64.o, $(subst .cpp,.x86_64.o, $(subst .cc,.x86_64.o, $(subst .m,.x86_64.o, $(LOCAL_SRC_FILES)))))
OBJECTS_ARMV8  = $(subst .c,.armv8.o,  $(subst .cpp,.armv8.o,  $(subst .cc,.armv8.o,  $(subst .m,.armv8.o,  $(LOCAL_SRC_FILES)))))


#
# build targets
#
EXECUTABLE        = $(LOCAL_MODULE)
EXECUTABLE_ARMV7  = $(LOCAL_MODULE).armv7
EXECUTABLE_ARMV7S = $(LOCAL_MODULE).armv7s
EXECUTABLE_ARMV8  = $(LOCAL_MODULE).armv8
EXECUTABLE_I386   = $(LOCAL_MODULE).i386
EXECUTABLE_X86_64 = $(LOCAL_MODULE).x86_64

STATIC_LIBRARY        = lib$(LOCAL_MODULE).a
STATIC_LIBRARY_ARMV7  = lib$(LOCAL_MODULE).armv7.a
STATIC_LIBRARY_ARMV7S = lib$(LOCAL_MODULE).armv7s.a
STATIC_LIBRARY_ARMV8  = lib$(LOCAL_MODULE).armv8.a
STATIC_LIBRARY_I386   = lib$(LOCAL_MODULE).i386.a
STATIC_LIBRARY_X86_64 = lib$(LOCAL_MODULE).x86_64.a

SHARED_LIBRARY        = lib$(LOCAL_MODULE).dylib
SHARED_LIBRARY_ARMV7  = lib$(LOCAL_MODULE).armv7.dylib
SHARED_LIBRARY_ARMV7S = lib$(LOCAL_MODULE).armv7s.dylib
SHARED_LIBRARY_ARMV8  = lib$(LOCAL_MODULE).armv8.dylib
SHARED_LIBRARY_I386   = lib$(LOCAL_MODULE).i386.dylib
SHARED_LIBRARY_X86_64 = lib$(LOCAL_MODULE).x86_64.dylib

PACKAGE  = $(LOCAL_MODULE)-$(TARGET_PLATFORM)-$(VERSION)-$(TIMESTAMP).tar.gz


#
# goal: all
#
all: $(ALL)

$(EXECUTABLE) : $(EXECUTABLE_ARMV7) $(EXECUTABLE_ARMV7S) $(EXECUTABLE_ARMV8) $(EXECUTABLE_I386) $(EXECUTABLE_X86_64)
	xcrun -sdk iphoneos lipo -output $@ -create -arch armv7 $(EXECUTABLE_ARMV7) -arch armv7s $(EXECUTABLE_ARMV7S) -arch arm64 $(EXECUTABLE_ARMV8) -arch i386 $(EXECUTABLE_I386) -arch x86_64 $(EXECUTABLE_X86_64)

$(EXECUTABLE_ARMV7) : $(OBJECTS_ARMV7)
	$(CXX_DEV) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7) $(LOCAL_LDFLAGS) $(LDFLAGS_DEV) -o $@

$(EXECUTABLE_ARMV7S) : $(OBJECTS_ARMV7S)
	$(CXX_DEV) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7S) $(LOCAL_LDFLAGS) $(LDFLAGS_DEV) -o $@

$(EXECUTABLE_ARMV8) : $(OBJECTS_ARMV8)
	$(CXX_DEV) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV8) $(LOCAL_LDFLAGS) $(LDFLAGS_DEV) -o $@

$(EXECUTABLE_I386) : $(OBJECTS_I386)
	$(CXX_SIM) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_I386) $(LOCAL_LDFLAGS) $(LDFLAGS_SIM) -o $@

$(EXECUTABLE_X86_64) : $(OBJECTS_X86_64)
	$(CXX_SIM) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_X86_64) $(LOCAL_LDFLAGS) $(LDFLAGS_SIM) -o $@


$(SHARED_LIBRARY) : $(SHARED_LIBRARY_ARMV7) $(SHARED_LIBRARY_ARMV7S) $(SHARED_LIBRARY_ARMV8) $(SHARED_LIBRARY_I386) $(SHARED_LIBRARY_X86_64)
	xcrun -sdk iphoneos lipo -output $@ -create -arch armv7 $(SHARED_LIBRARY_ARMV7) -arch armv7s $(SHARED_LIBRARY_ARMV7S) -arch arm64 $(SHARED_LIBRARY_ARMV8) -arch i386 $(SHARED_LIBRARY_I386) -arch x86_64 $(SHARED_LIBRARY_X86_64)

$(SHARED_LIBRARY_ARMV7) : $(OBJECTS_ARMV7)
	$(CXX_DEV) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7) $(LOCAL_LDFLAGS) $(LDFLAGS_DEV) -o $@

$(SHARED_LIBRARY_ARMV7S) : $(OBJECTS_ARMV7S)
	$(CXX_DEV) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV7S) $(LOCAL_LDFLAGS) $(LDFLAGS_DEV) -o $@

$(SHARED_LIBRARY_ARMV8) : $(OBJECTS_ARMV8)
	$(CXX_DEV) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_ARMV8) $(LOCAL_LDFLAGS) $(LDFLAGS_DEV) -o $@

$(SHARED_LIBRARY_I386) : $(OBJECTS_I386)
	$(CXX_SIM) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_I386) $(LOCAL_LDFLAGS)  $(LDFLAGS_SIM) -o $@

$(SHARED_LIBRARY_X86_64) : $(OBJECTS_X86_64)
	$(CXX_SIM) $^ $(LOCAL_CXXFLAGS) $(CXXFLAGS_X86_64) $(LOCAL_LDFLAGS)  $(LDFLAGS_SIM) -o $@


$(STATIC_LIBRARY) : $(STATIC_LIBRARY_ARMV7) $(STATIC_LIBRARY_ARMV7S) $(STATIC_LIBRARY_ARMV8) $(STATIC_LIBRARY_I386) $(STATIC_LIBRARY_X86_64)
	xcrun -sdk iphoneos lipo -output $@ -create -arch armv7 $(STATIC_LIBRARY_ARMV7) -arch armv7s $(STATIC_LIBRARY_ARMV7S) -arch arm64 $(STATIC_LIBRARY_ARMV8) -arch i386 $(STATIC_LIBRARY_I386) -arch x86_64 $(STATIC_LIBRARY_X86_64)
	xcrun -sdk iphoneos lipo -output lib$(LOCAL_MODULE)_iphoneos.a -create -arch armv7 $(STATIC_LIBRARY_ARMV7) -arch armv7s $(STATIC_LIBRARY_ARMV7S) -arch arm64 $(STATIC_LIBRARY_ARMV8)
	xcrun -sdk iphoneos lipo -output lib$(LOCAL_MODULE)_iphonesimulator.a -create -arch i386 $(STATIC_LIBRARY_I386) -arch x86_64 $(STATIC_LIBRARY_X86_64)
	
$(STATIC_LIBRARY_ARMV7) : $(OBJECTS_ARMV7)
	$(AIMAKE_HOME)/$(TARGET_PLATFORM)/rlipo.sh armv7 $(LOCAL_PATH)/.rlipo.armv7 $(LOCAL_LDFLAGS) >/dev/null
	$(AR_DEV) crv $@ $^ `find $(LOCAL_PATH)/.rlipo.armv7 -type f -regex .*\.o 2>/dev/null | xargs`

$(STATIC_LIBRARY_ARMV7S) : $(OBJECTS_ARMV7S)
	$(AIMAKE_HOME)/$(TARGET_PLATFORM)/rlipo.sh armv7s $(LOCAL_PATH)/.rlipo.armv7s $(LOCAL_LDFLAGS) >/dev/null
	$(AR_DEV) crv $@ $^ `find $(LOCAL_PATH)/.rlipo.armv7s -type f -regex .*\.o 2>/dev/null | xargs`

$(STATIC_LIBRARY_ARMV8) : $(OBJECTS_ARMV8)
	$(AIMAKE_HOME)/$(TARGET_PLATFORM)/rlipo.sh arm64 $(LOCAL_PATH)/.rlipo.armv8 $(LOCAL_LDFLAGS) >/dev/null
	$(AR_DEV) crv $@ $^ `find $(LOCAL_PATH)/.rlipo.armv8 -type f -regex .*\.o 2>/dev/null | xargs`

$(STATIC_LIBRARY_I386)  : $(OBJECTS_I386)
	$(AIMAKE_HOME)/$(TARGET_PLATFORM)/rlipo.sh i386 $(LOCAL_PATH)/.rlipo.i386 $(LOCAL_LDFLAGS) >/dev/null
	$(AR_SIM) crv $@ $^ `find $(LOCAL_PATH)/.rlipo.i386 -type f -regex .*\.o 2>/dev/null | xargs`

$(STATIC_LIBRARY_X86_64)  : $(OBJECTS_X86_64)
	$(AIMAKE_HOME)/$(TARGET_PLATFORM)/rlipo.sh x86_64 $(LOCAL_PATH)/.rlipo.x86_64 $(LOCAL_LDFLAGS) >/dev/null
	$(AR_SIM) crv $@ $^ `find $(LOCAL_PATH)/.rlipo.x86_64 -type f -regex .*\.o 2>/dev/null | xargs`


#
# goal: clean
#
clean:
	rm -rf $(EXECUTABLE) $(EXECUTABLE_ARMV7) $(EXECUTABLE_ARMV7S) $(EXECUTABLE_ARMV8) $(EXECUTABLE_I386) $(EXECUTABLE_X86_64) $(STATIC_LIBRARY) $(STATIC_LIBRARY_ARMV7) $(STATIC_LIBRARY_ARMV7S) $(STATIC_LIBRARY_ARMV8) $(STATIC_LIBRARY_I386) $(STATIC_LIBRARY_X86_64) $(PACKAGE) $(OBJECTS_ARMV7) $(OBJECTS_ARMV7S) $(OBJECTS_ARMV8) $(OBJECTS_I386) $(OBJECTS_X86_64) $(LOCAL_PATH)/.rlipo.*

#
# goal: package
#
ifeq ($(findstring package,$(MAKECMDGOALS)),package)
    ifeq ($(VERSION),)
        $(error require argument 'VERSION' for 'package' goal)
    endif
    ifeq ($(PACKAGE_RESOURCES),)
    endif
endif

LOCAL_PACKAGE_RESOURCES += $(ALL)
ifneq ($(LOCAL_PACKAGE_RESOURCES_EXCLUDE),)
    LOCAL_PACKAGE_RESOURCES := $(filter-out $(LOCAL_PACKAGE_RESOURCES_EXCLUDE), $(LOCAL_PACKAGE_RESOURCES))
endif

PACKAGE_TEMP_DIR = $(PACKAGE:.tar.gz=)
package: $(PACKAGE)
$(PACKAGE): $(LOCAL_PACKAGE_RESOURCES) 
	@[ -e $(PACKAGE_TEMP_DIR) ] && echo "$(PACKAGE_TEMP_DIR) already exist, please delete it manually" && exit;\
	rm -rf $(PACKAGE_TEMP_DIR);\
	rm -rf $@;
	mkdir -p $(PACKAGE_TEMP_DIR);
	cp -Rf -L $(LOCAL_PACKAGE_RESOURCES) $(PACKAGE_TEMP_DIR);
	tar --exclude .svn -h -czf $@ $(PACKAGE_TEMP_DIR);
	rm -rf $(PACKAGE_TEMP_DIR); 
