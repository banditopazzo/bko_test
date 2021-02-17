MLE_PLAYER_VERSION = 0.8.2
MLE_PLAYER_SITE = $(call github,Exein-io,mle-player,v$(MLE_PLAYER_VERSION))

MLE_PLAYER_DEPENDENCIES = tensorflow-lite libexnl xtensor


define MLE_PLAYER_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef


define MLE_PLAYER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/mle-player $(TARGET_DIR)/usr/bin/mle-player
	mkdir -p $(TARGET_DIR)/etc/exein
endef


$(eval $(generic-package))
