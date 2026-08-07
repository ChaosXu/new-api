# 渠道管理

## 职责

管理接入中转网关的上游 AI 供应商渠道（OpenAI/Anthropic/Azure/Gemini/AWS/Ollama 等 50+ 类型）全生命周期：创建、配置、测试、批量运维、密钥管理、模型映射。是整个前端最复杂的功能模块。

## 契约（开放能力）

- **渠道列表与检索能力**：按状态/类型/分组/标签/关键字检索、排序、分页
- **渠道 CRUD 能力**：创建/更新/删除，支持单密钥、批量、多密钥合一三种模式
- **渠道状态启停能力**：单条与批量启停
- **渠道连通性测试能力**：单模型/批量并发测试（并发 5、批间延迟 100ms），endpoint 类型选择、流式开关、失败模型一键删除
- **余额查询与刷新能力**：单渠道余额更新、全渠道批量测试
- **上游模型抓取能力**：从上游拉取可用模型列表
- **渠道复制克隆能力**
- **渠道能力修复能力**（fixChannelAbilities）与禁用渠道清理
- **渠道密钥读取能力**：需 2FA/Passkey 二次验证
- **多密钥管理能力**：get_key_status/enable/disable/delete/enable_all/disable_all/delete_disabled
- **标签批量操作能力**：按标签启用/禁用/编辑
- **Ollama 模型管理能力**：删除 Ollama 模型、查询版本
- **Codex 渠道专属能力**：凭证刷新、用量查询、额度查询、用量重置

## 覆盖代码

`web/src/features/channels/`（index、api、types、constants、components、drawers、dialogs、hooks、lib）

## 内部子能力

- 列表表格（ChannelsTable + 重试次数徽章）
- 编辑抽屉（channel-mutate-drawer，约 4870 行，向导式四大分区：基本信息、凭证、模型与分组、高级设置；高级设置含路由策略、内部备注、覆盖规则、渠道额外设置、字段透传、上游模型检测）
- 测试对话框（channel-test-dialog：并发测试、endpoint 选择、流式、失败删除）
- 模型映射编辑器（可视化表格 + JSON 双模式、source/target 联想、重复检测）
- 16 个对话框（balance-query、fetch-models、ollama-models、copy-channel、multi-key-manage、tag-batch-edit、advanced-custom-editor、param-override-editor、status-code-risk、missing-models-confirmation、codex-usage 等）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [敏感操作二次验证](auth/secure-verification.md)（查看渠道密钥）
- [数据表格复合组件](ui/data-table.md)
- [模型目录管理](admin-channels/models.md)（模型映射、上游抓取）

## 项目约束（若有）

渠道密钥读取受 `channel.key.read` 作用域的敏感操作二次验证保护（AGENTS.md 安全要求）。
