################################################################################
#
# tensorflow-lite
#
################################################################################

TENSORFLOW_LITE_VERSION = 9663abe4c9037030b0b497c68cc4b2ba991967dd
TENSORFLOW_LITE_SITE = $(call github,tensorflow,tensorflow,$(TENSORFLOW_LITE_VERSION))

TENSORFLOW_LITE_LICENSE = Apache-2.0
TENSORFLOW_LITE_LICENSE_FILES = LICENSE

TENSORFLOW_LITE_INSTALL_STAGING = YES
TENSORFLOW_LITE_SUBDIR = tensorflow/lite
TENSORFLOW_LITE_SUPPORTS_IN_SOURCE_BUILD = NO

TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_USER_MAKE_RULES_OVERRIDE=$(TOPDIR)/$(TENSORFLOW_LITE_PKGDIR)000-patch-root-path.cmake


# ARM or AARCH64
ifeq ($(or $(BR2_arm),$(BR2_aarch64)),y)
	ARMCC_FLAGS = -funsafe-math-optimizations -ldl -latomic
	ifeq ($(BR2_ARM_CPU_ARMV7A),y)
		ARMCC_FLAGS += -march=armv7-a
		TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_SYSTEM_PROCESSOR=armv7
		TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_XNNPACK=OFF
		ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
			ARMCC_FLAGS += -mfpu=neon
		else
			ARMCC_FLAGS += -mfloat-abi=softfp
		endif
	else ifeq ($(BR2_ARM_CPU_ARMV8A),y)
		ARMCC_FLAGS += -march=armv8-a
		TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_SYSTEM_PROCESSOR=armv8
		XNNPACK = ON
	endif
	TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(ARMCC_FLAGS)"
	TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(ARMCC_FLAGS)"
else
	TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_XNNPACK=OFF
	TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -fPIC -ldl -latomic"
endif


define TENSORFLOW_LITE_INSTALL_TARGET_CMDS
	find $(TENSORFLOW_LITE_BUILDDIR) -name \*.so -exec cp {} $(TARGET_DIR)/usr/lib/ \;
endef

TENSORFLOW_LITE_INCLUDEDIR = $(STAGING_DIR)/usr/include/$(TENSORFLOW_LITE_SUBDIR)

define TENSORFLOW_LITE_INSTALL_STAGING_CMDS
	$(RM) -r $(TENSORFLOW_LITE_INCLUDEDIR)
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)

	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/*.h $(TENSORFLOW_LITE_INCLUDEDIR)
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/c
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/c/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/c
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/nnapi
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/nnapi/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/nnapi
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/kernels
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/kernels/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/kernels
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/schema
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/schema/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/schema
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/core
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/core/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/core
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/core/api
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/core/api/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/core/api
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/delegates/nnapi
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/delegates/nnapi/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/delegates/nnapi
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/experimental/resource
	cp -a $(@D)/$(TENSORFLOW_LITE_SUBDIR)/experimental/resource/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/experimental/resource
	mkdir -p $(STAGING_DIR)/usr/include/flatbuffers
	cp -a $(TENSORFLOW_LITE_BUILDDIR)/flatbuffers/include/flatbuffers/*.h $(STAGING_DIR)/usr/include/flatbuffers

	find $(TENSORFLOW_LITE_BUILDDIR) -name \*.so -exec cp {} $(STAGING_DIR)/usr/lib/ \;
endef

$(eval $(cmake-package))
