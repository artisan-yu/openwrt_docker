include $(TOPDIR)/rules.mk

PKG_NAME:=openwrt_docker
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=bridge-utils-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/ayu-666/openwrt_docker
PKG_MD5SUM:=
PKG_CAT:=zcat
FILENAME=docker-20.10.9.tgz

include $(INCLUDE_DIR)/package.mk

define Package/openwrt_docker
  SECTION:=base
  CATEGORY:=Utilities
  TITLE:=openwrt_docker
  URL:=https://github.com/ayu-666/openwrt_docker
endef

define Build/Prepare
  curl -o $(BUILD_DIR)/$(PKG_NAME)/$(FILENAME) https://download.docker.com/linux/static/stable/x86_64/$(FILENAME)
	tar -zxvf $(BUILD_DIR)/$(PKG_NAME)/$(FILENAME) -C $(BUILD_DIR)/$(PKG_NAME)/docker-ce --strip-components 1
endef


define Package/openwrt_docker/install
  $(INSTALL_DIR) $(1)/usr/sbin
  $(INSTALL_BIN) $(PKG_BUILD_DIR)/brctl/brctl $(1)/usr/docker/
endef

$(eval $(call BuildPackage,openwrt_docker))
