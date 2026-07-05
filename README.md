# OpenWrt KCPTun (Modern)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

*English | [中文](#中文)*

A modern, standalone OpenWrt package for [xtaci/kcptun](https://github.com/xtaci/kcptun). This package directly tracks the official upstream repository and uses the modern OpenWrt `golang-package.mk` macros for clean cross-compilation without outdated GOPATH dependencies. 

It generates a clean `kcptun-client` binary natively integrated with OpenWrt's `procd` daemon manager.

## Usage

1. Clone into your OpenWrt package directory:
```bash
cd package/extra-packages/
git clone https://github.com/permails/openwrt-kcptun.git kcptun
```
2. Build via `make menuconfig` (found under `Network -> Web Servers/Proxies`) or build directly:
```bash
make package/extra-packages/kcptun/compile V=s
```

---

## 中文

专为现代 OpenWrt（22.03-25.x）打造的 [xtaci/kcptun](https://github.com/xtaci/kcptun) 独立核心组件包。

完全抛弃了老旧且年久失修的第三方打包方案，直接拉取上游官方源码。全面拥抱 OpenWrt 最新的 `GoBinPackage` 宏模块，完美解决交叉编译和 Go 依赖下载失败的问题，并自带非常规范的现代化 `procd` 守护进程脚手架。

## 部署教程

1. 将本仓库克隆到您的 OpenWrt 包目录中：
```bash
cd package/extra-packages/
git clone https://github.com/permails/openwrt-kcptun.git kcptun
```
2. 在 `make menuconfig` 中勾选（位于 `Network -> Web Servers/Proxies` 下），或者直接开始极速编译：
```bash
make package/extra-packages/kcptun/compile V=s
```
