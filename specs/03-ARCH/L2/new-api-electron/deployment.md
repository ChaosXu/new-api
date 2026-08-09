# new-api-electron 的部署

## 部署形态

### 形态二：桌面应用（Electron）

| 项 | 说明 |
| --- | --- |
| 打包方式 | `electron/package.json` 的 `electron-builder` 配置，目标平台 mac（dmg/zip）、win（nsis/portable）、linux（AppImage/deb）；`extraResources` 把预编译好的 new-api Go 二进制（mac/linux 从 `../new-api`、win 从 `../new-api.exe`）打进 `bin/`，连同 LICENSE/NOTICE/THIRD-PARTY-LICENSES。CI 目前仅启用 windows-latest，tag 推送时触发：`bun run build`（前端）→ `go build new-api.exe`（后端）→ `electron-builder --win`。`electron/build.sh` 仍构建 `web/dist` 前端产物，但当前该产物未被有效打包/托管（架构断点） |
| 运行方式 | 主进程 spawn 内嵌 Go 二进制（`process.resourcesPath/bin/new-api[.exe]`）为子进程，固定 `PORT=3000`，数据目录设为 `app.getPath('userData')/data`，用本地 SQLite（桌面态无需外部 DB）；轮询 `http://127.0.0.1:3000` 就绪后 `BrowserWindow.loadURL('http://127.0.0.1:3000')`；`before-quit` 时 SIGTERM 子进程（5s 后 SIGKILL 兜底），关窗最小化到托盘。开发模式（`NODE_ENV=development`）不启动后端二进制，改为连开发者本机的 `go run main.go`（:3000）+ Rsbuild dev server（:5173） |
| 与其他组件的连接 | 本地子进程：主进程 ↔ 本机 new-api 子进程（localhost:3000）。**已知架构断点**：后端不再内嵌前端，生产态 BrowserWindow 加载 :3000 会得到 JSON 404 / 空白页，前端当前不可用。开发态则正常经 Rsbuild dev server（:5173）加载前端 |

> 断点说明：`electron/build.sh` 仍执行 `bun run build` 构建 `web/dist`，但该产物既未被后端 `go:embed` 内嵌，也未被 electron 独立静态托管（`main.js` 不 loadFile/loadURL 指向它）。需补充桌面态前端托管方案后才能恢复生产可用。
