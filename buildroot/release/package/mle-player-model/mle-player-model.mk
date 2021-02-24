MLE_PLAYER_MODEL_VERSION = 1.0.0
MLE_PLAYER_MODEL_SITE = $(TOPDIR)/package/mle-player-model/src
MLE_PLAYER_MODEL_SITE_METHOD = local

define MLE_PLAYER_MODEL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/exein/models
	cp -a $(MLE_PLAYER_MODEL_PKGDIR)/src/* $(TARGET_DIR)/etc/exein/models
endef


$(eval $(generic-package))
