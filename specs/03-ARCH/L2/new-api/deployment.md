# new-api 的部署

## 部署形态

### 形态一：容器化（Docker / Docker Compose）

| 项 | 说明 |
| --- | --- |
| 打包方式 | 根 `Dockerfile` 多阶段构建：builder 用 `golang:1.26.1-alpine`，设 `GOWORK=off`、`CGO_ENABLED=0`，复制 `server/go.mod` + `server/relaykit/go.mod` 后 `go build ./cmd/new-api/` 产出纯后端二进制；运行时镜像基于 `debian:bookworm-slim` 装运行时依赖。**不构建前端、不内嵌 web/dist** |
| 运行方式 | 容器暴露 `3000:3000`，挂载 `./data:/data` 与 `./logs:/app/logs`；单 `docker run`（SQLite 模式）或 `docker-compose`（编排 new-api + redis + postgres，同 bridge 网络服务名寻址）。通过环境变量连接依赖：`SQL_DSN`、`REDIS_CONN_STRING`、可选 `LOG_SQL_DSN`。healthcheck 用 `wget http://localhost:3000/api/status` |
| 与其他组件的连接 | **前后端分离**：本组件仅在 :3000 提供 `/api/*`、`/v1/*`、`/mj/*`、`/pg/*` 等 API；web 前端由部署方独立托管（nginx/CDN），并由反向代理把上述 API 路径转发回本组件 :3000。未匹配路由返回 JSON 404（`router/main.go`） |

### 形态二：桌面应用（Electron）子进程

| 项 | 说明 |
| --- | --- |
| 打包方式 | 本组件的二进制被 electron 打包流程预编译（mac/linux 为 `new-api`、win 为 `new-api.exe`），通过 electron-builder 的 `extraResources` 打入桌面安装包的 `bin/` 目录 |
| 运行方式 | 由 new-api-electron 主进程 spawn 为子进程，固定 `PORT=3000`，数据目录设为 `app.getPath('userData')/data`，`SQLITE_PATH` 用本地 SQLite（桌面态无需外部 DB）；被父进程 SIGTERM 优雅终止 |
| 与其他组件的连接 | 本地子进程：与 new-api-electron 主进程经 localhost:3000 通信。**已知架构断点**：electron 生产模式 `loadURL('http://127.0.0.1:3000')` 试图加载前端页面，但本组件已不内嵌前端，桌面端生产构建会显示空白/JSON 404（详见 new-api-electron 文档） |

### 形态四：裸机 / systemd 二进制

| 项 | 说明 |
| --- | --- |
| 打包方式 | `cd server && go build -o new-api ./cmd/new-api/` 产出后端二进制；前端由部署方单独 `bun run build`（web/）后独立托管 |
| 运行方式 | `new-api.service` systemd unit 模板：`ExecStart=/path/to/new-api --port 3000 --log-dir ...`，`Restart=always`，作为常规 Linux 服务运行（单进程）；DB 可用 SQLite 内嵌或外部 PostgreSQL/MySQL |
| 与其他组件的连接 | **前后端分离**：前端独立部署，由反向代理把 `/api`、`/mj`、`/pg` 转发回本组件 :3000 |

## 跨形态共性

- 三种形态运行的都是同一个 Go 后端二进制，**均不内嵌前端**；前端在所有形态下都需独立部署（容器形态的部署方需自行加前端托管服务 + 反向代理）。
- 数据层可降级：无外部 DB 时用 SQLite，有外部 DB 时通过 `SQL_DSN` 接 PostgreSQL/MySQL，日志库可独立（`LOG_SQL_DSN` → ClickHouse）。
- 缓存/会话可选：`REDIS_CONN_STRING` 可选；多节点部署时必须统一 `SESSION_SECRET`、`TRUSTED_PROXIES` 等。
