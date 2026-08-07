# 路由层与权限守卫

## 职责

基于 TanStack Router 文件路由的全站导航骨架：声明路由树、提供布局路由外壳、强制登录与角色守卫、处理遗留路由重定向与错误边界。

## 契约（开放能力）

- **路由树声明能力**：以文件约定（`__root`、`_authenticated`、`(auth)`、`(errors)`、`$param`）组织全站约 59 个路由
- **根布局能力**：在 `__root.tsx` 挂载全局 Provider（React Query、主题定制、Toaster、导航进度）、加载系统配置、处理邀请码、引导认证会话、注册跨标签页会话同步
- **强制登录守卫能力**：`_authenticated` 布局路由在 `beforeLoad` 校验登录态，缺失则重定向至 `/sign-in?redirect=...`
- **角色守卫能力**：system-settings 要求 SUPER_ADMIN、users 要求 ADMIN 等路由级硬性角色控制；与侧边栏可见性软控制独立
- **公共页与错误页路由能力**：提供首页、定价、排行榜、OAuth 回调、隐私/协议等公共页，及 401/403/404/500/503 错误页
- **首次部署引导路由能力**：根据 setup 状态强制重定向至 `/setup` 完成初始化
- **遗留路由兼容能力**：将旧版路由路径映射到新版路径

## 覆盖代码

`web/src/routes/`（全部路由文件）、`web/src/lib/nav-modules.ts`、`web/src/lib/legacy-route.ts`

## 依赖（内部逻辑模块）

- [应用引导](framework/app-bootstrap.md)
- [全局状态与系统配置缓存](infra/global-state.md)
- [布局框架](ui/layout-framework.md)
- [HTTP 与认证会话底座](infra/http-auth-base.md)
