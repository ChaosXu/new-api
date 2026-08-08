# 协议转换

## 职责

在各中继协议（OpenAI Chat/Claude Messages/Gemini/OpenAI Responses/Rerank）之间互转请求与响应的独立框架。作为纯库子 module 存在，宿主通过注册表按 RelayFormat 查找转换器。

## 契约（开放能力）

- **跨中继协议互转能力**：在 openai/claude/gemini/responses/rerank 五种 RelayFormat 之间转换请求与响应。
- **按格式查找转换器的能力**：通过注册表按 RelayFormat 选取对应请求/响应/文本转换器。
- **转换上下文契约能力**：以 Meta 接口向转换器提供渠道/模型/计费等上下文。

## 覆盖代码

`relaykit/`（独立 go.mod 的子 module）、`relaykit/types/`（RelayFormat 等类型）、`relaykit/dto/`（各协议 DTO）、`relaykit/relayconvert/`（转换框架 + internal/ 下各协议转换器：claude_messages/gemini_chat/oai_chat/oai_responses）、`relaykit/reasonmap/`（停止原因映射）、`service/convert.go`（OpenAI↔Claude/Gemini 响应互转的 service 侧薄封装）、`service/request_converter.go`（`ConvertRequest` 注册 gin 上下文的媒体解析器后委托 relayconvert）、`service/openai_chat_responses_compat.go`（ChatCompletions↔Responses 请求/响应互转的 service 侧薄封装）

> 注：上述三个 `service/*.go` 是根模块调用 relaykit 的桥接封装（relaykit 不得反向依赖根模块，故桥接代码在 service 侧）。协议转换的本体逻辑在 `relaykit/relayconvert/`，这些 service 文件仅转发调用并补充 gin 上下文/媒体解析。

## 内部子能力

- 类型与 DTO：各协议的请求/响应结构定义
- 转换框架：注册表 + 各协议互转转换器（internal/ 下）
- 推理内容处理：reasoning 后缀拼接/分离、stop_reason 映射

## 依赖（内部逻辑模块）

- 无（纯库，**不得依赖根模块**——relaykit 独立 build 约束）

## 项目约束

- relaykit 有独立 `go.mod`，必须独立可 build（`cd relaykit && GOWORK=off go build ./...`），**不得 import 根模块任何包**。
