#
# Modern OpenWrt Makefile for Kcptun
# Directly tracks official upstream xtaci/kcptun
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kcptun
PKG_VERSION:=20240919
PKG_RELEASE:=1

# Use modern GitHub standard archive download format
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/xtaci/kcptun/archive/refs/tags/v$(PKG_VERSION).tar.gz?
PKG_HASH:=skip

PKG_MAINTAINER:=konvict <logo@permails.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

# Required environment dependencies for modern Go compilation
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

# Core Go module declaration
GO_PKG:=github.com/xtaci/kcptun
# Automatically inject compile version
GO_PKG_LDFLAGS_X:=main.VERSION=$(PKG_VERSION)-OpenWrt

include $(INCLUDE_DIR)/package.mk
# Include OpenWrt standard Golang build macros
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/kcptun-client
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=KCPTun Client (Modern Go Build)
  URL:=https://github.com/xtaci/kcptun
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/kcptun-client/description
  A Secure Tunnel Based On KCP with N:M Multiplexing.
  Built from official xtaci/kcptun source using modern OpenWrt 25.x standards.
endef

define Package/kcptun-client/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	
	# Extract the client binary and rename it to kcptun-client
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/client $(1)/usr/bin/kcptun-client
	
	# Install the procd initialization script
	$(INSTALL_BIN) ./files/kcptun.init $(1)/etc/init.d/kcptun
endef

$(eval $(call GoBinPackage,kcptun-client))
$(eval $(call BuildPackage,kcptun-client))
