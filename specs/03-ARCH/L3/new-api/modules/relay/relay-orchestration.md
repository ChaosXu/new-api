# 编排入口

## 职责

中继转发的总入口与编排层。接收各类中继请求（chat/embedding/image/audio/rerank/responses 等），按渠道类型分发到对应适配器，串联请求转换→上游调用→响应处理→计费的完整链路。

## 契约（开放能力）

- **中继模式识别能力**：按请求路径/参数识别中继模式（Chat/Embeddings/Images/Audio/Rerank/Responses 等）。
- **按渠道类型分发到适配器的能力**：依据 API 类型把请求交给具体渠道适配器。
- **全链路串联能力**：编排请求转换→上游调用→响应处理→计费的完整流程。

## 覆盖代码

`relay/`（根包，relay.go 等编排主文件）、`relay/constant/`（RelayMode 中继模式枚举）、`relay/common_handler/`（跨渠道通用处理器，如 rerank）

## 依赖（内部逻辑模块）

- 渠道适配框架（分发到适配器）
- 中继上下文（用 RelayInfo 贯穿链路）
- 中继辅助（计费/定价/流式/校验）
- 业务逻辑（渠道选择、计费结算）
