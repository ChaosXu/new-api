# new-api

| 项 | 说明 |
| --- | --- |
| 仓库路径 | `./` (根 `main.go`) |
| 技术栈 | Go (Gin + GORM) |
| 构建 / 部署方式 | `go build -o new-api`;或由根 `Dockerfile` 多阶段构建为容器镜像 |
| 制品形态 | 可执行二进制 / 容器镜像 |
| 对外功能 | AI API 网关与代理服务：聚合 40+ 上游 AI 提供商，对外提供统一 HTTP API、用户管理、计费、限流和管理后台 |
| 边界与依赖 | 编译时通过 `go:embed` 内嵌 `web` 的静态站点产物；以本地 Go module 形式依赖 `relaykit`（纯库，不独立部署） |
