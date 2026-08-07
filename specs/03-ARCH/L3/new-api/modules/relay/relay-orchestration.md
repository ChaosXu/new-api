# 编排入口

- **职责**：中继转发的总入口与编排层。接收各类中继请求（chat/embedding/image/audio/rerank/responses 等），按渠道类型分发到对应适配器，串联请求转换→上游调用→响应处理→计费的完整链路。
- **覆盖代码**：`relay/`（根包，relay.go 等编排主文件）、`relay/constant/`（RelayMode 中继模式枚举）、`relay/common_handler/`（跨渠道通用处理器，如 rerank）
- **关键契约**：`RelayMode` 枚举（Chat/Embeddings/Images/Audio/Rerank/Responses 等中继模式）、`GetAdaptor(apiType)` 分发函数

## 依赖（内部逻辑模块）

- 渠道适配框架（分发到适配器）
- 中继上下文（用 RelayInfo 贯穿链路）
- 中继辅助（计费/定价/流式/校验）
- 业务逻辑（渠道选择、计费结算）
