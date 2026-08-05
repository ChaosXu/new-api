# 组件归纳

| 组件名 | 路径 | 技术栈 | 构建 / 部署方式 | 制品形态 | 对外功能 | 边界与依赖 |
| --- | --- | --- | --- | --- | --- | --- |
| new-api | `./` (根 `main.go`) | Go (Gin + GORM) | `go build -o new-api`;或由 `Dockerfile` 多阶段构建为容器镜像 | 可执行二进制 / 容器镜像 | AI API 网关与代理服务：聚合 40+ 上游 AI 提供商，对外提供统一 HTTP API、用户管理、计费、限流和管理后台 | 编译时内嵌 `web` 的静态站点产物；以本地 Go module 形式依赖 `relaykit`（纯库，不独立部署） |
| web | `./web` | React 19 + TypeScript + Rsbuild + Tailwind CSS | `bun install && bun run build` | 独立可托管的静态站点（`web/dist`） | 管理控制台与用户前端（渠道管理、用量、计费、配置等） | 构建产物被 `new-api` 二进制 `embed` 嵌入并提供给后端宿主；也可脱离宿主独立托管为静态站点 |
| new-api-electron | `./electron` | Electron + electron-builder | `bun install && bun run build`（按平台 `build:mac` / `build:win` / `build:linux`） | 跨平台桌面应用安装包（dmg / zip / nsis / portable / AppImage / deb） | new-api 的桌面客户端：在本地拉起内嵌后端二进制并以桌面窗口形式提供访问 | 通过 `extraResources` 打包根组件 `new-api` 的二进制作为子进程运行；前端在开发态连接 Rsbuild dev server，运行态连接内嵌后端 |
