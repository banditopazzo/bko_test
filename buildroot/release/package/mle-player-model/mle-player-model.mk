TFEXEIN_MODEL_VERSION = 1.0.0
TFEXEIN_MODEL_SITE = $(TOPDIR)/package/tfexein_model/src
TFEXEIN_MODEL_SITE_METHOD = local

define TFEXEIN_MODEL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/exein/models
	cp -a $(TFEXEIN_MODEL_PKGDIR)/src/* $(TARGET_DIR)/etc/exein/models
endef


$(eval $(generic-package))
