# 全局状态与系统配置缓存

## 职责

用 Zustand 管理跨组件全局状态，区分内存态与持久化态：认证状态、通知已读状态、系统配置缓存（系统名、logo、footer、货币配置），并为非 React 环境提供同步选择器助手。

## 契约（开放能力）

- **认证状态持有能力**：持有当前用户、access token、过期时间、登录会话、待处理 2FA flow token、引导阶段（idle/checking/complete）；提供写入认证 bundle、更新用户、整体重置
- **通知已读状态持有能力**：以 localStorage 持久化最近已读 Notice 签名、已读公告 key、"今日不再提示"日期；提供标记已读与查询能力
- **系统配置缓存能力**：以 localStorage 部分持久化系统名、logo、footer HTML、货币配置（USD/CNY/TOKENS/CUSTOM 四种展示策略）；提供增量更新与非 React 同步选择器（getSystemName/getLogo/getFooterHtml）

## 覆盖代码

`web/src/stores/auth-store.ts`、`web/src/stores/notification-store.ts`、`web/src/stores/system-config-store.ts`

## 内部子能力

- 认证 bundle 类型契约（access_token + token_type + 过期时间 + user + session）
- 货币配置四策略（USD/CNY/TOKENS/CUSTOM）与三方换算
- 非 React 同步选择器助手（供 favicon、title 等非组件场景读取）

## 依赖（内部逻辑模块）

- 无（被广泛依赖的基础设施）
