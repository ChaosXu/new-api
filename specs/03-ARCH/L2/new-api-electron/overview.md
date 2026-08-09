# new-api-electron

| 项 | 说明 |
| --- | --- |
| 仓库路径 | `./electron` |
| 技术栈 | Electron + electron-builder |
| 构建 / 部署方式 | `bun install && bun run build`（按平台 `build:mac` / `build:win` / `build:linux`） |
| 制品形态 | 跨平台桌面应用安装包（dmg / zip / nsis / portable / AppImage / deb） |
| 对外功能 | new-api 的桌面客户端：在本地拉起后端二进制并以桌面窗口形式提供访问 |
| 边界与依赖 | 通过 `extraResources` 打包根组件 `new-api` 的后端二进制作为子进程运行（固定 :3000）。开发态（`NODE_ENV=development`）连 Rsbuild dev server（:5173）；生产态 `loadURL('http://127.0.0.1:3000')`。**已知架构断点**：后端已不内嵌前端，生产态桌面窗口加载 :3000 会得到 JSON 404 / 空白页，前端当前不可用，待修复（需让桌面态独立托管 web 前端产物） |
