#
# Modern OpenWrt Makefile for Kcptun
# Directly tracks official upstream xtaci/kcptun
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kcptun
# 这里使用了近年来上游十分稳定的一个大版本号，可以随时修改为最新的 release tag
PKG_VERSION:=20240919
PKG_RELEASE:=1

# 使用现代 GitHub 标准归档下载格式
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/xtaci/kcptun/archive/refs/tags/v$(PKG_VERSION).tar.gz?
PKG_HASH:=skip

PKG_MAINTAINER:=konvict
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

# 现代 Go 语言编译必须的环境依赖
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

# 核心 Go 模块声明
GO_PKG:=github.com/xtaci/kcptun
# 自动注入编译版本号
GO_PKG_LDFLAGS_X:=main.VERSION=$(PKG_VERSION)-OpenWrt

include $(INCLUDE_DIR)/package.mk
# 引入 OpenWrt 标准的 Golang 编译宏
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/kcptun
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=KCPTun (Modern Go Build)
  URL:=https://github.com/xtaci/kcptun
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/kcptun/description
  A Secure Tunnel Based On KCP with N:M Multiplexing.
  Built from official xtaci/kcptun source using modern OpenWrt 25.x standards.
endef

define Package/kcptun/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	
	# 从编译生成的 bin 目录提取客户端二进制并命名为 kcptun-client
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/client $(1)/usr/bin/kcptun-client
	
	# 安装守护进程初始化脚本
	$(INSTALL_BIN) ./files/kcptun.init $(1)/etc/init.d/kcptun
endef

$(eval $(call GoBinPackage,kcptun))
$(eval $(call BuildPackage,kcptun))
