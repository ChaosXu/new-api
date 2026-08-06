# Node/Bun 技术栈规则

适用范围：组件根目录下存在 `package.json`。本文件被 SKILL.md 在识别到 Node/Bun 技术栈时按需读取，提供 Node 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | `src/` 下含 `*.ts` / `*.js` / `*.tsx` / `*.jsx` 的目录或模块文件。 |
| 导入模块 | `package.json` 的 `dependencies` + `devDependencies`；**剔除** `workspaces` 指向本仓库内部的条目（这些归内部模块）。 |
| 依赖关系 | 各源码文件 `import ... from '...'` 中**指向本组件内部**的路径：`@/` 别名（或 tsconfig paths 配置的内部别名）、以 `./` / `../` 开头的相对路径。剔除指向 `node_modules` 的第三方包名。采集结果填入**每个模块文件**的"直接依赖（内部）"。 |

## 粒度规则

- `src/` 下每个源码目录/模块文件按目录列，列到叶子粒度，不合并、不折叠。
- `node_modules/` **不属于**内部模块（属第三方依赖目录）。

## 排除项（Node 特定补充）

除 SKILL.md 的通用排除项外，Node 还需排除：

- `node_modules/`（第三方依赖目录）。
- 构建产物目录（`dist/` / `build/` / `out/`）。
- 测试固件、配置目录（`__tests__/fixtures`、`.storybook` 等，按通用排除项判定）。

## 同构折叠判定信号（Node 特定）

满足以下信号**之一**的一批目录判为同构，折叠到单文件汇总，不各自独立成文件：

1. **同一 feature 下的同类型子目录**：如 `features/X/lib/`、`features/X/hooks/`、`features/X/components/` 这类只含零星工具函数/Hook/小组件的目录。判定信号 = 同父目录（同一 feature）+ 同类型（lib/hooks/components 之一）+ 导出符号数少（通常 ≤5 个文件）。
2. **路由文件组**：`routes/_authenticated/<页面>/` 下的 `*.tsx` 路由文件，结构同构（都是 TanStack Router 路由定义）。
3. **正向依赖集合高度重合**：一批目录的内部依赖（`@/` 引用）有 ≥80% 共同项。

折叠文件形态：开头注明该 feature/分组下各子目录的共性职责与共性依赖，表列各子目录的差异。典型示例：web 的 `features/playground/lib/` 下 `input/message/options/parameters/state/storage/streaming` 子目录结构同构，折叠汇总。
