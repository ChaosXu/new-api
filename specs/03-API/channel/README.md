# 渠道管理

路由前缀：`/api/channel`，全部需要 AdminAuth，并按动作细分 RequirePermission 权限位。本目录覆盖渠道的增删改查、批量/标签操作、测试、余额、上游模型、多密钥与上游更新。子资源：[密钥查看](./key/)、[Codex](./codex/)、[Ollama](./ollama/)。

## 权限位说明

渠道资源（`channel`）定义于 `service/authz/resources_channel.go`，共 5 个动作：

| 权限位 | Action | 说明 |
| --- | --- | --- |
| ChannelRead | read | 查看渠道列表/详情（不含密钥） |
| ChannelOperate | operate | 测试、刷新余额、启用/禁用（单个/批量/标签）、检测上游更新 |
| ChannelWrite | write | 编辑非敏感字段（模型、分组、路由）、批量设置标签、应用上游更新 |
| ChannelSensitiveWrite | sensitive_write | 创建渠道、编辑密钥/base_url/override、删除、批量删除、复制、Ollama/Codex 敏感操作 |
| ChannelSecretView | secret_view | 预留：安全验证后查看完整密钥（见 [key](./key/)） |

默认除 ChannelSensitiveWrite 外均授予内置 Admin 角色。

## 端点清单

| 文件 | 方法 | 路径 | 权限 | 用途 |
| --- | --- | --- | --- | --- |
| 渠道列表.md | GET | /api/channel/ | ChannelRead | 分页查询渠道 |
| 搜索渠道.md | GET | /api/channel/search | ChannelRead | 关键字搜索 |
| 获取渠道详情.md | GET | /api/channel/:id | ChannelRead | 单个渠道详情 |
| 渠道模型列表.md | GET | /api/channel/models | ChannelRead | 内置模型列表 |
| 已启用模型列表.md | GET | /api/channel/models_enabled | ChannelRead | 可用模型列表 |
| 渠道操作记录.md | GET | /api/channel/ops | ChannelRead | 全局重试次数等配置 |
| 标签下模型.md | GET | /api/channel/tag/models | ChannelRead | 标签下模型预览 |
| 创建渠道.md | POST | /api/channel/ | ChannelSensitiveWrite | 新建渠道 |
| 更新渠道.md | PUT | /api/channel/ | ChannelWrite | 更新渠道 |
| 删除渠道.md | DELETE | /api/channel/:id | ChannelSensitiveWrite | 删除单个 |
| 批量删除渠道.md | POST | /api/channel/batch | ChannelSensitiveWrite | 批量删除 |
| 复制渠道.md | POST | /api/channel/copy/:id | ChannelSensitiveWrite | 克隆渠道 |
| 删除已禁用渠道.md | DELETE | /api/channel/disabled | ChannelSensitiveWrite | 删除全部禁用渠道 |
| 更新渠道状态.md | POST | /api/channel/:id/status | ChannelOperate | 启用/禁用单个 |
| 批量更新状态.md | POST | /api/channel/status/batch | ChannelOperate | 批量启用/禁用 |
| 按标签禁用.md | POST | /api/channel/tag/disabled | ChannelOperate | 禁用标签下全部 |
| 按标签启用.md | POST | /api/channel/tag/enabled | ChannelOperate | 启用标签下全部 |
| 编辑渠道标签.md | PUT | /api/channel/tag | ChannelWrite | 按标签批量编辑 |
| 批量设置标签.md | POST | /api/channel/batch/tag | ChannelWrite | 设置标签 |
| 修复渠道能力.md | POST | /api/channel/fix | ChannelOperate | 修复 abilities 表 |
| 测试所有渠道.md | GET | /api/channel/test | ChannelOperate | 触发全渠道测试任务 |
| 测试指定渠道.md | GET | /api/channel/test/:id | ChannelOperate | 同步测试单个 |
| 更新所有余额.md | GET | /api/channel/update_balance | ChannelOperate | 更新全部余额 |
| 更新指定余额.md | GET | /api/channel/update_balance/:id | ChannelOperate | 更新单个余额 |
| 拉取上游模型.md | GET | /api/channel/fetch_models/:id | ChannelOperate | 拉取已保存渠道上游模型 |
| 批量拉取模型.md | POST | /api/channel/fetch_models | ChannelSensitiveWrite | 按临时输入预览模型 |
| 多密钥管理.md | POST | /api/channel/multi_key/manage | ChannelOperate | 多密钥状态/启停/删除 |
| 应用上游更新.md | POST | /api/channel/upstream_updates/apply | ChannelWrite | 应用单个渠道变更 |
| 应用所有上游更新.md | POST | /api/channel/upstream_updates/apply_all | ChannelWrite | 批量应用变更 |
| 检测上游更新.md | POST | /api/channel/upstream_updates/detect | ChannelOperate | 检测单个渠道变更 |
| 检测所有上游更新.md | POST | /api/channel/upstream_updates/detect_all | ChannelOperate | 入队全量检测任务 |

## model.Channel 数据模型

来源：`model/channel.go`。

| 字段 | JSON | 类型 | 说明 |
| --- | --- | --- | --- |
| Id | id | int | 渠道 ID |
| Type | type | int | 渠道类型 |
| Key | key | string | 密钥（列表/详情脱敏） |
| OpenAIOrganization | openai_organization | *string | OpenAI 组织 |
| TestModel | test_model | *string | 测试模型 |
| Status | status | int | 状态：1启用/2手动禁用/3自动禁用 |
| Name | name | string | 名称 |
| Weight | weight | *uint | 权重 |
| CreatedTime | created_time | int64 | 创建时间 |
| TestTime | test_time | int64 | 上次测试时间 |
| ResponseTime | response_time | int | 响应耗时（ms） |
| BaseURL | base_url | *string | 基础地址 |
| Other | other | string | 其他（如 VertexAI 区域） |
| Balance | balance | float64 | 余额（USD） |
| BalanceUpdatedTime | balance_updated_time | int64 | 余额更新时间 |
| Models | models | string | 模型列表（逗号分隔） |
| Group | group | string | 分组 |
| UsedQuota | used_quota | int64 | 已用额度 |
| ModelMapping | model_mapping | *string | 模型映射 JSON |
| StatusCodeMapping | status_code_mapping | *string | 状态码映射 |
| Priority | priority | *int64 | 优先级 |
| AutoBan | auto_ban | *int | 自动禁用开关 |
| OtherInfo | other_info | string | 其他信息 |
| Tag | tag | *string | 标签 |
| Setting | setting | *string | 渠道额外设置 JSON |
| ParamOverride | param_override | *string | 参数覆盖 JSON |
| HeaderOverride | header_override | *string | 请求头覆盖 JSON |
| Remark | remark | *string | 备注（最长 255） |
| ChannelInfo | channel_info | ChannelInfo | 多密钥等结构化信息 |
| OtherSettings | settings | string | 其他设置（Azure 版本等） |

### ChannelInfo 子结构

| 字段 | JSON | 类型 | 说明 |
| --- | --- | --- | --- |
| IsMultiKey | is_multi_key | bool | 是否多密钥 |
| MultiKeySize | multi_key_size | int | 多密钥数量 |
| MultiKeyStatusList | multi_key_status_list | map[int]int | 密钥状态（1启用/2手动禁用/3自动禁用） |
| MultiKeyDisabledReason | multi_key_disabled_reason | map[int]string | 禁用原因 |
| MultiKeyDisabledTime | multi_key_disabled_time | map[int]int64 | 禁用时间 |
| MultiKeyPollingIndex | multi_key_polling_index | int | 轮询索引 |
| MultiKeyMode | multi_key_mode | string | 多密钥模式 |
