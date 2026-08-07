# new-api 模块索引

> 该组件的**逻辑模块**索引。模块从代码职责提炼归类，不与源码目录 1:1 对应（一个模块可覆盖多个目录，多个内聚目录可归为一个模块）。详情见各模块文件。

## 关键流程（模块间动态协作）

> 静态模块卡描述"是什么"；流程文档描述"一个请求/场景怎么在模块间流转"。跨模块流程放在 `flows/`。下表列 L3 级别（跨逻辑模块协作）的全部业务流程，分"请求驱动"与"后台自动"两类；纯 CRUD（令牌/用户/日志/系统设置管理）不单独成流程。

**请求驱动流程**（HTTP 入口）：

| 场景 | 流程文档 |
| --- | --- |
| 同步中继（chat/embedding/image/audio/rerank/responses） | [flows/sync-relay.md](flows/sync-relay.md) |
| 异步任务（图像/视频/音频生成：Suno/Midjourney/Kling/Sora 等） | [flows/async-task.md](flows/async-task.md) |
| 计费结算（预扣→差额结算→退还） | [flows/billing-settle.md](flows/billing-settle.md) |
| 用户登录与鉴权（密码/OAuth/Passkey/2FA/账户绑定） | [flows/auth-login.md](flows/auth-login.md) |
| 充值与支付（EPay/Stripe/Creem/Waffo/Waffo Pancake + webhook） | [flows/topup-payment.md](flows/topup-payment.md) |
| 订阅（周期订阅，含配额重置） | [flows/subscription.md](flows/subscription.md) |
| 兑换码兑换 | [flows/redemption.md](flows/redemption.md) |
| 用户签到 | [flows/checkin.md](flows/checkin.md) |
| 上游模型/倍率同步 | [flows/upstream-sync.md](flows/upstream-sync.md) |
| io.net 部署管理 | [flows/ionet-deployment.md](flows/ionet-deployment.md) |
| 渠道管理（测试/自动禁用/自动启用） | [flows/channel-manage.md](flows/channel-manage.md) |

**后台自动流程**（main.go 启动，无 HTTP 入口）：

| 场景 | 流程文档 |
| --- | --- |
| 后台自动维护任务（系统任务调度器、凭证刷新、配额聚合、auth 清理等） | [flows/background-tasks.md](flows/background-tasks.md) |

## 1. 内部模块（逻辑模块）

### 中继转发 (`relay`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 编排入口 | 中继总入口，按渠道分发，串联转换→调用→计费链路 | relay/（根包）、relay/constant/、relay/common_handler/ | [relay-orchestration.md](modules/relay/relay-orchestration.md) |
| 渠道适配框架 | 统一 Adaptor 接口 + 39 同步适配器 + 11 任务适配器 | relay/channel/、relay/channel/*/、relay/channel/task/*/、relay/relay_adaptor.go | [relay-adaptor.md](modules/relay/relay-adaptor.md) |
| 协议转换 | 各中继协议（OpenAI/Claude/Gemini/Responses）互转的纯库 | relaykit/ | [relaykit.md](modules/relay/relaykit.md) |
| 中继上下文 | 一次中继的全链路状态容器（RelayInfo）与计费会话（BillingSettler） | relay/common/ | [relay-context.md](modules/relay/relay-context.md) |
| 中继辅助 | 计费/定价、流式扫描、模型映射、请求校验等共用函数 | relay/helper/ | [relay-helper.md](modules/relay/relay-helper.md) |

### 业务逻辑 (`service`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 计费结算 | 配额预扣/结算/退还/违规扣费，含分层表达式计费 | service/billing*.go、service/quota.go、service/text_quota.go、service/tiered_settle.go、service/violation_fee.go、service/task_billing.go、common/quota*.go、service/log_info_generate.go | [billing.md](modules/service/billing.md) |
| 渠道选择 | 按优先级/权重/分组/亲和性选渠道，渠道可用性管理 | service/channel.go、service/channel_select.go、service/channel_affinity.go、service/group.go | [channel-select.md](modules/service/channel-select.md) |
| 令牌计数与用量 | 文本/图像/音频的 token 计数与用量估算 | service/token_*.go、service/usage_helpr.go、service/text_quota.go、service/image.go、service/audio.go | [token-usage.md](modules/service/token-usage.md) |
| 任务轮询与异步处理 | 异步任务的提交/轮询/状态推进/结算 | service/task.go、service/task_polling.go、service/midjourney.go、service/subscription_reset_task.go、service/system_task.go、service/webhook.go | [task-polling.md](modules/service/task-polling.md) |
| HTTP 客户端与文件处理 | HTTP 客户端/文件解码/敏感词/支付/Codex 等杂项业务 | service/http*.go、service/download.go、service/file_*.go、service/sensitive.go、service/epay.go、service/waffo_pancake.go、service/codex_*.go 等 | [http-file-misc.md](modules/service/http-file-misc.md) |

### HTTP 接口 (`api`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 控制器 | 各业务接口的 HTTP 请求处理 + 审计模板 | controller/ | [controller.md](modules/api/controller.md) |
| 中间件 | CORS/限流/缓存/审计/turnstile/i18n 等非鉴权中间件 | middleware/（除 auth.go/auth_origin.go） | [middleware.md](modules/api/middleware.md) |

### 数据访问 (`data`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 实体数据访问 | GORM 实体表结构与 CRUD，跨库兼容，缓存 | model/ | [data-access.md](modules/data/data-access.md) |

### 鉴权 (`auth`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 会话与令牌鉴权 | 会话/Cookie 与 API Token 身份校验，注入用户上下文 | middleware/auth.go、middleware/auth_origin.go、service/auth_session.go、service/auth_token.go、service/auth_cleanup.go | [session-auth.md](modules/auth/session-auth.md) |
| OAuth 登录 | 第三方 OAuth 提供者（GitHub/Discord/OIDC 等）登录与绑定 | oauth/、service/codex_oauth.go | [oauth.md](modules/auth/oauth.md) |
| Passkey 与无密码认证 | WebAuthn Passkey 注册/登录，TOTP 两步验证 | service/passkey/ | [passkey.md](modules/auth/passkey.md) |
| 权限授权（RBAC） | Casbin 角色权限策略执行 | service/authz/ | [authz.md](modules/auth/authz.md) |

### 配置管理 (`config`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 运行时配置 | 各设置模块的注册/加载/热更新/持久化 | setting/、setting/config/、setting/*_setting/、setting/reasoning/ | [runtime-config.md](modules/config/runtime-config.md) |

### 基础设施 (`infra`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 通用工具 | Redis/邮件/加密/配额计算/限流/SSRF 防护/JSON 包装/日志/i18n | common/、common/limiter/、logger/、i18n/ | [common-utils.md](modules/infra/common-utils.md) |
| 常量与基础类型 | 全局枚举常量 + 基础数据结构（PriceData/Map/Set）+ 任务 DTO | constant/、types/、dto/ | [constants-types.md](modules/infra/constants-types.md) |

### 内部工具包 (`pkg`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 计费表达式引擎 | expr-lang 分层计费表达式编译/执行/版本化 | pkg/billingexpr/ | [billing-expr.md](modules/pkg/billing-expr.md) |
| 多级缓存与可观测与 io.net | cachex 多级缓存 + perf_metrics 性能采集 + io.net 客户端 | pkg/cachex/、pkg/perf_metrics/、pkg/ionet/ | [cachex-perf-ionet.md](modules/pkg/cachex-perf-ionet.md) |

## 2. 导入模块（第三方依赖）

> 按职能分类。用途据本组件源码中的实际 import/调用位置归纳。

### Web 框架与 HTTP 中间件

| 依赖 | 用途 |
| --- | --- |
| github.com/gin-gonic/gin | Gin Web 框架（路由、请求绑定、响应） |
| github.com/gin-contrib/cors | CORS 跨域中间件 |
| github.com/gin-contrib/gzip | gzip 响应压缩中间件 |
| github.com/gin-contrib/static | 前端静态资源托管中间件 |
| github.com/gorilla/websocket | WebSocket 连接处理（Suno/任务进度等实时通道） |

### ORM 与数据库驱动

| 依赖 | 用途 |
| --- | --- |
| gorm.io/gorm | GORM v2 ORM |
| gorm.io/driver/mysql | MySQL 驱动 |
| gorm.io/driver/postgres | PostgreSQL 驱动 |
| gorm.io/driver/clickhouse | ClickHouse 驱动（日志库可选） |
| github.com/glebarez/sqlite | 纯 Go SQLite 驱动（默认数据库） |
| github.com/glebarez/go-sqlite | sqlite 底层驱动 |
| github.com/go-sql-driver/mysql | MySQL 底层驱动 |
| github.com/jackc/pgx/v5 | PostgreSQL 底层驱动（pgx） |
| github.com/ClickHouse/clickhouse-go/v2 | ClickHouse 底层驱动 |

### 缓存与限流

| 依赖 | 用途 |
| --- | --- |
| github.com/go-redis/redis/v8 | Redis 客户端（缓存、分布式限流、会话） |
| github.com/samber/hot | 本地内存 LRU 缓存（与 Redis 组成多级缓存） |
| github.com/anknown/ahocorasick | AC 自动机多模式匹配（敏感词过滤） |

### 鉴权与安全

| 依赖 | 用途 |
| --- | --- |
| github.com/golang-jwt/jwt/v5 | JWT 签发与校验 |
| github.com/go-webauthn/webauthn | WebAuthn/Passkey 无密码认证 |
| github.com/pquerna/otp | TOTP 两步验证 |
| github.com/casbin/casbin/v2 | Casbin 权限策略引擎 |
| golang.org/x/crypto | 加密/哈希（bcrypt、argon2 等） |

### 云厂商 SDK

| 依赖 | 用途 |
| --- | --- |
| github.com/aws/aws-sdk-go-v2 | AWS SDK v2（Bedrock Runtime） |

### 支付与计费

| 依赖 | 用途 |
| --- | --- |
| github.com/Calcium-Ion/go-epay | 易支付（EPay）聚合支付 |
| github.com/stripe/stripe-go/v81 | Stripe 支付 |
| github.com/shopspring/decimal | 高精度十进制运算（计费/配额换算） |
| github.com/expr-lang/expr | 表达式引擎（分层计费） |

### 音频/媒体处理

| 依赖 | 用途 |
| --- | --- |
| github.com/tcolgate/mp3 | MP3 时长解析（按音频时长计费） |
| github.com/go-audio/wav、github.com/abema/go-mp4 等 | 各类音频/视频容器解析 |

### 序列化、分词与工具集

| 依赖 | 用途 |
| --- | --- |
| github.com/tidwall/gjson、github.com/tidwall/sjson | JSON 路径读写 |
| gopkg.in/yaml.v3 | YAML 解析（i18n 语言包、配置） |
| github.com/tiktoken-go/tokenizer | tiktoken 分词（OpenAI 系列本地 token 计数） |
| github.com/samber/lo | 泛型工具集 |
| github.com/nicksnyder/go-i18n/v2 | go-i18n 多语言翻译 |
