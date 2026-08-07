# 协议转换

- **职责**：在各中继协议（OpenAI Chat/Claude Messages/Gemini/OpenAI Responses/Rerank）之间互转请求与响应的独立框架。作为纯库子 module 存在，宿主通过注册表按 RelayFormat 查找转换器。
- **覆盖代码**：`relaykit/`（独立 go.mod 的子 module）、`relaykit/types/`（RelayFormat 等类型）、`relaykit/dto/`（各协议 DTO）、`relaykit/relayconvert/`（转换框架 + internal/ 下各协议转换器：claude_messages/gemini_chat/oai_chat/oai_responses）、`relaykit/reasonmap/`（停止原因映射）
- **关键契约**：`RelayFormat` 类型（openai/claude/gemini/responses/rerank）、`Meta` interface（转换上下文契约）、request/response/text-converter 注册表

## 内部子能力

- 类型与 DTO：各协议的请求/响应结构定义
- 转换框架：注册表 + 各协议互转转换器（internal/ 下）
- 推理内容处理：reasoning 后缀拼接/分离、stop_reason 映射

## 依赖（内部逻辑模块）

- 无（纯库，**不得依赖根模块**——relaykit 独立 build 约束）

## 项目约束

- relaykit 有独立 `go.mod`，必须独立可 build（`cd relaykit && GOWORK=off go build ./...`），**不得 import 根模块任何包**。
