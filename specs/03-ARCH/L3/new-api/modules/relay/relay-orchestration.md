# 编排入口

## 职责

中继转发的总入口与编排层。接收各类中继请求（chat/embedding/image/audio/rerank/responses 等），按渠道类型分发到对应适配器，串联请求转换→上游调用→响应处理→计费的完整链路。

## 契约（开放能力）

- **中继模式识别能力**：按请求路径/参数识别中继模式（Chat/Embeddings/Images/Audio/Rerank/Responses 等）。
- **按渠道类型分发到适配器的能力**：依据 API 类型把请求交给具体渠道适配器。
- **全链路串联能力**：编排请求转换→上游调用→响应处理→计费的完整流程。
- **WebSocket 中继能力**：以 `WssHelper` 处理 WebSocket 协议的中继转发（如实时任务进度通道）。
- **AlphaSearch 中继能力**：以 `AlphaSearchHelper` 处理带计费的网页搜索中继路径。
- **Chat↔Responses 升级策略能力**：按 host 设置与模型正则判定是否将 ChatCompletions 请求升级走 Responses 协议（`server/internal/service/openai_chat_responses_mode.go`）。

## 覆盖代码

`server/internal/relay/`（根包编排主文件：`compatible_handler.go` 的 `TextHelper`、`claude_handler.go`、`gemini_handler.go`、`embedding_handler.go`、`image_handler.go`、`audio_handler.go`、`responses_handler.go`、`rerank_handler.go`、`mjproxy_handler.go`、`chat_completions_via_responses.go`、`alpha_search_handler.go` 的 `AlphaSearchHelper`、`websocket.go` 的 `WssHelper`、`relay_task.go`、`param_override_error.go`、`relay_adaptor.go` 的 `GetAdaptor`/`GetTaskAdaptor`）、`server/internal/relay/constant/`（RelayMode 中继模式枚举）、`server/internal/relay/common_handler/`（跨渠道通用处理器，如 rerank）、`server/internal/service/openai_chat_responses_mode.go`（Chat→Responses 升级判定，host 路由逻辑）

## 依赖（内部逻辑模块）

- 渠道适配框架（分发到适配器）
- 中继上下文（用 RelayInfo 贯穿链路）
- 中继辅助（计费/定价/流式/校验）
- 业务逻辑（渠道选择、计费结算）
