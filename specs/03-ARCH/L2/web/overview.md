# web

| 项 | 说明 |
| --- | --- |
| 仓库路径 | `./web` |
| 技术栈 | React 19 + TypeScript + Rsbuild + Tailwind CSS |
| 构建 / 部署方式 | `bun install && bun run build` |
| 制品形态 | 独立可托管的静态站点（`web/dist`） |
| 对外功能 | 管理控制台与用户前端（渠道管理、用量、计费、配置等） |
| 边界与依赖 | 构建产物被 `new-api` 二进制 `embed` 嵌入并提供给后端宿主；也可脱离宿主独立托管为静态站点 |
