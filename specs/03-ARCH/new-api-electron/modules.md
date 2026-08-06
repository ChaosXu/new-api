# new-api-electron

## 1. 内部模块

### 应用入口与进程编排

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| main | `./main.js` | Electron 主进程入口，负责启动/守护内嵌 Go 后端二进制、创建主窗口与系统托盘、采集并诊断服务器崩溃日志、退出时优雅终止子进程 |
| preload | `./preload.js` | 预加载脚本，通过 `contextBridge` 向渲染进程安全暴露 `electron` 全局对象（平台、版本、数据目录标记） |

### 构建辅助工具

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| create-tray-icon | `./create-tray-icon.js` | 一次性脚本，用 canvas 绘制 macOS Template 托盘图标 PNG（缺失 canvas 时写入占位透明图） |

---

## 2. 导入模块（第三方依赖）

### 桌面运行时与打包

| 依赖 | 用途 |
| --- | --- |
| electron | 桌面应用运行时，提供主进程 API（`app`/`BrowserWindow`/`Tray`/`Menu`/`dialog`/`shell`）与渲染进程沙箱（`contextBridge`），是 `start-app` 脚本的执行宿主 |
| electron-builder | 跨平台打包器，按 `package.json` 的 `build` 配置产出 macOS（dmg/zip）、Windows（nsis/portable）、Linux（AppImage/deb）安装包 |

### 构建工具链

| 依赖 | 用途 |
| --- | --- |
| cross-env | 跨平台设置 `NODE_ENV=development` 环境变量，供 `dev-app` 脚本进入开发模式 |
