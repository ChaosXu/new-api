# web 的部署

## 部署形态

### 形态一：独立静态托管（nginx / CDN / Netlify）

| 项 | 说明 |
| --- | --- |
| 打包方式 | `web/` 下 `bun run build` 产出 `web/dist` 纯静态 SPA；`web/netlify.toml` 提供 SPA fallback（`/* → /index.html`），可部署到 Netlify 类静态托管平台，或由 nginx/CDN 托管 |
| 运行方式 | 本组件作为纯静态站点独立运行；new-api 作为纯 API 后端单独运行（容器或裸二进制），不再内嵌本组件 |
| 与其他组件的连接 | 反代回源：生产构建 `axios.create({ baseURL: '' })` 为同源假设，独立托管时**必须**由反向代理把 `/api`、`/mj`、`/pg` 转发回 new-api 后端 :3000。开发态 Rsbuild dev server 已内置该代理（见形态二） |

### 形态二：开发态（Rsbuild dev server）

| 项 | 说明 |
| --- | --- |
| 打包方式 | `web/` 下 `bun run dev` 启动 Rsbuild dev server，无需预构建产物 |
| 运行方式 | dev server 监听 `:5173`，内置代理把 `/api`、`/mj`、`/pg` 转发到 `VITE_REACT_APP_SERVER_URL`（默认 `http://localhost:3000`）本机 new-api 后端 |
| 与其他组件的连接 | 开发态由 dev server 代理回源到本机 new-api（:3000）；electron 开发模式（`NODE_ENV=development`）也连此 dev server :5173 |

## 跨形态共性

- 两种形态共用同一 `web/dist` 产物（生产）或同一源码（开发），区别只在产物去向与 API 回源机制。
- 生产构建为同源假设（`baseURL=''`）：独立托管时必须由反向代理补齐 `/api`、`/mj`、`/pg` 回源到 new-api :3000；开发态由 Rsbuild dev server 内置代理自动处理。
