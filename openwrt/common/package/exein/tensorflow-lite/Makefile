#
# Copyright (C) 2019 Exein
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tensorflow-lite
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tensorflow/tensorflow.git
PKG_SOURCE_VERSION:=9663abe4c9037030b0b497c68cc4b2ba991967dd
PKG_MIRROR_HASH:=08e6bcdccc83a48f52466d3eccca9cbee82e6be7095a6987c507d72394d37552

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Exein <info@exein.io>

TENSORFLOW_SUBDIR = tensorflow/lite
CMAKE_SOURCE_SUBDIR:=$(TENSORFLOW_SUBDIR)
PKG_SUPPORTS_IN_SOURCE_BUILD = NO

PKG_INSTALL:=1
CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/tensorflow-lite
	SECTION:=libs
	CATEGORY:=Exein
	TITLE:=TensorFlow Lite is the official solution for running machine learning models on mobile and embedded devices.
	DEPENDS:=+libstdcpp +libatomic
endef


#ARMCC_FLAGS += -march=armv7-m

CMAKE_OPTIONS += \
	-DSYSROOT=$(STAGING_DIR) \
	-DCMAKE_INSTALL_PREFIX="/usr" \
	-DCMAKE_COLOR_MAKEFILE=OFF \
	-DBUILD_DOC=OFF \
	-DBUILD_DOCS=OFF \
	-DBUILD_EXAMPLE=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_TEST=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_TESTING=OFF \
	-DBUILD_SHARED_LIBS=ON

	# -DCMAKE_C_FLAGS="$(TARGET_CPPFLAGS) $(ARMCC_FLAGS)" \
	# -DCMAKE_CXX_FLAGS="$(TARGET_CPPFLAGS) $(ARMCC_FLAGS)" \
	# -DTFLITE_ENABLE_XNNPACK=OFF \
	# -DCMAKE_SYSTEM_PROCESSOR=armv7

COMMON_FLAGS = -ldl -latomic

# ARM or AARCH64
ifeq ($(or $(CONFIG_arm),$(CONFIG_aarch64)),y)
	ARMCC_FLAGS = -funsafe-math-optimizations # TODO: maybe even in mips
	ifeq ($(CONFIG_arm_v8),y) # ARMv8
		ARMCC_FLAGS += -march=armv8-a
		CMAKE_OPTIONS += -DCMAKE_SYSTEM_PROCESSOR=armv8
	else
		CMAKE_OPTIONS += -DTFLITE_ENABLE_XNNPACK=OFF
		ifeq ($(CONFIG_arm_v7),y) # ARMv7
			ARMCC_FLAGS += -march=armv7
			CMAKE_OPTIONS += -DCMAKE_SYSTEM_PROCESSOR=armv7
			ifeq ($(BR2_ARM_CPU_HAS_NEON),y) # ARMv7A + NEON
				ARMCC_FLAGS += -mfpu=neon
			else
				ARMCC_FLAGS += -mfloat-abi=softfp
			endif
		# else ifeq ($(BR2_ARM_CPU_ARMV7M),y) # ARMv7M
		# 	ARMCC_FLAGS += -march=armv7-m
		# 	CMAKE_OPTIONS += -DCMAKE_SYSTEM_PROCESSOR=armv7
		else ifeq ($(CONFIG_arm_v6),y) # ARMv6
			ARMCC_FLAGS += -march=armv6
			CMAKE_OPTIONS += -DCMAKE_SYSTEM_PROCESSOR=armv6
		else ifeq ($(CONFIG_arm_v5),y) # ARMv5
			ARMCC_FLAGS += -march=armv5
			CMAKE_OPTIONS += -DCMAKE_SYSTEM_PROCESSOR=armv5
		else ifeq ($(CONFIG_arm_v4),y) # ARMv4
			ARMCC_FLAGS += -march=armv4
			CMAKE_OPTIONS += -DCMAKE_SYSTEM_PROCESSOR=armv4
		endif
	endif
	CMAKE_OPTIONS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(ARMCC_FLAGS)"
	CMAKE_OPTIONS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(ARMCC_FLAGS)"
else # This is intended for MIPS
	CMAKE_OPTIONS += -DTFLITE_ENABLE_XNNPACK=OFF
	CMAKE_OPTIONS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(COMMON_FLAGS) -fPIC"
	CMAKE_OPTIONS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(COMMON_FLAGS) -fPIC"
endif


define Package/tensorflow-lite/install
	$(INSTALL_DIR) $(1)/usr/lib/
	# $(INSTALL_BIN) $(PKG_BUILD_DIR)/tensorflow/lite/*.so $(1)/usr/lib
	find $(PKG_BUILD_DIR) -name \*.so -exec cp {} $(1)/usr/lib/ \;

endef

TENSORFLOW_LITE_SUBDIR = $(PKG_BUILD_DIR)/$(TENSORFLOW_SUBDIR)
TENSORFLOW_LITE_INCLUDEDIR = $(1)/usr/include/$(TENSORFLOW_SUBDIR)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib/
	# $(INSTALL_BIN) $(PKG_BUILD_DIR)/tensorflow/lite/*.so $(1)/usr/lib
	find $(PKG_BUILD_DIR) -name \*.so -exec cp {} $(1)/usr/lib/ \;

	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)

	# Tensorlow
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/*.h $(TENSORFLOW_LITE_INCLUDEDIR)
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/c
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/c/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/c
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/nnapi
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/nnapi/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/nnapi
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/kernels
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/kernels/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/kernels
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/schema
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/schema/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/schema
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/core
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/core/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/core
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/core/api
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/core/api/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/core/api
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/delegates/nnapi
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/delegates/nnapi/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/delegates/nnapi
	mkdir -p $(TENSORFLOW_LITE_INCLUDEDIR)/experimental/resource
	$(CP) -a $(TENSORFLOW_LITE_SUBDIR)/experimental/resource/*.h $(TENSORFLOW_LITE_INCLUDEDIR)/experimental/resource
	
	# Flatbuffers
	mkdir -p $(1)/usr/include/flatbuffers
	$(CP) -a $(PKG_BUILD_DIR)/flatbuffers/include/flatbuffers/*.h $(1)/usr/include/flatbuffers

endef

$(eval $(call BuildPackage,tensorflow-lite))
