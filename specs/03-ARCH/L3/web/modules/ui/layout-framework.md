# 布局框架

## 职责

应用级布局框架（侧边栏/顶栏/内容区/页脚），支持嵌套"drill-in"侧边栏视图切换（Vercel/Cloudflare 风格），分 config/lib/components/types/constants 五层。

## 契约（开放能力）

- **认证布局外壳能力**：authenticated-layout（所有需登录页面的父级布局）
- **公共布局能力**：public-layout/public-header/public-navigation（公共页布局）
- **侧边栏能力**：app-sidebar，含 nav-group/nav-link-item 项渲染、移动抽屉
- **嵌套侧边栏视图能力**：通过 pathPattern 解析当前活跃的 SidebarView（如 System Settings），实现钻取式工作区导航；sidebar-view-header
- **顶栏导航能力**：app-header/header/top-nav，含 header-logo/logo/system-brand 品牌区
- **页脚门户能力**：footer/page-footer
- **页面分区布局能力**：section/section-page-layout（分区页通用骨架）

## 覆盖代码

`web/src/components/layout/`（config/、lib/、components/、index.ts、types.ts、constants.ts）

## 内部子能力

- 声明式配置层（config）：system-settings.config.ts（系统设置嵌套视图 SidebarView 定义）、top-nav.config.ts（公共顶栏链接）
- 解析逻辑层（lib）：sidebar-view-registry.ts（按 pathPattern 解析活跃嵌套视图）、url-utils.ts
- 类型层（types）：NavItem（NavLink | NavCollapsible | NavChatPresets）、NavGroup、SidebarData、SidebarView/ResolvedSidebarView、TopNavLink，含 requiredRole 控制可见性
- 实现层（components）：authenticated-layout、public-layout、app-sidebar、app-header、nav-group、nav-link-item、top-nav、sidebar-view-header、mobile-drawer、header-logo、logo、system-brand、section、section-page-layout

## 依赖（内部逻辑模块）

- [通用 UI 原子组件](ui/ui-primitives.md)
- [全局复用 Hook](infra/hooks.md)（侧边栏导航装配 hooks）
- [全局状态与系统配置缓存](infra/global-state.md)（品牌信息）
- [区块注册框架](admin-channels/section-registry.md)（嵌套视图消费子注册表导航项）
