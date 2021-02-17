#
# Copyright (C) 2019 Exein
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

XTENSOR_VERSION = d59ab1dafff4ba419a8b735ff3e951b9f89cedb8
XTENSOR_SITE = $(call github,xtensor-stack,xtensor,$(XTENSOR_VERSION))
XTENSOR_LICENSE = BSD-3-Clause
XTENSOR_LICENSE_FILES = LICENSE
XTENSOR_INSTALL_STAGING = YES
XTENSOR_INSTALL_TARGET = NO
XTENSOR_DEST_DIR = $(STAGING_DIR)/usr/include/xtensor
XTENSOR_DEPENDENCIES = xtl

define XTENSOR_INSTALL_STAGING_CMDS
	$(RM) -r $(XTENSOR_DEST_DIR)
	mkdir -p $(XTENSOR_DEST_DIR)
	cp -a $(@D)/include/xtensor/* $(XTENSOR_DEST_DIR)
endef


$(eval $(generic-package))

