#
# Copyright (C) 2019 Exein
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mle-player-model
PKG_RELEASE:=1
PKG_BUILD_DEPENDS:=mle-player

include $(INCLUDE_DIR)/package.mk

define Build/Compile
	
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/mle-player-model
	SECTION:=libs
	CATEGORY:=Exein
	TITLE:=TensorFlow Lite Exein player model.
	DEPENDS:=+mle-player
endef

define Package/mle-player-model/install
	$(INSTALL_DIR) $(1)/etc/exein/models
	$(INSTALL_BIN) ./src/* $(1)/etc/exein/models
endef


$(eval $(call BuildPackage,mle-player-model))
