# AI 对话调试场

## 职责

面向登录用户的 AI 对话测试场：选择分组与模型、调节推理参数、发起 chat completions 请求并查看流式（SSE）/非流式响应（含 reasoning 思考链）。用于验证渠道与模型可用性、调试 prompt。

## 契约（开放能力）

- **对话补全请求能力**：流式 SSE 与非流式两种，POST 到 `/pg/chat/completions`
- **用户可用模型与分组读取能力**：按分组读取模型（`getUserModels`）、读取分组含 ratio/描述（`getUserGroups`）
- **消息编辑/重生成/删除/复制能力**
- **推理参数调节能力**：temperature/top_p/max_tokens/frequency_penalty/presence_penalty/seed，可逐项开关
- **本地持久化能力**：配置、消息、参数开关存储于 localStorage

## 覆盖代码

`web/src/features/playground/`（index、api、types、constants、components/chat、components/input、components/message、hooks、lib/streaming、lib/message、lib/storage）

## 内部子能力

- 流式请求引擎（use-stream-request 使用 sse.js 创建 SSE 事件源，监听 message/error/readystatechange，`[DONE]` 标记结束，解析 delta.content 与 delta.reasoning_content）
- 请求代际管理（use-chat-handler 用 generation 防竞态、50ms 节流批量 flush 流式块、AbortController 中断、停止生成）
- 三段式布局（PlaygroundChat 消息区、PlaygroundInput 输入区含参数面板、状态管理 hooks）
- 消息处理工具（lib/message 下 10 个：内容解析、reasoning 提取、复制、编辑等）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [AI 对话呈现组件](ui/ai-elements.md)
- [通用工具库](infra/utils.md)
