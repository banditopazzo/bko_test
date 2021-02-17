#
# Copyright (C) 2019 Exein
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

XTL_VERSION = f0dd1fd367156174fbaa25324a4ed7748691874f
XTL_SITE = $(call github,xtensor-stack,xtl,$(XTL_VERSION))
XTL_LICENSE = BSD-3-Clause
XTL_LICENSE_FILES = LICENSE
XTL_INSTALL_STAGING = YES
XTL_INSTALL_TARGET = NO
XTL_DEST_DIR = $(STAGING_DIR)/usr/include/xtl


define XTL_INSTALL_STAGING_CMDS
	$(RM) -r $(XTL_DEST_DIR)
	mkdir -p $(XTL_DEST_DIR)
	cp -a $(@D)/include/xtl/* $(XTL_DEST_DIR)
endef


$(eval $(generic-package))

