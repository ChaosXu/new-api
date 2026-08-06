# new-api 模块索引

> 该组件全部模块的可点击索引。每个非同构模块的详情（职责+正向依赖）在独立文件；同构折叠组见汇总文件。

## 1. 内部模块

### 应用入口与路由装配 (`entry`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| main | 程序入口，解析命令行参数，初始化数据库/配置/缓存/定时任务等子系统并启动 Gin HTTP 服务；通过 `go:embed` 内嵌 `web/dist` 静态站点 | [main.md](entry/main.md) |
| router | 路由注册层，组装 API、Dashboard、Relay、Video 及前端静态资源路由 | [router.md](entry/router.md) |

### 通用基础设施 (`infra`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| common | 通用工具与基础设施层，提供常量、环境变量、Redis、邮件、加密、配额计算、限流、SSRF 防护、系统监控、JSON 包装等跨模块复用能力 | [common.md](infra/common.md) |
| common/limiter | 基于 Redis + 内嵌 Lua 脚本的分布式速率限制器实现 | [common-limiter.md](infra/common-limiter.md) |
| constant | 全局常量定义，涵盖 API 类型、渠道类型、缓存键、上下文键、环境变量名、任务状态等枚举常量 | [constant.md](infra/constant.md) |
| i18n | 国际化支持，基于 go-i18n + 内嵌 YAML 语言包，提供多语言翻译与请求语言解析 | [i18n.md](infra/i18n.md) |
| logger | 全局日志组件，封装分级日志输出、文件与控制台写入、上下文关联等功能 | [logger.md](infra/logger.md) |
| types | 通用基础数据结构（价格数据 PriceData、并发安全 Map、Set 等）供跨模块复用 | [types.md](infra/types.md) |

### Gin 中间件 (`middleware`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| middleware | Gin 中间件层，提供鉴权、CORS、限流、缓存、审计、请求体限制、gzip、recover、turnstile 校验、i18n 等请求处理链 | [middleware.md](middleware/middleware.md) |

### 控制层与数据层 (`controller-model`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| controller | HTTP API 控制器层，处理用户、渠道、令牌、日志、计费、充值、订阅、支付、任务、Passkey 等各业务接口的请求逻辑；含审计 action 模板渲染 | [controller.md](controller-model/controller.md) |
| dto | 异步任务（Suno/Midjourney/视频等）相关的数据传输对象与响应结构定义 | [dto.md](controller-model/dto.md) |
| model | 数据访问层（GORM），定义各实体表结构、数据库连接管理、缓存、查询与 CRUD 操作；含跨库（主库/日志库）兼容处理 | [model.md](controller-model/model.md) |

### 业务服务层 (`service`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| oauth | OAuth 第三方登录提供者抽象与实现（GitHub、Discord、LinuxDo、OIDC、Generic 等） | [oauth.md](service/oauth.md) |
| service | 业务服务层，承载计费结算、渠道选择、令牌计数、任务轮询、敏感词、订阅重置、HTTP 客户端、Codex 凭证等核心业务逻辑 | [service.md](service/service.md) |
| service/authz | 基于 Casbin 的授权/权限服务，定义角色、资源、策略执行器与权限解析 | [service-authz.md](service/service-authz.md) |
| service/passkey | WebAuthn/Passkey 无密码认证服务，构建 WebAuthn 实例并处理注册/登录会话 | [service-passkey.md](service/service-passkey.md) |

### 内部 pkg 包 (`pkg`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| pkg/billingexpr | 计费表达式引擎，基于 expr-lang 编译并执行分层计费表达式，支持表达式版本化 | [pkg-billingexpr.md](pkg/pkg-billingexpr.md) |
| pkg/cachex | 混合缓存组件，结合本地内存（hot）与 Redis 实现带命名空间的多级缓存 | [pkg-cachex.md](pkg/pkg-cachex.md) |
| pkg/ionet | io.net（IONET）云服务客户端，封装其容器/部署/硬件 API 调用 | [pkg-ionet.md](pkg/pkg-ionet.md) |
| pkg/perf_metrics | 性能指标采集组件，聚合分桶并周期性 flush 到数据库 | [pkg-perf_metrics.md](pkg/pkg-perf_metrics.md) |

### 配置管理 (`setting`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| setting | 配置注册入口与自动分组、聊天、Midjourney、敏感词、支付等系统级运行时设置 | [setting.md](setting/setting.md) |
| setting/billing_setting | 计费模式设置（按比例 vs 分层表达式），管理 billing_mode/billing_expr 配置项 | [setting-billing_setting.md](setting/setting-billing_setting.md) |
| setting/config | 统一配置管理器（ConfigManager），负责各设置模块的注册、加载、热更新与持久化 | [setting-config.md](setting/setting-config.md) |
| setting/console_setting | 控制台前端展示设置（API 信息、Uptime Kuma、公告、FAQ 面板开关） | [setting-console_setting.md](setting/setting-console_setting.md) |
| setting/model_setting | 模型相关设置（Claude/Gemini/Grok/Qwen 适配参数、Chat→Responses 转换策略、Claude 请求头等） | [setting-model_setting.md](setting/setting-model_setting.md) |
| setting/operation_setting | 运营管理设置（演示站、自动禁用关键词、签到、监控、支付、配额、令牌、状态码区间、Codex CLI 透传等） | [setting-operation_setting.md](setting/setting-operation_setting.md) |
| setting/perf_metrics_setting | 性能指标采集设置（开关、flush 间隔、分桶粒度、保留天数） | [setting-perf_metrics_setting.md](setting/setting-perf_metrics_setting.md) |
| setting/performance_setting | 性能调优设置（磁盘缓存、监控、连接池等运行期性能开关与阈值） | [setting-performance_setting.md](setting/setting-performance_setting.md) |
| setting/ratio_setting | 计费倍率设置（模型倍率、分组倍率、缓存倍率、对外暴露倍率等） | [setting-ratio_setting.md](setting/setting-ratio_setting.md) |
| setting/reasoning | 推理（reasoning effort）后缀处理工具的兼容再导出层，实际逻辑已迁移至 relaykit | [setting-reasoning.md](setting/setting-reasoning.md) |
| setting/system_setting | 系统级设置（SSRF 防护、OIDC、Discord、Passkey、法务等） | [setting-system_setting.md](setting/setting-system_setting.md) |

### 中继核心与适配框架 (`relay-core`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| relay | 中继（转发）核心包，按上游渠道分发各类中继请求（chat/embedding/image/audio/rerank/responses/claude/gemini 等），是网关转发的入口与编排层 | [relay.md](relay-core/relay.md) |
| relay/channel | 渠道适配器框架，定义统一的 Adaptor 接口（Init/GetRequestURL/ConvertOpenAIRequest/ConvertImage 等）及 API 请求执行与注册逻辑 | [relay-channel.md](relay-core/relay-channel.md) |
| relay/common | 中继通用上下文与工具，核心为 RelayInfo（携带一次中继的全部元信息/计费/流式状态/请求转换）及 BillingSettler 计费会话抽象 | [relay-common.md](relay-core/relay-common.md) |
| relay/common_handler | 跨渠道的通用中继处理器（目前实现 rerank 的重排请求转发） | [relay-common_handler.md](relay-core/relay-common_handler.md) |
| relay/constant | 中继相关常量定义，核心为 RelayMode（各类中继模式枚举，如 Chat/Embeddings/Images 等） | [relay-constant.md](relay-core/relay-constant.md) |
| relay/helper | 中继辅助函数集合：计费/定价、流式扫描与结果收集、模型映射、请求合法性校验等 | [relay-helper.md](relay-core/relay-helper.md) |

### 子 module（relaykit 纯库型） (`relaykit`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| relaykit/dto | 中继数据传输对象（DTO）集合，定义 OpenAI/Claude/Gemini/Audio/Embedding/Rerank/Billing 等各类请求与响应的结构体 | [relaykit-dto.md](relaykit/relaykit-dto.md) |
| relaykit/reasonmap | 上游停止原因（stop_reason/finish_reason）在各协议（Claude/OpenAI）之间的映射工具 | [relaykit-reasonmap.md](relaykit/relaykit-reasonmap.md) |
| relaykit/relayconvert | 中继格式转换框架，通过 request/response/text-converter 注册表与媒体解析，集中编排各协议之间的请求与响应转换 | [relaykit-relayconvert.md](relaykit/relaykit-relayconvert.md) |
| relaykit/relayconvert/convmeta | 定义转换器与宿主之间的转换上下文契约（Meta 接口与每请求选项 Options），并提供根据请求 DTO 推断 RelayFormat 的能力 | [relaykit-relayconvert-convmeta.md](relaykit/relaykit-relayconvert-convmeta.md) |
| relaykit/relayconvert/internal/claude_messages | 将 Claude Messages 协议转换为 OpenAI Chat 请求/响应的内部转换器 | [relaykit-relayconvert-internal-claude_messages.md](relaykit/relaykit-relayconvert-internal-claude_messages.md) |
| relaykit/relayconvert/internal/gemini_chat | 将 Gemini generateContent 协议转换为 OpenAI Chat 请求/响应的内部转换器 | [relaykit-relayconvert-internal-gemini_chat.md](relaykit/relaykit-relayconvert-internal-gemini_chat.md) |
| relaykit/relayconvert/internal/jsonutil | JSON 序列化/字符串化相关的内部纯函数工具 | [relaykit-relayconvert-internal-jsonutil.md](relaykit/relaykit-relayconvert-internal-jsonutil.md) |
| relaykit/relayconvert/internal/media | 媒体（图像/文件）解析的内部工具，提供可由宿主注入的 MediaResolver | [relaykit-relayconvert-internal-media.md](relaykit/relaykit-relayconvert-internal-media.md) |
| relaykit/relayconvert/internal/oai_chat | OpenAI Chat 协议与其他协议（Claude Messages/Gemini/OpenAI Responses）互转的内部转换器集合 | [relaykit-relayconvert-internal-oai_chat.md](relaykit/relaykit-relayconvert-internal-oai_chat.md) |
| relaykit/relayconvert/internal/oai_responses | OpenAI Responses 协议与 Claude Messages/Gemini/OpenAI Chat 互转的内部转换器集合 | [relaykit-relayconvert-internal-oai_responses.md](relaykit/relaykit-relayconvert-internal-oai_responses.md) |
| relaykit/relayconvert/internal/shared/claude | Claude 相关的共享内部工具：缓存 token 拆分、错误处理、tool_choice 规范化 | [relaykit-relayconvert-internal-shared-claude.md](relaykit/relaykit-relayconvert-internal-shared-claude.md) |
| relaykit/relayconvert/internal/shared/gemini | Gemini 相关的共享内部工具：请求构造、schema 处理 | [relaykit-relayconvert-internal-shared-gemini.md](relaykit/relaykit-relayconvert-internal-shared-gemini.md) |
| relaykit/relayconvert/kitutil | 转换工具包共享的无依赖辅助函数（JSON/日志/脱敏/指针取值），由宿主重新导出 | [relaykit-relayconvert-kitutil.md](relaykit/relaykit-relayconvert-kitutil.md) |
| relaykit/relayconvert/reasoning | 推理（reasoning）内容的后缀处理工具，用于在转换中拼接/分离推理内容 | [relaykit-relayconvert-reasoning.md](relaykit/relaykit-relayconvert-reasoning.md) |
| relaykit/types | 中继通用类型定义，核心为 RelayFormat（openai/claude/gemini/responses/rerank 等协议格式）、请求元信息、错误与文件类型 | [relaykit-types.md](relaykit/relaykit-types.md) |

### 渠道适配器（同步中继，同构折叠）

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| relay/channel/*（×39） | 各上游 AI 提供商适配器，实现 `Adaptor` 接口 | [adaptors-sync.md](adaptors-sync.md) |

### 异步任务适配器（同构折叠）

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| relay/channel/task/*（×11） | 图像/视频/音频生成任务适配器 | [adaptors-task.md](adaptors-task.md) |


> 来源：根 `go.mod` 的直接 `require`（剔除 `replace => ./relaykit` 这条仓库内引用）。

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
| github.com/casbin/casbin/v2 | Casbin 权限策略引擎（service/authz） |
| golang.org/x/crypto | 加密/哈希（bcrypt、argon2 等） |
| github.com/Azure/go-ntlmssp | NTLM SSPI 认证支持 |

### 云厂商 SDK

| 依赖 | 用途 |
| --- | --- |
| github.com/aws/aws-sdk-go-v2 | AWS SDK v2 核心 |
| github.com/aws/aws-sdk-go-v2/credentials | AWS 凭证提供 |
| github.com/aws/aws-sdk-go-v2/service/bedrockruntime | AWS Bedrock Runtime（Claude/模型托管） |
| github.com/aws/smithy-go | AWS Smithy 协议运行时 |

### 支付与计费

| 依赖 | 用途 |
| --- | --- |
| github.com/Calcium-Ion/go-epay | 易支付（EPay）聚合支付 |
| github.com/stripe/stripe-go/v81 | Stripe 支付 |
| github.com/waffo-com/waffo-go | Waffo 支付 |
| github.com/waffo-com/waffo-pancake-sdk-go | Waffo Pancake SDK |
| github.com/shopspring/decimal | 高精度十进制运算（计费/配额换算） |
| github.com/expr-lang/expr | 表达式引擎（pkg/billingexpr 分层计费） |

### 音频/媒体处理

| 依赖 | 用途 |
| --- | --- |
| github.com/tcolgate/mp3 | MP3 时长解析（按音频时长计费） |
| github.com/go-audio/wav | WAV 音频解析 |
| github.com/go-audio/aiff | AIFF 音频解析 |
| github.com/jfreymuth/oggvorbis | Ogg Vorbis 音频解析 |
| github.com/mewkiz/flac | FLAC 音频解析 |
| github.com/abema/go-mp4 | MP4 容器解析（视频时长/元数据） |
| github.com/yapingcat/gomedia | 媒体封装/转码工具 |
| golang.org/x/image | 图像解码扩展 |

### 序列化与数据访问

| 依赖 | 用途 |
| --- | --- |
| github.com/tidwall/gjson | JSON 路径读取（运行时动态取值） |
| github.com/tidwall/sjson | JSON 路径写入（动态设置字段） |
| gopkg.in/yaml.v3 | YAML 解析（i18n 语言包、配置） |
| github.com/jinzhu/copier | 结构体深拷贝 |

### 分词与工具集

| 依赖 | 用途 |
| --- | --- |
| github.com/tiktoken-go/tokenizer | tiktoken 分词（OpenAI 系列本地 token 计数） |
| github.com/samber/lo | 泛型工具集（map/filter/contains 等） |
| github.com/joho/godotenv | `.env` 环境变量加载 |
| github.com/pkg/errors | 带堆栈的错误包装 |
| github.com/thanhpk/randstr | 随机字符串生成（令牌、邀请码） |
| github.com/google/uuid | UUID 生成 |
| github.com/bytedance/gopkg | 字节跳动 Go 工具集 |
| golang.org/x/sync | 同步原语扩展（errgroup 等） |
| golang.org/x/net | 网络扩展（HTTP2、代理等） |
| golang.org/x/sys | 系统调用封装 |
| golang.org/x/text | 文本/编码处理（Unicode、国际化） |

### 国际化

| 依赖 | 用途 |
| --- | --- |
| github.com/nicksnyder/go-i18n/v2 | go-i18n 多语言翻译（i18n 包） |

### 可观测性

| 依赖 | 用途 |
| --- | --- |
| github.com/grafana/pyroscope-go | Pyroscope 持续性能剖析 |
| github.com/shirou/gopsutil | 系统进程/资源监控 |

### 压缩

| 依赖 | 用途 |
| --- | --- |
| github.com/klauspost/compress | 高性能压缩（zstd/flate 等，上游响应/日志） |
| github.com/andybalholm/brotli | Brotli 压缩 |

### 校验

| 依赖 | 用途 |
| --- | --- |
| github.com/go-playground/validator/v10 | 结构体字段校验 |

### 测试

| 依赖 | 用途 |
| --- | --- |
| github.com/stretchr/testify | 测试断言与 mock |
| github.com/alicebob/miniredis/v2 | 嵌入式 Redis mock（缓存测试） |