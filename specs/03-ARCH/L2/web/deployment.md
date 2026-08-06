# web 的部署

## 部署形态

### 形态一：容器化单体（Docker / Docker Compose）

| 项 | 说明 |
| --- | --- |
| 打包方式 | `Dockerfile` 第①阶段用 `oven/bun` 执行 `bun run build`，产出 `web/dist` 静态站点产物；第②阶段由 new-api 的构建把 `web/dist` 复制进去并 `go:embed` 内嵌 |
| 运行方式 | 本组件不独立运行，产物被嵌入 new-api 二进制；最终由 new-api 在 :3000 同源托管 |
| 与其他组件的连接 | 经 new-api 间接：构建时被 new-api `go:embed` 内嵌，运行时由 new-api 同源托管并提供 `/api/*` 等后端接口 |

### 形态二：桌面应用（Electron）

| 项 | 说明 |
| --- | --- |
| 打包方式 | 同形态一：先 `bun run build` 产出 `web/dist`，再被 new-api 构建内嵌进二进制；随后随 new-api 二进制被 electron-builder 的 `extraResources` 打入桌面安装包 |
| 运行方式 | 本组件不独立运行，产物随内嵌的 new-api 二进制在桌面态由 new-api :3000 托管 |
| 与其他组件的连接 | 经 new-api 间接：桌面运行态 BrowserWindow 加载 `http://127.0.0.1:3000`，由内嵌 new-api 提供本组件的前端 |

### 形态三：前端独立托管（静态站点 + 反向代理）

| 项 | 说明 |
| --- | --- |
| 打包方式 | `web/` 下 `bun run build` 产出 `web/dist` 纯静态 SPA；`web/netlify.toml` 提供 SPA fallback（`/* → /index.html`），可部署到 Netlify 类静态托管平台 |
| 运行方式 | 本组件作为纯静态站点独立部署；new-api 作为后端单独运行（容器或裸二进制） |
| 与其他组件的连接 | 反代回源：生产构建 `axios.create({ baseURL: '' })` 为同源假设，独立托管时**必须**由反向代理把 `/api`、`/mj`、`/pg` 转发回 new-api 后端（开发态 Rsbuild dev server 已内置该代理到 `VITE_REACT_APP_SERVER_URL`，默认 `http://localhost:3000`） |

## 跨形态共性

- 三种形态共用同一构建产物 `web/dist`（`bun run build`），区别只在产物去向：被内嵌（形态一/二）还是独立托管（形态三）。
- 生产构建为同源假设（`baseURL=''`），形态一/二天然同源满足；形态三独立托管时必须由反向代理补齐 API 回源。
