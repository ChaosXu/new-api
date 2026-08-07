# 应用引导

## 职责

React 应用的根引导：装配全局 Provider 链、初始化核心基础设施（路由、数据查询、系统配置、构建元数据、前端缓存），将整个应用挂载到 DOM。

## 契约（开放能力）

- **应用启动与挂载能力**：装配 `StrictMode → QueryClientProvider → ThemeProvider → FontProvider → DirectionProvider → RouterProvider` 的 Provider 链并挂载到 `#root`
- **TanStack Query 客户端初始化能力**：提供带重试策略、聚焦不重查、500 跳错误页、mutation 统一错误处理的查询客户端
- **TanStack Router 实例初始化能力**：以 intent 预加载模式创建路由实例并注入 queryClient 上下文
- **构建元数据注入能力**：在启动时将构建版本/提交哈希写入 DOM、window、CSS 变量，供调试与错误上报关联
- **前端缓存版本清理能力**：启动时清除过期的 localStorage 缓存项
- **系统品牌优先加载能力**：以缓存优先方式加载系统标题与 favicon，随后网络刷新

## 覆盖代码

`web/src/main.tsx`、`web/src/routeTree.gen.ts`（自动生成）、`web/src/config/`、`web/src/vite-env.d.ts`、`web/src/tanstack-table.d.ts`

## 依赖（内部逻辑模块）

- [全局状态与系统配置缓存](infra/global-state.md)
- [国际化基础](infra/i18n.md)
- [主题与偏好 Provider](framework/theme-prefs.md)
- [路由层与权限守卫](framework/routing-guard.md)
