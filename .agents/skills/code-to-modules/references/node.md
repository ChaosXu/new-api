# Node/Bun 技术栈规则

适用范围：组件根目录下存在 `package.json`。本文件被 SKILL.md 在识别到 Node/Bun 技术栈时按需读取，提供 Node 专属的**代码理解切入点**。通用概念（逻辑模块定义、判定信号、粒度）见 SKILL.md。

## 核心原则

**源码目录是覆盖代码的粒度，不是模块粒度。** 一个逻辑模块可覆盖多个目录；多个内聚的目录也可归为一个逻辑模块。不要"每目录 = 一模块"。

## 完整性程序（强制，配合 SKILL.md 第 3/12 步）

"通读理解"不能替代枚举。按以下程序确保每个源码目录都被考虑：

1. **枚举所有源码目录**：列出 `src/`（或根）下所有含 `index.{ts,tsx,js}` 的目录；用 `find src -name "index.*" -type f` 辅助。
2. **枚举 workspace**：解析 `package.json.workspaces`（monorepo），枚举每个 workspace 目录。
3. **每个结果必须在「源码覆盖矩阵」占一行**（covered / new-module / dont-list），不得遗漏。`dont-list` 须填一句理由（如"仅类型定义""配置目录"）。

## 代码理解切入点

提炼逻辑模块时，按这些标志判断职责与边界：

| 标志 | 说明 | 用法 |
| --- | --- | --- |
| feature 目录（`src/features/<x>/`） | 一个业务功能域 | 通常一个 feature = 一个逻辑模块；但**相关的多个 feature 可聚合为一个更大的功能域**（如 channels + models + system-settings 聚合为"渠道与模型管理"域） |
| `api.ts` / `types.ts` | feature 的对外契约 | api.ts 的请求函数、types.ts 的 zod schema 是该模块的契约 |
| `index.tsx` + `components/` | feature 的 UI 实现 | 理解 feature 的页面结构 |
| `routes/` | 路由定义 | 路由层整体是一个逻辑模块（"路由层"），不逐路由文件列 |
| `lib/`、`hooks/` | 跨 feature 复用能力 | **每个有独立开放能力与独立依赖图的基础设施组件各为一个逻辑模块**（缓存、限流、HTTP 客户端、校验各列），禁止全部塞进单个"基础设施"模块 |

## Node 特定的归类模式

### 多个相关 feature 聚合为一个功能域（仅示例，不要照抄）

> 以下是某项目的具体聚合示例，**仅作参考，不要照搬**。聚合应基于实际代码的内聚性，而非套用固定的 feature 分组。

23 个 feature 不必各为顶层模块，按业务域聚合（中等粒度）：
- **用户与权限**域：`features/users` + `features/profile` + `features/auth`
- **渠道与模型**域：`features/channels` + `features/models`
- **计费与钱包**域：`features/wallet` + `features/pricing` + `features/redemption-codes` + `features/subscriptions`
- **监控与日志**域：`features/dashboard` + `features/usage-logs` + `features/performance-metrics`
- **系统管理**域：`features/system-settings` + `features/system-info`

聚合后每域下再按需拆 3-5 个逻辑模块（如"用户与权限"域拆：会话鉴权、用户管理、个人资料、OAuth 登录）。

### 同类原子组件归为一个模块

`components/ui/`（60+ shadcn 原子组件）、`components/ai-elements/`（42 个 AI 组件）各归为一个逻辑模块（"通用 UI 原子组件""AI 对话组件"），不逐组件列。

### 复合组件有内部分层的拆子能力

`components/layout/`（含 config/lib/components 三层）、`components/data-table/`（含 core/hooks/toolbar/layout/static 五层）各为一个逻辑模块，内部分层作为"子能力"描述，不拆成多个模块文件。

## 覆盖代码的标注

每个逻辑模块的"覆盖代码"列用目录路径标注（相对组件根），例：
- `features/channels/`、`features/models/`（"渠道与模型管理"域覆盖）
- `components/data-table/`（含 core/hooks/toolbar 等子目录整体）
- `lib/`（工具库整体）

## 排除项

不计入任何模块的代码：`node_modules/`（第三方）、构建产物（`dist/`/`build/`/`out/`）、测试固件、配置目录（`.storybook` 等）。
