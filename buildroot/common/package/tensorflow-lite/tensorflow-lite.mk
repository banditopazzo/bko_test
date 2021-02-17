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

# ARM
ifeq ($(BR2_arm),y)
	ARMCC_FLAGS = -funsafe-math-optimizations -ldl -latomic
	ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
		ARMCC_FLAGS += -mfpu=neon
	else	
		TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_XNNPACK=OFF
		ARMCC_FLAGS += -mfloat-abi=softfp
	endif
	TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(ARMCC_FLAGS)"
	TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(ARMCC_FLAGS)"
else
	TENSORFLOW_LITE_CONF_OPTS += -DTFLITE_ENABLE_XNNPACK=OFF
	TENSORFLOW_LITE_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -fPIC -ldl -latomic"
endif


define TENSORFLOW_LITE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags.so $(TARGET_DIR)/usr/lib/libabsl_flags.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/hash/libabsl_hash.so $(TARGET_DIR)/usr/lib/libabsl_hash.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/status/libabsl_status.so $(TARGET_DIR)/usr/lib/libabsl_status.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/farmhash-build/libfarmhash.so $(TARGET_DIR)/usr/lib/libfarmhash.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/fft2d-build/libfft2d_fftsg2d.so $(TARGET_DIR)/usr/lib/libfft2d_fftsg2d.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/ruy-build/libruy.so $(TARGET_DIR)/usr/lib/libruy.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/fft2d-build/libfft2d_fftsg.so $(TARGET_DIR)/usr/lib/libfft2d_fftsg.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_internal.so $(TARGET_DIR)/usr/lib/libabsl_flags_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_registry.so $(TARGET_DIR)/usr/lib/libabsl_flags_registry.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_config.so $(TARGET_DIR)/usr/lib/libabsl_flags_config.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_program_name.so $(TARGET_DIR)/usr/lib/libabsl_flags_program_name.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/synchronization/libabsl_synchronization.so $(TARGET_DIR)/usr/lib/libabsl_synchronization.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/synchronization/libabsl_graphcycles_internal.so $(TARGET_DIR)/usr/lib/libabsl_graphcycles_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/time/libabsl_time.so $(TARGET_DIR)/usr/lib/libabsl_time.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/time/libabsl_civil_time.so $(TARGET_DIR)/usr/lib/libabsl_civil_time.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/time/libabsl_time_zone.so $(TARGET_DIR)/usr/lib/libabsl_time_zone.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_marshalling.so $(TARGET_DIR)/usr/lib/libabsl_flags_marshalling.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/types/libabsl_bad_variant_access.so $(TARGET_DIR)/usr/lib/libabsl_bad_variant_access.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/hash/libabsl_city.so $(TARGET_DIR)/usr/lib/libabsl_city.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/types/libabsl_bad_optional_access.so $(TARGET_DIR)/usr/lib/libabsl_bad_optional_access.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_stacktrace.so $(TARGET_DIR)/usr/lib/libabsl_stacktrace.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_symbolize.so $(TARGET_DIR)/usr/lib/libabsl_symbolize.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_debugging_internal.so $(TARGET_DIR)/usr/lib/libabsl_debugging_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_demangle_internal.so $(TARGET_DIR)/usr/lib/libabsl_demangle_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_malloc_internal.so $(TARGET_DIR)/usr/lib/libabsl_malloc_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_marshalling.so $(TARGET_DIR)/usr/lib/libabsl_flags_marshalling.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_cord.so $(TARGET_DIR)/usr/lib/libabsl_cord.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_str_format_internal.so $(TARGET_DIR)/usr/lib/libabsl_str_format_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_strings.so $(TARGET_DIR)/usr/lib/libabsl_strings.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_base.so $(TARGET_DIR)/usr/lib/libabsl_base.so 
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_dynamic_annotations.so $(TARGET_DIR)/usr/lib/libabsl_dynamic_annotations.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_spinlock_wait.so $(TARGET_DIR)/usr/lib/libabsl_spinlock_wait.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_strings_internal.so $(TARGET_DIR)/usr/lib/libabsl_strings_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/numeric/libabsl_int128.so $(TARGET_DIR)/usr/lib/libabsl_int128.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_throw_delegate.so $(TARGET_DIR)/usr/lib/libabsl_throw_delegate.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_raw_logging_internal.so $(TARGET_DIR)/usr/lib/libabsl_raw_logging_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_log_severity.so $(TARGET_DIR)/usr/lib/libabsl_log_severity.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/libtensorflow-lite.so $(TARGET_DIR)/usr/lib/libtensorflow-lite.so
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

	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/libtensorflow-lite.so $(STAGING_DIR)/usr/lib/libtensorflow-lite.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/flatbuffers-build/libflatbuffers.a $(STAGING_DIR)/usr/lib/libflatbuffers.a

	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags.so $(STAGING_DIR)/usr/lib/libabsl_flags.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/hash/libabsl_hash.so $(STAGING_DIR)/usr/lib/libabsl_hash.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/status/libabsl_status.so $(STAGING_DIR)/usr/lib/libabsl_status.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/farmhash-build/libfarmhash.so $(STAGING_DIR)/usr/lib/libfarmhash.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/fft2d-build/libfft2d_fftsg2d.so $(STAGING_DIR)/usr/lib/libfft2d_fftsg2d.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/ruy-build/libruy.so $(STAGING_DIR)/usr/lib/libruy.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/fft2d-build/libfft2d_fftsg.so $(STAGING_DIR)/usr/lib/libfft2d_fftsg.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_internal.so $(STAGING_DIR)/usr/lib/libabsl_flags_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_registry.so $(STAGING_DIR)/usr/lib/libabsl_flags_registry.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_config.so $(STAGING_DIR)/usr/lib/libabsl_flags_config.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_program_name.so $(STAGING_DIR)/usr/lib/libabsl_flags_program_name.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/synchronization/libabsl_synchronization.so $(STAGING_DIR)/usr/lib/libabsl_synchronization.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/synchronization/libabsl_graphcycles_internal.so $(STAGING_DIR)/usr/lib/libabsl_graphcycles_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/time/libabsl_time.so $(STAGING_DIR)/usr/lib/libabsl_time.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/time/libabsl_civil_time.so $(STAGING_DIR)/usr/lib/libabsl_civil_time.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/time/libabsl_time_zone.so $(STAGING_DIR)/usr/lib/libabsl_time_zone.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_marshalling.so $(STAGING_DIR)/usr/lib/libabsl_flags_marshalling.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/types/libabsl_bad_variant_access.so $(STAGING_DIR)/usr/lib/libabsl_bad_variant_access.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/hash/libabsl_city.so $(STAGING_DIR)/usr/lib/libabsl_city.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/types/libabsl_bad_optional_access.so $(STAGING_DIR)/usr/lib/libabsl_bad_optional_access.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_stacktrace.so $(STAGING_DIR)/usr/lib/libabsl_stacktrace.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_symbolize.so $(STAGING_DIR)/usr/lib/libabsl_symbolize.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_debugging_internal.so $(STAGING_DIR)/usr/lib/libabsl_debugging_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/debugging/libabsl_demangle_internal.so $(STAGING_DIR)/usr/lib/libabsl_demangle_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_malloc_internal.so $(STAGING_DIR)/usr/lib/libabsl_malloc_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/flags/libabsl_flags_marshalling.so $(STAGING_DIR)/usr/lib/libabsl_flags_marshalling.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_cord.so $(STAGING_DIR)/usr/lib/libabsl_cord.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_str_format_internal.so $(STAGING_DIR)/usr/lib/libabsl_str_format_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_strings.so $(STAGING_DIR)/usr/lib/libabsl_strings.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_base.so $(STAGING_DIR)/usr/lib/libabsl_base.so 
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_dynamic_annotations.so $(STAGING_DIR)/usr/lib/libabsl_dynamic_annotations.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_spinlock_wait.so $(STAGING_DIR)/usr/lib/libabsl_spinlock_wait.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/strings/libabsl_strings_internal.so $(STAGING_DIR)/usr/lib/libabsl_strings_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/numeric/libabsl_int128.so $(STAGING_DIR)/usr/lib/libabsl_int128.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_throw_delegate.so $(STAGING_DIR)/usr/lib/libabsl_throw_delegate.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_raw_logging_internal.so $(STAGING_DIR)/usr/lib/libabsl_raw_logging_internal.so
	$(INSTALL) -D $(TENSORFLOW_LITE_BUILDDIR)/_deps/abseil-cpp-build/absl/base/libabsl_log_severity.so $(STAGING_DIR)/usr/lib/libabsl_log_severity.so
endef

$(eval $(cmake-package))
