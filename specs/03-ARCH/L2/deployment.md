# 部署拓扑

## 部署形态

### 形态一：容器化单体（Docker / Docker Compose）

| 项 | 说明 |
| --- | --- |
| 涉及组件 | new-api（内嵌 web） |
| 打包方式 | `Dockerfile` 三阶段多阶段构建：① `oven/bun` 构建 web 前端到 `web/dist`；② `golang` 把 `web/dist` 复制进来并 `go build` 出内嵌前端的单体二进制 `new-api`；③ `debian:bookworm-slim` 运行时镜像（装 ca-certificates/tzdata/wget）。`EXPOSE 3000`，`WORKDIR /data`。CI 产出 linux/amd64 + linux/arm64 多架构 manifest 并 cosign 签名 |
| 运行方式 | 容器暴露 `3000:3000`，挂载 `./data:/data` 与 `./logs:/app/logs`；单 `docker run`（SQLite 模式，仅挂载 `/data`）或 `docker-compose`（编排 new-api + redis + postgres，同 `new-api-network` bridge 网络服务名寻址）。通过环境变量连接依赖：`SQL_DSN`、`REDIS_CONN_STRING`、可选 `LOG_SQL_DSN`。healthcheck 用 `wget http://localhost:3000/api/status` |
| 组件间连接 | 同源单体：web 经 `go:embed` 内嵌，前后端同端口（:3000）提供服务 |

### 形态二：桌面应用（Electron）

| 项 | 说明 |
| --- | --- |
| 涉及组件 | new-api-electron、new-api（内嵌 web） |
| 打包方式 | `electron/package.json` 的 `electron-builder` 配置，目标平台 mac（dmg/zip）、win（nsis/portable）、linux（AppImage/deb）；`extraResources` 把预编译好的 Go 二进制（mac/linux 从 `../new-api`、win 从 `../new-api.exe`）打进 `bin/`，连同 LICENSE/NOTICE/THIRD-PARTY-LICENSES。CI 目前仅启用 windows-latest，tag 推送时触发：`bun run build` → `go build new-api.exe` → `electron-builder --win` |
| 运行方式 | electron 主进程 spawn 内嵌 Go 二进制（`process.resourcesPath/bin/new-api[.exe]`）为子进程，固定 `PORT=3000`，数据目录设为 `app.getPath('userData')/data`，`SQLITE_PATH` 用本地 SQLite（桌面态无需外部 DB）；轮询 `http://127.0.0.1:3000` 就绪后 `BrowserWindow.loadURL` 加载内嵌前端；`before-quit` 时 SIGTERM 子进程（5s 后 SIGKILL 兜底），关窗最小化到托盘 |
| 组件间连接 | 本地子进程：electron 主进程 ↔ 本机 Go 子进程（localhost:3000），浏览器窗口加载 Go 内嵌前端。单机自包含 |

### 形态三：前端独立托管（静态站点 + 反向代理）

| 项 | 说明 |
| --- | --- |
| 涉及组件 | web（独立托管）、new-api（作为回源后端） |
| 打包方式 | `web/` 下 `bun run build` 产出 `web/dist` 纯静态 SPA；`web/netlify.toml` 提供 SPA fallback（`/* → /index.html`），可部署到 Netlify 类静态托管平台 |
| 运行方式 | web 作为纯静态站点独立部署；new-api 作为后端单独运行（容器或裸二进制） |
| 组件间连接 | 反代回源：生产构建 `axios.create({ baseURL: '' })` 为同源假设，前端独立托管时**必须**由反向代理把 `/api`、`/mj`、`/pg` 转发回 new-api 后端（开发态 Rsbuild dev server 已内置该代理到 `VITE_REACT_APP_SERVER_URL`，默认 `http://localhost:3000`） |

### 形态四：裸机 / systemd 二进制

| 项 | 说明 |
| --- | --- |
| 涉及组件 | new-api（内嵌 web） |
| 打包方式 | `makefile` 本地构建：`build-web` 构建前端 + `go build` 产出单体二进制；`make all` = 构建前端 + 后台 `go run main.go` |
| 运行方式 | `new-api.service` systemd unit 模板：`ExecStart=/path/to/new-api --port 3000 --log-dir ...`，`Restart=always`，作为常规 Linux 服务运行（单进程）；DB 可用 SQLite 内嵌或外部 PostgreSQL/MySQL |
| 组件间连接 | 同源单体：同形态一，web 内嵌、前后端同 :3000 |

## 跨形态共性

- **同一二进制 + 前端内嵌**：无论哪种形态，运行的都是同一个 Go 二进制，前端都经 `//go:embed web/dist`（`main.go`）内嵌，默认 :3000 同源服务。
- **数据层可降级**：无外部 DB 时用 SQLite（桌面 / 单机 docker / 裸机），有外部 DB 时通过 `SQL_DSN` 接 PostgreSQL/MySQL，日志库可独立（`LOG_SQL_DSN` → ClickHouse）。
- **缓存/会话可选**：`REDIS_CONN_STRING` 可选；多节点部署时必须统一 `SESSION_SECRET`、`TRUSTED_PROXIES` 等。
- **三种对外连接拓扑**：① 同源单体（默认，前后端同 :3000）；② 桌面子进程（localhost:3000 + 浏览器窗口）；③ 前端独立 + 反代回源（独立托管时需反代 `/api`、`/mj`、`/pg`）。
