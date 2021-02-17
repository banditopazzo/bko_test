#
# Copyright (C) 2019 Exein
#
# $Id: $

include $(TOPDIR)/rules.mk

PKG_NAME:=training-forwarder
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Exein-io/training-forwarder.git
PKG_SOURCE_VERSION:=v0.2.0
# PKG_MIRROR_HASH:=08e6bcdccc83a48f52466d3eccca9cbee82e6be7095a6987c507d72394d37552
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Exein <info@exein.io>

include $(INCLUDE_DIR)/package.mk

define Package/training-forwarder
  SECTION:=libs
  CATEGORY:=Exein
  TITLE:=training-forwarder.
endef

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)" \
		CC="$(TARGET_CC)" \
		LD="$(TARGET_CROSS)ld" \
		CFLAGS+="$(TARGET_CFLAGS) -fPIC -Iinc -Wall -lpthread" \
		TARGET_CFLAGS="$(TARGET_CFLAGS)" \
		TARGET_LDFLAGS="$(TARGET_LDFLAGS)"
endef

define Package/training-forwarder/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/training-forwarder $(1)/usr/bin/training-forwarder
endef

$(eval $(call BuildPackage,training-forwarder))
