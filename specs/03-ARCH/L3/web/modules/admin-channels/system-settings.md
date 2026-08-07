# 系统设置

## 职责

管理控制台配置全部服务端行为，按 7 个子类别组织（站点品牌、认证、计费与支付、模型与路由、安全与限制、控制台内容、运维），采用嵌套"drill-in"侧边栏视图（Vercel/Cloudflare 风格）。通用 SettingsPage 处理 `/api/option` 数据加载、脏数据检查与表单渲染。

## 契约（开放能力）

- **站点与品牌配置能力**：系统名称/Logo/Footer/关于/首页内容/服务器地址/法律文档、系统公告、顶部导航模块、侧边栏模块
- **认证方式配置能力**：密码/注册/邮件验证/邮件域限制、OAuth（GitHub/Discord/OIDC/Telegram/LinuxDO/WeChat）、Passkey、Turnstile、自定义 OAuth 提供商 CRUD
- **计费与支付配置能力**：额度/邀请/文档链接、货币与显示、模型定价、分组定价、支付网关（Epay/Stripe/Creem/Waffo/Waffo-Pancake）、签到奖励
- **模型与路由配置能力**：透传/thinking 黑名单/ping、重试/自动禁用-启用/监控、Gemini/Claude/Grok、渠道亲和性、IoNet 部署
- **安全与限制配置能力**：限流、敏感词、SSRF 保护、Token 限制
- **控制台内容配置能力**：数据导出、公告、API 信息、FAQ、Uptime Kuma、聊天预设、绘图设置
- **运维配置能力**：侧边栏折叠/演示/自用模式、监控与提醒、SMTP、Worker 代理、日志维护、磁盘缓存/监控阈值、系统维护/版本检查

## 覆盖代码

`web/src/features/system-settings/`（index、components/settings-page、utils/section-registry、hooks、site/、auth/、billing/、models/、security/、content/、operations/）、`web/src/components/layout/config/system-settings.config.ts`

## 内部子能力

- 通用区块注册框架（createSectionRegistry 工厂，驱动 dashboard、usage-logs、system-settings 共 7 子注册表）
- 通用 SettingsPage 框架（数据加载、脏数据检查、表单渲染、未保存离开拦截）
- 嵌套侧边栏视图（system-settings.config.ts 定义 SYSTEM_SETTINGS_VIEW，调用各子注册表导航项组合成钻取式侧边栏）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [区块注册框架](admin-channels/section-registry.md)
- [布局框架](ui/layout-framework.md)（嵌套侧边栏视图）

## 项目约束（若有）

system-settings 路由要求 `role === ROLE.SUPER_ADMIN`（AGENTS.md 权限要求）。
