#
# OpenWrt package for KCPTun
# A Secure Tunnel Based On KCP with N:M Multiplexing
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kcptun
PKG_VERSION:=20240919
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/kongkx/kcptun-archive.git
PKG_SOURCE_VERSION:=1d256a464cf9b971d3381f4326955995b0d5964d
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=konvict <logo@permails.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

# Module name must match what go.mod declares
GO_PKG:=github.com/dumbybumby/kcptun-archive
GO_PKG_BUILD_PKG:=github.com/dumbybumby/kcptun-archive/client github.com/dumbybumby/kcptun-archive/server
GO_PKG_LDFLAGS_X:=main.VERSION=$(PKG_VERSION)-OpenWrt

# Delete the vendor directory so Go uses normal module download
# instead of broken vendor mode under OpenWrt's build system
define Build/Prepare
	$(call Build/Prepare/Default)
	rm -rf $(PKG_BUILD_DIR)/vendor
endef

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/kcptun-client
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=KCPTun Client
  URL:=https://github.com/xtaci/kcptun
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/kcptun-client/description
  A Secure Tunnel Based On KCP with N:M Multiplexing.
  This package contains the kcptun client.
endef

define Package/kcptun-client/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/client $(1)/usr/bin/kcptun-client
	$(INSTALL_BIN) ./files/kcptun.init $(1)/etc/init.d/kcptun
endef

$(eval $(call GoBinPackage,kcptun-client))
$(eval $(call BuildPackage,kcptun-client))
