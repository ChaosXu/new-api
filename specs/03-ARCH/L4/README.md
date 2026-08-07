# L4 — 写代码说明书（Code Level）

## 定位

L1/L2/L3 是**描述层**（系统/组件/模块"是什么"）。L4 是**生成层**（"怎么写"）：给 AI 的图纸，让 AI 据此生成贴合 new-api 现有规范的代码。

每份 L4 说明书聚焦"如何写某类代码"，包含 AI 生成代码最需要的四要素：

| 要素 | 内容 | 价值 |
| --- | --- | --- |
| **代码范式** | 该类代码的组织方式（骨架怎么搭） | AI 知道目录结构、文件分工、调用模式 |
| **关键契约** | 核心 interface/struct/函数签名 | AI 知道接口长什么样，不用猜 |
| **项目约束** | AGENTS.md 里适用的硬约束 | AI 写的代码符合项目铁律，不踩雷 |
| **样板指针** | 1-2 个代表性文件路径 | AI 有具体参考，可仿写 |

> L3 不重复承载这些信息。L3 是"逻辑模块路由"（职责+依赖+覆盖代码），L4 是"写代码图纸"。从 L3 的逻辑模块名通过下面的映射表找到对应 L4 说明书。

## 目录结构

```
L4/
├── README.md                       # 本文件
├── conventions/                    # 跨模块复用的范式（多模块共用一份）
│   ├── backend-relay-adaptor.md    # 如何写新渠道适配器（渠道适配框架共用）
│   └── frontend-feature.md         # 如何写新 feature（web 各 feature 共用）
└── <组件名>/                       # 该组件特定模块的专属说明书（按需扩充）
    ├── new-api/                    # 如 relay-core.md、data-access.md、api.md
    └── web/                        # 如 feature-list-page.md、data-table.md
```

**conventions vs 组件专属**：一类代码被多个模块共用（如渠道适配器、web feature），写进 `conventions/`；某个模块范式独特（如数据访问层的跨库兼容），写进 `<组件名>/<模块>.md`。

## L3 逻辑模块 → L4 说明书 映射

> 因 L3 不含 L4 链接，从此表导航。L3 模块是**逻辑模块**（从代码职责提炼归类，覆盖代码路径见各模块文件），不是目录镜像。

| 要写的代码 | 涉及的 L3 逻辑模块 | L4 说明书 |
| --- | --- | --- |
| 新增 relay 渠道适配器（同步/异步） | L3/new-api/relay/relay-adaptor.md（渠道适配框架） | [conventions/backend-relay-adaptor.md](conventions/backend-relay-adaptor.md) |
| 改中继编排/上下文/转换 | L3/new-api/relay/（编排入口、中继上下文、协议转换、中继辅助） | 待补：new-api/relay-core.md |
| 改计费结算链路 | L3/new-api/service/billing.md（计费结算）+ L3/new-api/pkg/billing-expr.md（表达式引擎） | 待补：conventions/backend-billing.md |
| 改数据访问层（GORM/跨库） | L3/new-api/data/data-access.md（实体数据访问） | 待补：new-api/data-access.md |
| 改 HTTP 控制器/中间件 | L3/new-api/api/（控制器、中间件） | 待补：new-api/api.md |
| 改鉴权 | L3/new-api/auth/（会话鉴权、OAuth、Passkey、授权） | 待补：new-api/auth.md |
| 新增 web feature（业务页面） | L3/web/features/*（待按新方法论重做） | [conventions/frontend-feature.md](conventions/frontend-feature.md) |

（标"待补"的说明书本轮未做，后续按需补充。L3 模块名若因后续迭代调整，以 `L3/<组件>/modules.md` 索引为准。）

## 生成代码的流程

当用户要 AI 写代码时，按此流程组织提示词：

1. **L3 定位**：从 `L3/<组件>/modules.md` 索引找到功能涉及的**逻辑模块** + 它依赖哪些其他逻辑模块（知道改哪、边界在哪）。读对应模块文件确认职责与覆盖代码。
2. **L4 取范式**：按上方映射表找到 L4 说明书，读范式 + 关键契约 + 项目约束。
3. **读样板**：按 L4 的"样板指针"读 1-2 个真实代码文件，看具体写法。
4. **生成**：在约束下仿写。**必须同时遵守 AGENTS.md**（L4 只摘录与该类代码直接相关的约束，AGENTS.md 是完整规则源）。

### 提示词模板

```
你要在 <逻辑模块> 实现 <功能>。

步骤：
1. 读 L3/<组件>/modules.md，定位 <逻辑模块> 的职责、覆盖代码与依赖边界。
2. 读 L4 说明书：<L4说明书路径> + 相关 conventions。
3. 读样板文件：<样板指针列出的文件>。
4. 按范式与约束生成代码。所有 JSON 操作用 common.*；数据库锁用 lockForUpdate；
   前端文案用 t('English key')；遵守 AGENTS.md 全部规则。
```
