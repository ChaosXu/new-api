# 渠道适配框架

## 职责

定义统一的渠道适配器接口，并承载所有上游 AI 提供商的适配器实现。把不同提供商的协议差异收敛到统一接口后，供编排入口调用。

## 契约（开放能力）

- **统一的上游协议适配能力**：用单一 Adaptor 接口抽象任一提供商的请求转换/上游调用/响应处理（含 OpenAI 协议互转、流式响应处理等）。
- **异步任务适配能力**：用 TaskAdaptor 接口抽象图像/视频/音频生成的提交/轮询/计费。
- **按 API 类型分发到具体适配器的能力**：依据渠道的 APIType 选出对应适配器实例。

## 覆盖代码

`server/internal/relay/channel/`（接口定义）、`server/internal/relay/channel/*/`（39 个同步适配器：openai/claude/gemini/aws/ali 等）、`server/internal/relay/channel/task/*/`（11 个异步任务适配器：kling/sora/vidu 等）、`server/internal/relay/relay_adaptor.go`（按 APIType 分发到具体适配器）

## 内部子能力

- 同步适配器（39 个）：chat/embedding/image/audio/rerank/responses 等同步中继，实现 `Adaptor`
- 异步任务适配器（11 个）：图像/视频/音频生成，实现 `TaskAdaptor`
- 协议复用：openai/claude/gemini 作为基础适配器被其他兼容厂商复用（如 deepseek 复用 openai+claude）

## 依赖（内部逻辑模块）

- 中继上下文（用 RelayInfo）
- 协议转换（部分适配器复用 server/relaykit 的转换逻辑）
- 业务逻辑（渠道选择、令牌计数等）
- 配置（模型适配参数、运营设置）
