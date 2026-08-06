# new-api 的部署

## 部署形态

### 形态一：容器化单体（Docker / Docker Compose）

| 项 | 说明 |
| --- | --- |
| 打包方式 | `Dockerfile` 三阶段多阶段构建的第②阶段：把第①阶段产出的 `web/dist` 复制进来，`go build` 出内嵌前端的单体二进制 `new-api`；第③阶段基于 `debian:bookworm-slim` 装运行时依赖。CI 产出 linux/amd64 + linux/arm64 多架构 manifest 并 cosign 签名 |
| 运行方式 | 容器暴露 `3000:3000`，挂载 `./data:/data` 与 `./logs:/app/logs`；单 `docker run`（SQLite 模式）或 `docker-compose`（编排 new-api + redis + postgres，同 bridge 网络服务名寻址）。通过环境变量连接依赖：`SQL_DSN`、`REDIS_CONN_STRING`、可选 `LOG_SQL_DSN`。healthcheck 用 `wget http://localhost:3000/api/status` |
| 与其他组件的连接 | 同源单体：web 经 `go:embed` 已内嵌，前后端同端口（:3000）提供服务 |

### 形态二：桌面应用（Electron）

| 项 | 说明 |
| --- | --- |
| 打包方式 | 本组件的二进制被 electron 打包流程预编译（mac/linux 为 `new-api`、win 为 `new-api.exe`），通过 electron-builder 的 `extraResources` 打入桌面安装包的 `bin/` 目录 |
| 运行方式 | 由 new-api-electron 主进程 spawn 为子进程，固定 `PORT=3000`，数据目录设为 `app.getPath('userData')/data`，`SQLITE_PATH` 用本地 SQLite（桌面态无需外部 DB）；被父进程 SIGTERM 优雅终止 |
| 与其他组件的连接 | 本地子进程：与 new-api-electron 主进程经 localhost:3000 通信；浏览器窗口加载本组件内嵌的 web 前端 |

### 形态四：裸机 / systemd 二进制

| 项 | 说明 |
| --- | --- |
| 打包方式 | `makefile` 的 `build-web` 构建前端 + `go build` 产出单体二进制 |
| 运行方式 | `new-api.service` systemd unit 模板：`ExecStart=/path/to/new-api --port 3000 --log-dir ...`，`Restart=always`，作为常规 Linux 服务运行（单进程）；DB 可用 SQLite 内嵌或外部 PostgreSQL/MySQL |
| 与其他组件的连接 | 同源单体：web 内嵌、前后端同 :3000 |

## 跨形态共性

- 三种形态运行的都是同一个 Go 二进制，前端都经 `//go:embed web/dist`（`main.go`）内嵌，默认 :3000 同源服务。
- 数据层可降级：无外部 DB 时用 SQLite，有外部 DB 时通过 `SQL_DSN` 接 PostgreSQL/MySQL，日志库可独立（`LOG_SQL_DSN` → ClickHouse）。
- 缓存/会话可选：`REDIS_CONN_STRING` 可选；多节点部署时必须统一 `SESSION_SECRET`、`TRUSTED_PROXIES` 等。
