# web 的组件关系

## 本组件为中心关系图

```mermaid
graph LR
  Me[web<br/>静态站点产物]
  Api[new-api]
  Desk[new-api-electron]

  Me -- "编译时 被 go:embed 内嵌" --> Api
  Api -- "运行时 托管静态站点 + /api/*" --> Me
  Desk -. "开发态 连 Rsbuild dev server :5173" .-> Me
```

## 本组件的交互

| 对方组件 | 时机 | 方向 | 方式 | 说明 |
| --- | --- | --- | --- | --- |
| new-api | 编译时 | 本组件→对方 | `go:embed` 内嵌 | web 的构建产物 `web/dist` 在 new-api 构建时通过 `//go:embed web/dist` 被嵌入二进制 |
| new-api | 运行时 | 对方→本组件 | 同源 HTTP 托管 | new-api 在 :3000 同源托管 web 的静态站点，并向其提供 `/api/*`、`/mj/*`、`/pg/*` 等后端接口 |
| new-api-electron | 运行时 | 对方→本组件 | 经内嵌后端加载 | 桌面运行态 BrowserWindow 加载 `http://127.0.0.1:3000`，由内嵌的 new-api 提供 web 前端（与 web 无直接交互，经 new-api 间接） |
| new-api-electron | 开发态 | 对方→本组件 | Rsbuild dev server | 开发模式（`NODE_ENV=development`）下 electron 加载 Rsbuild dev server（:5173），由 dev server 代理 `/api`、`/mj`、`/pg` 到本机 `go run main.go`（:3000） |
