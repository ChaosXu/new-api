# 个人中心与自助

## 职责

当前登录用户自助管理中心：个人资料编辑、语言偏好、安全设置（密码/2FA/Passkey/登录会话）、签到、侧栏模块配置；以及 API Key 自助管理。

## 契约（开放能力）

- **个人资料读写能力**：读取与更新资料、用户设置（`/api/user/setting`）、密码修改（触发认证轮换）
- **系统访问令牌生成能力**：生成用户级系统访问令牌
- **账号绑定与解绑能力**：邮箱验证码绑定、WeChat/Telegram 绑定、自定义 OAuth 绑定查询与解绑
- **登录会话管理能力**：列出会话、撤销单会话、撤销其他会话
- **每日签到能力**：签到状态查询与执行（支持 Turnstile）
- **账号注销能力**：删除自身账号
- **API Key 自助管理能力**：当前用户的 API Key 列表、创建、更新、删除（单/批量）、启停、明文查询（需二次验证）、模型限制/IP 白名单/自动分组/跨组重试等高级配置

## 覆盖代码

`web/src/features/profile/`（index、api、types、constants、components、hooks）、`web/src/features/keys/`（index、api、types、constants、components）

## 内部子能力

- 个人资料卡片（ProfileHeader、ProfileSettingsCard、LanguagePreferencesCard）
- 安全卡片（ProfileSecurityCard、LoginSessionsCard、PasskeyCard、TwoFACard）
- 签到日历（CheckinCalendarCard，受 `status.checkin_enabled` 控制）
- 侧栏模块配置（SidebarModulesCard，受权限 `sidebar_settings` 控制）
- API Key 表格与编辑抽屉（ApiKeysTable、ApiKeysMutateDrawer、自动分组顺序编辑、cc-switch）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [全局状态与系统配置缓存](infra/global-state.md)
- [敏感操作二次验证](auth/secure-verification.md)
- [数据表格复合组件](ui/data-table.md)
