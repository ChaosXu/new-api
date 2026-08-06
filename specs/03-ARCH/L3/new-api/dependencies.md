# new-api

## 1. 内部模块直接依赖

> 只列直接依赖的内部模块，剔除标准库与第三方。模块清单与职责见 `modules.md`。

### 应用入口与基础设施

| 模块 | 直接依赖（内部） |
| --- | --- |
| `.`（main） | common、constant、controller、i18n、logger、middleware、model、oauth、pkg/perf_metrics、relay、router、service、service/authz、setting/performance_setting、setting/ratio_setting、relaykit/relayconvert/kitutil |
| router | controller、middleware、relay、relay/common、service、common、logger、model |
| common | constant、relaykit/relayconvert/kitutil |
| common/limiter | common |
| constant | relaykit/types |
| logger | common、setting/operation_setting |
| i18n | common、constant、relaykit/dto |
| types | —（叶子，被广泛复用的基础数据结构） |

### 中间件、控制层、数据层

| 模块 | 直接依赖（内部） |
| --- | --- |
| middleware | common、common/limiter、constant、dto、i18n、logger、model、relay/constant、relaykit/dto、relaykit/types、service、service/authz、setting、setting/ratio_setting |
| controller | common、constant、dto、i18n、logger、middleware、model、oauth、pkg/billingexpr、pkg/ionet、pkg/perf_metrics、relay、relay/channel、relay/channel/advancedcustom、relay/channel/ai360、relay/channel/codex、relay/channel/gemini、relay/channel/lingyiwanwu、relay/channel/minimax、relay/channel/moonshot、relay/channel/ollama、relay/common、relay/constant、relay/helper、relaykit/dto、relaykit/types、service、service/authz、service/passkey、setting、setting/billing_setting、setting/console_setting、setting/model_setting、setting/operation_setting、setting/ratio_setting、setting/system_setting、types |
| model | common、constant、logger、pkg/cachex、relay/common、relaykit/dto、relaykit/types、setting、setting/billing_setting、setting/config、setting/console_setting、setting/operation_setting、setting/performance_setting、setting/ratio_setting、setting/system_setting、types |
| dto | —（叶子，异步任务 DTO） |
| oauth | common、i18n、logger、model、setting/system_setting |

### 业务服务层

| 模块 | 直接依赖（内部） |
| --- | --- |
| service | common、constant、dto、logger、model、pkg/billingexpr、pkg/cachex、pkg/perf_metrics、relay/channel/task/taskcommon、relay/common、relay/constant、relaykit/dto、relaykit/relayconvert、relaykit/types、setting、setting/model_setting、setting/operation_setting、setting/ratio_setting、setting/system_setting、types |
| service/authz | common、model |
| service/passkey | common、model、setting/system_setting |

### 内部 pkg 包

| 模块 | 直接依赖（内部） |
| --- | --- |
| pkg/billingexpr | common |
| pkg/ionet | —（叶子，io.net 客户端；依赖见 modules.md 导入模块区） |
| pkg/cachex | —（叶子，多级缓存） |
| pkg/perf_metrics | common、model、relay/common、setting/perf_metrics_setting |

### 配置管理

| 模块 | 直接依赖（内部） |
| --- | --- |
| setting | —（叶子，配置注册入口） |
| setting/config | common |
| setting/billing_setting | pkg/billingexpr、setting/config |
| setting/console_setting | setting/config |
| setting/model_setting | common、setting/config |
| setting/operation_setting | common、relaykit/types、setting/config |
| setting/perf_metrics_setting | setting/config |
| setting/performance_setting | common、setting/config |
| setting/ratio_setting | common、setting/config、setting/operation_setting、types |
| setting/reasoning | relaykit/relayconvert/reasoning（纯再导出层） |
| setting/system_setting | common、setting/config |

### 中继核心与适配框架

| 模块 | 直接依赖（内部） |
| --- | --- |
| relay（编排入口） | **全部 39 个同步适配器 + 11 个 task 适配器 + taskcommon**（用于渠道注册与分发）、relay/channel、relay/common、relay/constant、relay/helper、common、constant、dto、logger、model、service、setting、setting/model_setting、setting/ratio_setting、setting/reasoning、setting/system_setting、relaykit/dto、relaykit/relayconvert、relaykit/types |
| relay/common | common、constant、dto、pkg/billingexpr、relay/constant、relaykit/dto、relaykit/relayconvert/convmeta、relaykit/types、setting/model_setting、setting/operation_setting、types |
| relay/common_handler | common、constant、logger、relay/channel/xinference、relay/common、relaykit/dto、relaykit/types、service |
| relay/constant | —（叶子，RelayMode 枚举等） |
| relay/helper | common、constant、logger、model、pkg/billingexpr、relay/common、relay/constant、relaykit/dto、relaykit/types、service、setting/billing_setting、setting/operation_setting、setting/ratio_setting、types |
| relay/channel（框架） | common、dto、logger、model、relay/common、relay/constant、relay/helper、relaykit/dto、relaykit/types、service、setting/operation_setting |

### 渠道适配器（relay/channel/*，同步中继）

> **共性依赖**（34/39 个适配器共有）：`relay/channel`（实现 `Adaptor` 接口）、`relay/common`、`relaykit/dto`、`relaykit/types`。此外高频依赖：`common`（25）、`relay/constant`（24）、`service`（23）、`constant`（16）、`relay/helper`（15）、`logger`（9）。
> 下表只列**共性之外的非典型依赖**（适配器间的复用关系）；无特例的适配器依赖即上述共性集合，不重复列出。

| 适配器 | 非典型依赖（共性之外） |
| --- | --- |
| relay/channel/openai | 复用 relay/channel/ai360、lingyiwanwu、minimax、openrouter、xinference（OpenAI 兼容厂商的基础转换）；**自身被 23 个适配器作为 OpenAI 协议基础复用** |
| relay/channel/claude | （被 aws、ali、deepseek、minimax、moonshot、newapi、vertex、volcengine、zhipu_4v、advancedcustom 共 10 个适配器复用——这些 provider 走 Claude Messages 协议） |
| relay/channel/gemini | （被 newapi、vertex、advancedcustom 共 3 个适配器复用） |
| relay/channel/aws | relay/channel/claude（Bedrock 托管 Claude 模型，复用 Claude 协议转换） |
| relay/channel/vertex | relay/channel/claude、relay/channel/gemini、relay/channel/openai（Vertex 同时托管多种模型族） |
| relay/channel/newapi | relay/channel/claude、relay/channel/gemini、relay/channel/openai（对接另一 new-api 实例，转发多协议） |
| relay/channel/sub2api | relay/channel/newapi（组合复用 newapi 适配器，实现订阅转 API） |
| relay/channel/advancedcustom | relay/channel/claude、relay/channel/gemini、relay/channel/openai（自定义高级渠道，按协议族分发） |
| relay/channel/ali | relay/channel/claude、relay/channel/openai |
| relay/channel/deepseek | relay/channel/claude、relay/channel/openai |
| relay/channel/minimax | relay/channel/claude、relay/channel/openai |
| relay/channel/moonshot | relay/channel/claude、relay/channel/openai |
| relay/channel/volcengine | relay/channel/claude、relay/channel/openai |
| relay/channel/zhipu_4v | relay/channel/claude、relay/channel/openai |
| relay/channel/baidu_v2、cloudflare、codex、gemini、jimeng、jina、mistral、ollama、perplexity、siliconflow、submodel、tencent、xai | relay/channel/openai（OpenAI 兼容，复用其转换） |

### 异步任务适配器（relay/channel/task/*）

> **共性依赖**（10/11 个 task 适配器共有）：`relay/channel`、`relay/channel/task/taskcommon`、`relay/common`、`service`、`dto`、`common`、`model`、`constant`（taskcommon 自身依赖 relay/channel、relay/common、relaykit/dto、relaykit/types）。各 task 适配器依赖结构高度同构，无显著特例，不逐个展开。

### relaykit 子 module（纯库型内部模块）

> relaykit 有独立 `go.mod`，根 module 以 `require + replace => ./relaykit` 引入，**属内部依赖而非第三方**。其内部包间依赖呈分层结构：

| relaykit 子包 | 直接依赖（relaykit 内部） |
| --- | --- |
| relaykit/types | relaykit/relayconvert/kitutil |
| relaykit/dto | relaykit/types、relaykit/relayconvert/kitutil |
| relaykit/reasonmap | relaykit/types |
| relaykit/relayconvert（框架） | relaykit/dto、relaykit/types、relaykit/relayconvert/convmeta、relaykit/relayconvert/kitutil、relaykit/relayconvert/internal/{claude_messages, gemini_chat, media, oai_chat, oai_responses, shared/gemini} |
| relaykit/relayconvert/convmeta | relaykit/dto、relaykit/types |
| relaykit/relayconvert/kitutil | —（叶子，无依赖工具函数，由宿主重新导出） |
| relaykit/relayconvert/internal/claude_messages | relaykit/dto、relaykit/reasonmap、relaykit/relayconvert/convmeta、relaykit/relayconvert/internal/shared/claude、relaykit/relayconvert/kitutil |
| relaykit/relayconvert/internal/gemini_chat | relaykit/dto、relaykit/relayconvert/convmeta、relaykit/relayconvert/internal/jsonutil、relaykit/relayconvert/kitutil、relaykit/types |
| relaykit/relayconvert/internal/oai_chat | relaykit/dto、relaykit/reasonmap、relaykit/relayconvert/convmeta、relaykit/relayconvert/internal/{media, shared/claude, shared/gemini}、relaykit/relayconvert/kitutil、relaykit/relayconvert/reasoning |
| relaykit/relayconvert/internal/oai_responses | relaykit/dto、relaykit/relayconvert/convmeta、relaykit/relayconvert/internal/{media, shared/claude, shared/gemini}、relaykit/relayconvert/kitutil、relaykit/types |
| relaykit/relayconvert/internal/jsonutil | relaykit/relayconvert/kitutil |
| relaykit/relayconvert/internal/media | relaykit/types |
| relaykit/relayconvert/internal/shared/claude | relaykit/dto |
| relaykit/relayconvert/internal/shared/gemini | relaykit/dto、relaykit/relayconvert/convmeta、relaykit/relayconvert/kitutil、relaykit/relayconvert/reasoning |

---

## 2. 枢纽模块及其主要消费者

> 枢纽 = 被广泛依赖（≥5 模块直接依赖）或承载核心契约。消费者数量多时只列代表性/分组，注明总数。

| 枢纽模块 | 主要消费者（内部） | 为何是枢纽 |
| --- | --- | --- |
| common | 几乎所有模块（63 个直接依赖）：controller、model、service、middleware、relay/*、relay/channel/*、setting/*、pkg/*、oauth 等 | 广泛依赖：通用基础设施层（Redis、加密、配额计算、JSON 包装、限流） |
| relaykit/dto | 中继链路全部模块（60 个）：relay/*、relay/channel/*（同步+task）、controller、service、middleware、model | 广泛依赖：所有中继请求/响应结构体的统一定义 |
| relaykit/types | 中继链路全部模块（53 个）：同上分布 | 广泛依赖：中继通用类型（RelayFormat、错误类型、文件类型） |
| relay/common | 中继链路全部模块（53 个）：relay/channel/*、relay/helper、service、model、pkg/perf_metrics、controller | 核心契约：定义 `RelayInfo`（贯穿一次中继全链路）与 `BillingSettler`（计费会话） |
| relay/channel | 39 个同步适配器 + 11 个 task 适配器（均实现其接口）、relay（编排）、controller（渠道测试） | 核心契约：定义 `Adaptor`/`TaskAdaptor` 接口，是所有渠道适配器的统一约定 |
| service | controller、middleware、relay/channel/*、relay/helper、relay/common_handler、model 的反向（40 个直接依赖） | 广泛依赖：业务服务层（计费结算、渠道选择、令牌计数、任务轮询） |
| constant | common、controller、middleware、model、service、relay/*、setting/*（38 个） | 广泛依赖：全局枚举常量（API 类型、渠道类型、缓存键、上下文键） |
| relay/constant | relay、relay/channel/*、relay/common、relay/helper、middleware（31 个） | 核心契约：RelayMode 枚举（Chat/Embeddings/Images 等中继模式） |
| relay/channel/openai | 23 个 OpenAI 兼容适配器复用（advancedcustom/aws 子集/baidu_v2/cloudflare/codex/deepseek/gemini/jimeng/jina/minimax/mistral/moonshot/newapi/ollama/perplexity/siliconflow/sub2api 间接/submodel/tencent/vertex 子集/volcengine/xai/zhipu_4v 等） | 核心契约：OpenAI 协议基础转换器，兼容 OpenAI 协议的厂商都复用它 |
| model | controller、middleware、service、relay/helper、relay/channel、oauth、pkg/perf_metrics、relay（21 个） | 广泛依赖：数据访问层，几乎所有业务模块读写实体都经此 |
| logger | controller、middleware、model、relay/channel/*、service、setting/*、oauth 等（20 个） | 广泛依赖：全局日志组件 |
| relay/helper | relay/channel/*、relay/common_handler、controller（18 个） | 核心契约：中继辅助函数（计费/定价、流式扫描、模型映射、请求校验） |
| dto | controller、middleware、service、relay/channel、relay/common、relay/helper（16 个） | 广泛依赖：异步任务 DTO，任务类中继的共享数据结构 |
| setting/model_setting | controller、model、relay/common、relay/helper、service、relay/channel/*（12 个） | 广泛依赖：模型适配参数（Claude/Gemini/Grok/Qwen），中继链路读取 |
| relay/channel/task/taskcommon | 11 个 task 适配器 + relay（编排） + service（12 个） | 核心契约：异步任务适配器的公共上下文与响应处理 |
| relaykit/relayconvert/kitutil | common、relaykit 内部多数子包（11 个） | 广泛依赖：无依赖的纯工具函数，由宿主重新导出供 relaykit 内部与根 module 共用 |
| relay/channel/claude | 10 个适配器复用（aws、ali、deepseek、minimax、moonshot、newapi、vertex、volcengine、zhipu_4v、advancedcustom） | 核心契约：Claude Messages 协议转换器，走 Claude 协议的厂商都复用它 |
| setting/config | setting/* 子模块、common（9 个） | 核心契约：ConfigManager，所有设置模块的注册/加载/热更新中枢 |
| setting/ratio_setting | controller、middleware、model、service、relay/helper、setting/ratio_setting 自身被 setting 依赖（8 个） | 广泛依赖：计费倍率配置，计费链路读取 |
| setting/operation_setting | controller、middleware、model、relay/channel、relay/common、relay/helper、service、setting/ratio_setting（8 个） | 广泛依赖：运营设置（自动禁用、签到、监控等），中继链路读取 |
| pkg/billingexpr | controller、model、relay/common、relay/helper、service、setting/billing_setting（6 个） | 核心契约：分层计费表达式引擎 |
| types | controller、middleware、model、relay/common、relay/helper、setting/ratio_setting（6 个） | 广泛依赖：基础数据结构（PriceData、并发 Map、Set） |
