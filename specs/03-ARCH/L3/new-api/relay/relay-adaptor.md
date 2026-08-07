# 渠道适配框架

- **职责**：定义统一的渠道适配器接口（Adaptor/TaskAdaptor），并承载所有上游 AI 提供商的适配器实现。把不同提供商的协议差异收敛到统一接口后，供编排入口调用。
- **覆盖代码**：`relay/channel/`（接口定义）、`relay/channel/*/`（39 个同步适配器：openai/claude/gemini/aws/ali 等）、`relay/channel/task/*/`（11 个异步任务适配器：kling/sora/vidu 等）、`relay/relay_adaptor.go`（按 APIType 分发到具体适配器）
- **关键契约**：`Adaptor` 接口（15 方法，含 ConvertOpenAIRequest/DoResponse 等）、`TaskAdaptor` 接口（含 EstimateBilling 计费）

## 内部子能力

- 同步适配器（39 个）：chat/embedding/image/audio/rerank/responses 等同步中继，实现 `Adaptor`
- 异步任务适配器（11 个）：图像/视频/音频生成，实现 `TaskAdaptor`
- 协议复用：openai/claude/gemini 作为基础适配器被其他兼容厂商复用（如 deepseek 复用 openai+claude）

## 依赖（内部逻辑模块）

- 中继上下文（用 RelayInfo）
- 协议转换（部分适配器复用 relaykit 的转换逻辑）
- 业务逻辑（渠道选择、令牌计数等）
- 配置（模型适配参数、运营设置）
