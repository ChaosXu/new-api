# new-api

| 项 | 说明 |
| --- | --- |
| 仓库路径 | `./server`（入口 `server/cmd/new-api/main.go`，`server/go.mod`） |
| 技术栈 | Go (Gin + GORM) |
| 构建 / 部署方式 | `cd server && go build -o new-api ./cmd/new-api/`；或由根 `Dockerfile` 多阶段构建为容器镜像（仅构建后端二进制，不含前端） |
| 制品形态 | 可执行二进制 / 容器镜像（纯 API server，不内嵌前端） |
| 对外功能 | AI API 网关与代理服务：聚合 40+ 上游 AI 提供商，对外提供统一 HTTP API、用户管理、计费、限流。前端（管理后台 / 用户控制台）独立部署，本组件不再托管其静态站点 |
| 边界与依赖 | 纯 API server，不内嵌前端（`router/main.go` 对未匹配路由返回 JSON 404，注释明示 "No embedded frontend"）；通过 `server/go.mod` 的 `replace` 指令以本地 Go module 形式依赖 `relaykit`（纯库，不独立部署）；前端经反向代理回源调用本组件 API |
