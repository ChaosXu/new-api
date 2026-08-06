# new-api-electron

| 项 | 说明 |
| --- | --- |
| 仓库路径 | `./electron` |
| 技术栈 | Electron + electron-builder |
| 构建 / 部署方式 | `bun install && bun run build`（按平台 `build:mac` / `build:win` / `build:linux`） |
| 制品形态 | 跨平台桌面应用安装包（dmg / zip / nsis / portable / AppImage / deb） |
| 对外功能 | new-api 的桌面客户端：在本地拉起内嵌后端二进制并以桌面窗口形式提供访问 |
| 边界与依赖 | 通过 `extraResources` 打包根组件 `new-api` 的二进制作为子进程运行；前端在开发态连接 Rsbuild dev server，运行态连接内嵌后端 |
