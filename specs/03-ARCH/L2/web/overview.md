# web

| 项 | 说明 |
| --- | --- |
| 仓库路径 | `./web` |
| 技术栈 | React 19 + TypeScript + Rsbuild + Tailwind CSS |
| 构建 / 部署方式 | `bun install && bun run build` |
| 制品形态 | 独立可托管的静态站点（`web/dist`） |
| 对外功能 | 管理控制台与用户前端（渠道管理、用量、计费、配置等） |
| 边界与依赖 | 独立部署的静态站点（nginx/CDN/Netlify），不再被后端 `go:embed` 内嵌。浏览器运行时经反向代理把 `/api`、`/mj`、`/pg` 等请求回源到 new-api 后端；生产构建为同源假设（`baseURL=''`），独立托管时必须由反向代理补齐 API 回源 |
