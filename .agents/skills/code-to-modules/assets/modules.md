# <组件名> 模块索引

<!--
本模板由 code-to-modules skill 使用。
本文件是该组件全部**逻辑模块**与**业务流程**的可点击索引。模块从代码职责提炼归类，不与源码目录 1:1 对应。
填写规则：
- 目标组件取自 specs/03-ARCH/L2/components.md 的"组件名"列。
- 先列"关键流程"（flows/），再列"内部模块"（modules/）。
- 模块名用职责名（如"渠道适配框架"），不是目录名。
- 覆盖代码列简写（如 relay/channel/、relaykit/），详情见模块文件。
- 删除所有 HTML 注释后再交付。
-->

## 关键流程（模块间动态协作）

<!-- 静态模块卡描述"是什么"；流程文档描述"一个请求/场景怎么在模块间流转"。跨模块流程放在 flows/。
   分两类列：请求驱动流程（HTTP 入口）与后台自动流程（main/启动入口，无 HTTP）。
   L3 级别（跨多模块协作、有状态流转）才列；纯 CRUD 不单独成流程。若无流程，删除本节。 -->

**请求驱动流程**（HTTP 入口）：

| 场景 | 流程文档 |
| --- | --- |
| <!-- 同步中继 --> | <!-- [flows/sync-relay.md](flows/sync-relay.md) --> |

**后台自动流程**（启动入口，无 HTTP）：

| 场景 | 流程文档 |
| --- | --- |
| <!-- 后台自动维护任务 --> | <!-- [flows/background-tasks.md](flows/background-tasks.md) --> |

## 1. 内部模块（逻辑模块）

<!-- 按功能域分组。每个功能域一个三级标题。 -->

### <功能域名，如：中继转发> (`<英文短目录，如 relay>`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| <!-- 渠道适配框架 --> | <!-- 实现统一 Adaptor 接口的渠道适配层 --> | <!-- relay/channel/、relay/channel/* --> | <!-- [channel-adaptor.md](relay/channel-adaptor.md) --> |
| <!-- 中继上下文 --> | <!-- 一次中继全链路的状态/计费容器 --> | <!-- relay/common/ --> | <!-- [relay-context.md](relay/relay-context.md) --> |

### <功能域名，如：鉴权> (`<英文短目录，如 auth>`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| <!-- 会话与令牌鉴权 --> | <!-- HTTP 请求的会话/Token 鉴权 --> | <!-- middleware/(部分)、service/authz/ --> | <!-- [session-auth.md](auth/session-auth.md) --> |
