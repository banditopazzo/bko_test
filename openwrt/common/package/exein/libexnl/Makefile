#
# Copyright (C) 2019 Exein
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libexnl
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Exein-io/libexnl.git
PKG_SOURCE_VERSION:=v0.7.1
# PKG_MIRROR_HASH:=08e6bcdccc83a48f52466d3eccca9cbee82e6be7095a6987c507d72394d37552
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Exein <info@exein.io>

include $(INCLUDE_DIR)/package.mk

define Package/libexnl
	SECTION:=libs
	CATEGORY:=Exein
	SUBMENU:=Libraries
	TITLE:=simple library for handling the MLE netlink channel.
endef


define Build/Compile
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR)
endef

define Package/libexnl/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/* $(1)/usr/lib
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/* $(1)/usr/lib

	$(INSTALL_DIR) $(1)/usr/include
	cat $(PKG_BUILD_DIR)/include/libexnl.h|sed -r 's/^([\t ]*)\.([a-zA-Z0-9_]*)([\t ]*)=([\t ]*)(.*)/\t\5/' >$(1)/usr/include/libexnl.h
	$(CP) -a $(PKG_BUILD_DIR)/include/* $(1)/usr/include/
endef

$(eval $(call BuildPackage,libexnl))
