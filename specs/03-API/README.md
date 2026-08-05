# 后端 API 规格

> 按 REST 资源对象组织。每个资源一个子目录，目录下每个端点一个 Markdown 文件，附索引 README。

## 公共约定

### 统一响应信封（`/api/*` 接口）

源：`common/gin.go`。HTTP 状态码恒为 200，业务成败看 `success` 字段。

```json
// 成功
{ "success": true, "message": "", "data": <any> }
// 失败
{ "success": false, "message": "<i18n key 或硬编码文案>" }
```

> Relay 接口（`/v1`、`/v1beta`、`/mj`、`/suno` 等）使用上游原生协议，不走统一信封。

### 鉴权类型

| 中间件 | 说明 |
|---|---|
| （无） | 公开 |
| `UserAuth` | 已登录用户 |
| `AdminAuth` | 管理员（role ≥ 10） |
| `RootAuth` | 超级管理员（role ≥ 100） |
| `TokenAuth` | API 令牌（sk-xxx） |
| `TokenAuthReadOnly` | API 令牌只读 |
| `TokenOrUserAuth` | 令牌或会话 |
| `RequirePermission(p)` | 细粒度 RBAC（Casbin） |
| `SecureVerificationRequired` | 安全操作二次验证（需 `X-Security-Proof` 头） |

### 分页

query：`p`（页码）、`page_size`/`ps`/`size`（每页条数，上限 100）。响应含 `page`/`page_size`/`total`。

### 错误码

以 i18n key 形式出现在 `message` 字段。源：`i18n/keys.go`（234 个常量）。少量 handler 用硬编码中文。

---

## 资源索引

### 平台基础

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| 系统初始化 | [setup](./setup/) | `/api/setup` | 2 |
| 系统状态 | [status](./status/) | `/api/status`、`/api/uptime/status`、`/api/status/test` | 3 |
| 公告 | [notice](./notice/) | `/api/notice` | 1 |
| 关于页面 | [about](./about/) | `/api/about`、`/api/home_page_content`、`/api/user-agreement`、`/api/privacy-policy` | 4 |
| 定价 | [pricing](./pricing/) | `/api/pricing` | 1 |
| 性能指标 | [perf-metrics](./perf-metrics/) | `/api/perf-metrics` | 2 |
| 用量排行榜 | [rankings](./rankings/) | `/api/rankings` | 1 |
| 邮箱验证码 | [verification](./verification/) | `/api/verification`、`/api/reset_password` | 2 |
| 安全验证 | [verify](./verify/) | `/api/verify` | 1 |
| 倍率配置 | [ratio-config](./ratio-config/) | `/api/ratio_config` | 1 |
| 支付回调 | [webhooks](./webhooks/) | `/api/*/webhook` | 4 |

### 用户体系（[user](./user/)）

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| 用户管理（admin CRUD） | [user](./user/) | `/api/user/`(admin CRUD) | 7 |
| 用户认证 | [user/auth](./user/auth/) | `/api/user/{login,register,reset,auth/*}` | 7 |
| 用户自助 | [user/self](./user/self/) | `/api/user/self`、`/api/user/{token,aff,groups,models,setting}` | 9 |
| Passkey | [user/passkey](./user/passkey/) | `/api/user/passkey/*` | 9 |
| 双因素认证 | [user/2fa](./user/2fa/) | `/api/user/2fa/*`、`/api/user/:id/2fa` | 7 |
| 登录会话 | [user/session](./user/session/) | `/api/user/sessions/*` | 3 |
| 每日签到 | [user/checkin](./user/checkin/) | `/api/user/checkin` | 2 |
| 充值兑换 | [user/topup](./user/topup/) | `/api/user/topup`、`/api/user/aff_transfer` | 7 |
| 在线支付 | [user/payment](./user/payment/) | `/api/user/{pay,stripe,creem,waffo,waffo-pancake}/*` | 8 |
| 易支付回调 | [user/epay](./user/epay/) | `/api/user/epay/notify` | 2 |

### OAuth

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| OAuth 登录 | [oauth](./oauth/) | `/api/oauth/{state,:provider,wechat,telegram}` | 4 |
| OAuth 绑定 | [oauth/bind](./oauth/bind/) | `/api/oauth/*/bind`、`/api/user/oauth/bindings` | 8 |
| 自定义 OAuth | [custom-oauth-provider](./custom-oauth-provider/) | `/api/custom-oauth-provider` | 6 |

### 渠道（[channel](./channel/)）

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| 渠道管理 | [channel](./channel/) | `/api/channel`(CRUD/test/balance/tag/upstream) | 29 |
| 渠道密钥 | [channel/key](./channel/key/) | `/api/channel/:id/key` | 1 |
| Codex 渠道 | [channel/codex](./channel/codex/) | `/api/channel/:id/codex/*` | 4 |
| Ollama 渠道 | [channel/ollama](./channel/ollama/) | `/api/channel/ollama/*` | 4 |

### 订阅（[subscription](./subscription/)）

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| 订阅计划 | [subscription](./subscription/) | `/api/subscription/{plans,self}` | 3 |
| 订阅支付 | [subscription/payment](./subscription/payment/) | `/api/subscription/*/pay` | 5 |
| 订阅回调 | [subscription/callback](./subscription/callback/) | `/api/subscription/epay/*` | 4 |
| 订阅管理 | [subscription/admin](./subscription/admin/) | `/api/subscription/admin/*` | 11 |

### 管理域

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| 系统设置 | [option](./option/) | `/api/option` | 11 |
| 性能管理 | [performance](./performance/) | `/api/performance` | 6 |
| 倍率同步 | [ratio-sync](./ratio-sync/) | `/api/ratio_sync` | 2 |
| 权限目录 | [authz](./authz/) | `/api/authz/catalog` | 1 |
| 令牌 | [token](./token/) | `/api/token` | 10 |
| 令牌用量 | [usage/token](./usage/token/) | `/api/usage/token` | 1 |
| 兑换码 | [redemption](./redemption/) | `/api/redemption` | 7 |
| 日志 | [log](./log/) | `/api/log` | 8 |
| 后台任务 | [system-task](./system-task/) | `/api/system-task` | 4 |
| 系统实例 | [system-info](./system-info/) | `/api/system-info` | 3 |
| 配额统计 | [data](./data/) | `/api/data` | 5 |
| 分组 | [group](./group/) | `/api/group` | 1 |
| 预填充分组 | [prefill-group](./prefill-group/) | `/api/prefill_group` | 4 |
| MJ 任务记录 | [mj-task](./mj-task/) | `/api/mj` | 2 |
| 异步任务记录 | [task](./task/) | `/api/task` | 2 |
| 供应商 | [vendors](./vendors/) | `/api/vendors` | 6 |
| 模型元数据 | [models-meta](./models-meta/) | `/api/models` | 9 |
| io.net 部署 | [deployments](./deployments/) | `/api/deployments` | 19 |

### AI 中转（[relay](./relay/)）

> Relay 接口使用上游原生协议（OpenAI/Claude/Gemini），不走统一响应信封。鉴权统一为 `TokenAuth`（+ `ModelRequestRateLimit` + `Distribute`），个别例外见各端点说明。

#### `/v1` 下

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| 模型列表 | [relay/v1/models](./relay/v1/models/) | `/v1/models`、`/v1/models/:model` | 4 |
| 对话补全 | [relay/v1/chat](./relay/v1/chat/) | `/v1/chat/completions`、`/v1/completions`、`/v1/moderations` | 3 |
| Claude 对话 | [relay/v1/messages](./relay/v1/messages/) | `/v1/messages` | 1 |
| Responses | [relay/v1/responses](./relay/v1/responses/) | `/v1/responses` | 2 |
| Web Search | [relay/v1/alpha/search](./relay/v1/alpha/search/) | `/v1/alpha/search` | 1 |
| 嵌入向量 | [relay/v1/embeddings](./relay/v1/embeddings/) | `/v1/embeddings` | 1 |
| 图像 | [relay/v1/images](./relay/v1/images/) | `/v1/images/*`、`/v1/edits` | 4 |
| 音频 | [relay/v1/audio](./relay/v1/audio/) | `/v1/audio/*` | 3 |
| 重排序 | [relay/v1/rerank](./relay/v1/rerank/) | `/v1/rerank` | 1 |
| Realtime | [relay/v1/realtime](./relay/v1/realtime/) | `/v1/realtime`（WebSocket） | 1 |
| 视频生成 | [relay/v1/video](./relay/v1/video/) | `/v1/video/generations` | 2 |
| 视频(sora) | [relay/v1/videos](./relay/v1/videos/) | `/v1/videos/*` | 4 |
| 文件（未实现） | [relay/v1/files](./relay/v1/files/) | `/v1/files*` | 5 |
| 微调（未实现） | [relay/v1/fine-tunes](./relay/v1/fine-tunes/) | `/v1/fine-tunes*` | 5 |

#### `/v1beta` 下

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| Gemini | [relay/v1beta/models](./relay/v1beta/models/) | `/v1beta/models/*`、`/v1/models/*path`、`/v1/engines/:model/embeddings` | 3 |

#### 独立前缀

| 资源 | 目录 | 路由前缀 | 端点数 |
|---|---|---|---|
| Playground | [relay/pg](./relay/pg/) | `/pg/chat/completions` | 1 |
| Midjourney | [relay/mj](./relay/mj/) | `/mj/*`、`/:mode/mj/*` | 16 |
| Suno | [relay/suno](./relay/suno/) | `/suno/*` | 3 |
| 可灵视频 | [relay/kling](./relay/kling/) | `/kling/v1/videos/*` | 4 |
| 即梦 | [relay/jimeng](./relay/jimeng/) | `/jimeng/` | 1 |
| 计费仪表盘 | [relay/dashboard](./relay/dashboard/) | `/dashboard/billing/*`、`/v1/dashboard/billing/*` | 4 |

**合计顶级目录约 40 个（含嵌套子目录共 70 个），约 330 个端点。**
