LIBEXNL_VERSION = 0.7.1
LIBEXNL_SITE = $(call github,Exein-io,libexnl,v$(LIBEXNL_VERSION))

TENSORFLOW_LITE_LICENSE = GPL-3.0
TENSORFLOW_LITE_LICENSE_FILES = LICENSE

LIBEXNL_INSTALL_STAGING = YES
LIBEXNL_DEST_DIR = $(STAGING_DIR)/usr/include

define LIBEXNL_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef


define LIBEXNL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lib/* $(TARGET_DIR)/usr/lib
endef

define LIBEXNL_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lib/* $(STAGING_DIR)/usr/lib
	cp -a $(@D)/include/uthash.h $(LIBEXNL_DEST_DIR)
	cp -a $(@D)/include/libmealloc.h $(LIBEXNL_DEST_DIR)
	cat $(@D)/include/libexnl.h|sed -r 's/^([\t ]*)\.([a-zA-Z0-9_]*)([\t ]*)=([\t ]*)(.*)/\t\5/' >$(LIBEXNL_DEST_DIR)/libexnl.h
endef


$(eval $(generic-package))
