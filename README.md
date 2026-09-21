# kcptun-client

OpenWrt package definition for KCPTun client, compatible with OpenWrt 22.03, 23.05, 24.10, and 25.x buildroot environments.

## Overview

- **Build System**: Utilizes OpenWrt `golang-package.mk` and `GoBinPackage` macros, compliant with modern Go module compilation standards.
- **Target Binary**: Generates `/usr/bin/kcptun-client` to fulfill dependencies for client proxy integrations (such as `luci-app-ssr-plus` and `passwall`).
- **Source Bundling**: Bundles verified source code in `src/` to guarantee deterministic, offline-capable builds independent of upstream repository availability.
- **Service Management**: Implements OpenWrt `procd` service lifecycle management (`/etc/init.d/kcptun`) with automatic respawn and log redirection.

## Repository Structure

```
├── Makefile            # OpenWrt package Makefile with golang-package.mk integration
├── files/
│   └── kcptun.init     # Procd init script
└── src/                # Local Go source tree and modules
```

## Build Specifications

| Parameter | Value |
| :--- | :--- |
| Package Name | `kcptun-client` |
| Section | `net` |
| Category | `Network -> Web Servers/Proxies` |
| Host Dependencies | `golang/host` |
| Architecture Constraints | `$(GO_ARCH_DEPENDS)` |
| Instruction Sets | MIPS16 disabled (`PKG_USE_MIPS16:=0`) |
| Installed Target | `/usr/bin/kcptun-client` |

## Integration & Compilation

### 1. Add Package to Buildroot

Clone the repository into your OpenWrt package directory:

```bash
git clone https://github.com/permails/kcptun-client.git package/kcptun-client
```

### 2. Configuration

Select the package in `menuconfig`:

```text
Network --->
  Web Servers/Proxies --->
    <*> kcptun-client
```

### 3. Compilation

Compile standalone package binary:

```bash
make package/kcptun-client/compile V=s
```

## Service Management

The package includes a standard OpenWrt `procd` init script at `/etc/init.d/kcptun`:

```bash
# Enable service on boot
/etc/init.d/kcptun enable

# Start daemon
/etc/init.d/kcptun start

# Stop daemon
/etc/init.d/kcptun stop

# Check running status
/etc/init.d/kcptun status
```

---

## 中文说明

适用于 OpenWrt 22.03、23.05、24.10 及 25.x 构建环境的 KCPTun 客户端软件包。

### 技术特性

- **构建宏标准**：采用 OpenWrt 官方 `golang-package.mk` 与 `GoBinPackage` 宏进行交叉编译，无弃用的 GOPATH 依赖。
- **产物定位**：直接输出 `/usr/bin/kcptun-client`，与 `luci-app-ssr-plus` 等代理前端的依赖链精确对齐。
- **本地源码内嵌**：源码内置于 `src/` 目录，规避外部镜像或上游代码库变动导致的下载阻断，保障构建确定性与断网编译能力。
- **服务守护**：基于 OpenWrt `procd` 规范提供后台守护进程脚本，支持崩溃重启（respawn）与标准日志重定向。

### 构建指南

1. 克隆至 OpenWrt 代码树：
```bash
git clone https://github.com/permails/kcptun-client.git package/kcptun-client
```

2. 在 `make menuconfig` 中选定：
```text
Network --->
  Web Servers/Proxies --->
    <*> kcptun-client
```

3. 执行单包编译：
```bash
make package/kcptun-client/compile V=s
```

## License

Licensed under the [MIT License](LICENSE.md).

