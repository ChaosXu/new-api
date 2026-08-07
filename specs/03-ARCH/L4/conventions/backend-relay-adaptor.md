# 如何写一个新的 relay 渠道适配器

> 适用：新增一个上游 AI 提供商（如新增 `xprovider`）。覆盖同步适配器（`Adaptor`）与异步任务适配器（`TaskAdaptor`）。39 个现有同步适配器、11 个 task 适配器都遵循此范式。

## 代码范式

### 目录与文件

新建 `relay/channel/<provider>/` 目录，最少两个文件：

```
relay/channel/<provider>/
├── adaptor.go       # 实现 Adaptor 接口（或 TaskAdaptor）
└── constants.go     # ModelList（支持的模型列表）+ ChannelName
```

### Adaptor 结构

```go
package <provider>  // 包名 = provider 名

type Adaptor struct {
    // 通常空结构体；需要持有状态的适配器可加字段（如 openai 的 ProxyMode）
}

// 实现所有 Adaptor 接口方法（见"关键契约"）
```

**复用模式**（重要）：如果你的 provider 兼容某个主流协议，不要从零写转换逻辑，复用已有适配器：
- 兼容 OpenAI 协议 → 组合 `openai.Adaptor{}`，调用其方法
- 走 Claude Messages 协议 → 组合 `claude.Adaptor{}`
- 走 Gemini 协议 → 组合 `gemini.Adaptor{}`

例（deepseek 复用 claude 的转换）：
```go
func (a *Adaptor) ConvertClaudeRequest(c *gin.Context, info *relaycommon.RelayInfo, req *dto.ClaudeRequest) (any, error) {
    adaptor := claude.Adaptor{}
    return adaptor.ConvertClaudeRequest(c, info, req)
}
```

不支持的方法返回 `errors.New("not implemented")`，不要留空。

## 关键契约

### Adaptor 接口（`relay/channel/adapter.go`）

必须实现的完整接口（同步中继）：

```go
type Adaptor interface {
    Init(info *relaycommon.RelayInfo)
    GetRequestURL(info *relaycommon.RelayInfo) (string, error)
    SetupRequestHeader(c *gin.Context, req *http.Header, info *relaycommon.RelayInfo) error
    ConvertOpenAIRequest(c *gin.Context, info *relaycommon.RelayInfo, request *dto.GeneralOpenAIRequest) (any, error)
    ConvertRerankRequest(c *gin.Context, relayMode int, request dto.RerankRequest) (any, error)
    ConvertEmbeddingRequest(c *gin.Context, info *relaycommon.RelayInfo, request dto.EmbeddingRequest) (any, error)
    ConvertAudioRequest(c *gin.Context, info *relaycommon.RelayInfo, request dto.AudioRequest) (io.Reader, error)
    ConvertImageRequest(c *gin.Context, info *relaycommon.RelayInfo, request dto.ImageRequest) (any, error)
    ConvertOpenAIResponsesRequest(c *gin.Context, info *relaycommon.RelayInfo, request dto.OpenAIResponsesRequest) (any, error)
    DoRequest(c *gin.Context, info *relaycommon.RelayInfo, requestBody io.Reader) (any, error)
    DoResponse(c *gin.Context, resp *http.Response, info *relaycommon.RelayInfo) (usage any, err *types.NewAPIError)
    GetModelList() []string
    GetChannelName() string
    ConvertClaudeRequest(c *gin.Context, info *relaycommon.RelayInfo, request *dto.ClaudeRequest) (any, error)
    ConvertGeminiRequest(c *gin.Context, info *relaycommon.RelayInfo, request *dto.GeminiChatRequest) (any, error)
}
```

关键类型来源：
- `dto.*`（请求结构）→ `relaykit/dto`（GeneralOpenAIRequest/ClaudeRequest/GeminiChatRequest 等）
- `relaycommon.RelayInfo` → `relay/common`（一次中继的全链路状态容器）
- `types.NewAPIError` → `relaykit/types`（错误返回类型）

### TaskAdaptor 接口（异步任务：图像/视频/音频生成）

若新增的是任务类 provider（如新的视频生成），实现 `TaskAdaptor`（同文件 `adapter.go`），额外含 `ValidateRequestAndSetAction`、`EstimateBilling`（返回 OtherRatios 用于预扣费）、`DoResponse` 等。**计费相关方法必须遵守计费安全约束**（见项目约束 + AGENTS.md "Billing safety invariants"）。

### RelayInfo 关键字段（`relay/common/relay_info.go`）

适配器通过 `info *relaycommon.RelayInfo` 拿到本次请求的上下文，常用字段：
- `info.ChannelType` / `info.APIType` — 渠道与协议类型
- `info.BaseUrl` — 上游基础 URL
- `info.ApiKey` — 渠道密钥
- `info.UpstreamModelName` — 映射后的上游模型名
- `info.IsStream` — 是否流式

## 注册（4 处登记，缺一不可）

新适配器要在 4 个文件登记，系统才能识别并分发到它：

| # | 文件 | 加什么 |
| --- | --- | --- |
| 1 | `constant/api_type.go` | 加 `APIType<Provider>`（iota 枚举，接在现有列表后） |
| 2 | `constant/channel.go` | 加 `ChannelType<Provider> = <N>`（编号）+ 加入 `ChannelType2Name` 映射 + 加入 `ChannelBaseURLs` 数组（Base URL） |
| 3 | `relay/common/relay_info.go` | 在 ChannelType→APIType 映射中加映射；若支持 StreamOptions，加入 `streamSupportedChannels` map |
| 4 | `relay/relay_adaptor.go` | 在 `GetAdaptor(apiType int)` 的 switch 加 `case constant.APIType<Provider>: return &<provider>.Adaptor{}` |

## 项目约束（摘自 AGENTS.md，适用本类代码）

- **JSON**：所有 marshal/unmarshal 必须用 `common.Marshal`/`common.Unmarshal` 等，**不得直接用 `encoding/json`**。`json.RawMessage`/`json.Number` 可作类型引用。
- **请求 DTO 指针字段**：从客户端 JSON 解析、再 marshal 给上游的请求结构体，可选标量字段必须用指针 + `omitempty`（`*int`/`*bool`/`*float64`），保留显式零值，不丢字段。
- **relaykit 独立 build**：若你的适配器要用 relaykit，注意 relaykit 不得依赖根模块。改了 relaykit 必须单独验证 `cd relaykit && GOWORK=off go build ./...`。
- **计费安全**（TaskAdaptor）：`EstimateBilling` 返回的 OtherRatios 会成为计费乘数，必须是有界正数；不得产生负扣费。乘数须经 `types.PriceData.AddOtherRatio`（拒绝非正/NaN/Inf）。
- **StreamOptions**：若 provider 支持，必须加入 `streamSupportedChannels`，否则流式选项不生效。

## 样板指针

写新适配器前，先读这 1-2 个真实文件：

| 你的 provider 类型 | 仿写 |
| --- | --- |
| OpenAI 兼容协议（最常见） | `relay/channel/openai/`（基础）+ `relay/channel/deepseek/`（复用 openai 的简单例子） |
| Claude Messages 协议 | `relay/channel/claude/` |
| Gemini 协议 | `relay/channel/gemini/` |
| 异步任务（视频/图像生成） | `relay/channel/task/kling/` 或 `relay/channel/task/sora/` |

**最简起步**：复制 `relay/channel/deepseek/`（仅 adaptor.go + constants.go 两个文件），改包名、ModelList、ChannelName、URL，按需实现 Convert 方法，然后做 4 处注册。
