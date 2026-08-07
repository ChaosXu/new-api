# AI 对话呈现组件

## 职责

复刻 shadcn "ai-elements" 风格的对话 UI 原语，负责 LLM 响应的结构化渲染、流式呈现、推理链与工具调用展示、引用与来源、画布/工作流可视化。

## 契约（开放能力）

- **对话流编排能力**：conversation（含自动滚动 StickToBottom）、message、response、prompt-input、suggestion、actions、controls、toolbar、panel
- **响应内容解析与渲染能力**：response-renderer + 分类型子渲染器（blocks/alert/details/footnotes/image/inline/table），配合 response-types、response-node-guards、response-content、inline-citation
- **推理与思考链展示能力**：reasoning、chain-of-thought、task、plan、loader、shimmer
- **工具调用展示能力**：tool、confirmation、context、sources、image、code-block、web-preview、open-in-chat
- **工作流与图可视化能力**：canvas、node、edge、branch、connection、queue、artifact

## 覆盖代码

`web/src/components/ai-elements/`

## 内部子能力

- 响应渲染引擎（核心复杂度）：response-renderer.tsx 驱动分类型子渲染器，处理 markdown 块、表格、图片、行内、脚注、详情、告警
- 对话框架组件：conversation（自动滚动）、message、prompt-input、actions、toolbar
- 推理链与工具调用展示组件

## 依赖（内部逻辑模块）

- [通用 UI 原子组件](ui/ui-primitives.md)
- [通用工具库](infra/utils.md)（cn、markdown）

## 备注

本模块由 AI 对话调试场（playground）消费，提供 LLM 响应的结构化呈现能力。无单一 barrel index，按文件直引。
