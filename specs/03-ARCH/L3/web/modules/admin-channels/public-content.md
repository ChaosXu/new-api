# 公共内容与错误页

## 职责

无需登录的公共页面与全局错误状态页：公共首页（管理员配置内容或营销落地页）、关于页、法律文档（用户协议/隐私政策）、排行榜、站内客服聊天（链接型，嵌入第三方 Web 聊天前端）；以及 401/403/404/500/503 错误页。

## 契约（开放能力）

- **公共首页能力**：渲染管理员配置的首页内容（Markdown/HTML/iframe URL）或默认营销落地页（英雄区/统计/特性/工作原理/行动号召），向 iframe 同步主题/语言
- **关于页能力**：渲染管理员配置的关于内容（Markdown/HTML/iframe）或默认项目信息回退
- **法律文档能力**：渲染用户协议与隐私政策（URL iframe / 隔离 HTML / markdown / 空状态分支）
- **排行榜能力**：展示模型排行、厂商市场份额、涨跌幅榜单，按时间周期切换（今日/本周/本月/全年）
- **站内客服聊天能力**：解析系统配置的聊天预设、获取激活 API Key、渲染聊天 URL（支持 {key}/{address}/{cherry_config} 等模板替换与 base64 编码）、识别链接类型（web/custom-protocol/fluent）、Fluent 客户端预填充事件分发
- **错误状态页能力**：通用错误页（含 429 特殊处理）、未授权（401）、禁止访问（403）、未找到（404）、维护中（503）

## 覆盖代码

`web/src/features/home/`（index、api、types、constants、hooks、components、lib）、`web/src/features/about/`（index、api、types）、`web/src/features/legal/`（index、legal-document、user-agreement、privacy-policy、api、types）、`web/src/features/rankings/`（index、api、types、hooks、components、lib）、`web/src/features/chat/`（hooks/use-chat-presets、hooks/use-active-chat-key、lib/chat-links、lib/send-to-fluent）、`web/src/features/errors/`（general-error、unauthorized-error、forbidden、not-found-error、maintenance-error）

## 内部子能力

- 共享内容渲染三路分支（iframe URL / RichContent 隔离 HTML / markdown），由 `@/lib/content-format`（isHttpUrl、isLikelyHtml）驱动
- 站内客服聊天的模板替换与链接类型识别（home/about/legal 共享 RichContent，chat 共享 chat-links 解析）
- 错误页全屏展示（GeneralError 含 429 特殊处理与返回/报告/首页操作）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [布局框架](ui/layout-framework.md)（PublicLayout）
- [通用工具库](infra/utils.md)（content-format）
- [个人中心与自助](auth/profile-self.md)（chat 需激活 API Key）

## 备注

站内客服聊天（features/chat）不是自建对话功能，而是"外部聊天客户端链接"管理：读取系统配置的聊天预设，注入激活 API Key，在站内 iframe 嵌入第三方 Web 聊天前端（如 LobeChat/Cherry Studio），或通过自定义协议唤起本地客户端。
