#
# Copyright (C) 2019 Exein
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mle-player
PKG_RELEASE:=1
PKG_BUILD_DEPENDS:=tensorflow-lite libexnl xtensor

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Exein-io/mle-player.git
PKG_SOURCE_VERSION:=v0.8.0
# PKG_MIRROR_HASH:=08e6bcdccc83a48f52466d3eccca9cbee82e6be7095a6987c507d72394d37552
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Exein <info@exein.io>

include $(INCLUDE_DIR)/package.mk

define Package/mle-player
	SECTION:=libs
	CATEGORY:=Exein
	TITLE:=TensorFlow Lite Exein player
	DEPENDS:=+tensorflow-lite +libstdcpp +libexnl
endef

define Build/Compile
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(PKG_BUILD_DIR)
endef

define Package/mle-player/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mle-player $(1)/usr/bin/mle-player

	$(INSTALL_DIR) $(1)/etc/exein
endef


$(eval $(call BuildPackage,mle-player))
