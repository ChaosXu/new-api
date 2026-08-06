# Node/Bun 技术栈规则

适用范围：组件根目录下存在 `package.json`。本文件被 SKILL.md 在识别到 Node/Bun 技术栈时按需读取，提供 Node 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | `src/` 下含 `*.ts` / `*.js` / `*.tsx` / `*.jsx` 的目录或模块文件。 |
| 导入模块 | `package.json` 的 `dependencies` + `devDependencies`；**剔除** `workspaces` 指向本仓库内部的条目（这些归内部模块）。 |

## 粒度规则

- `src/` 下每个源码目录/模块文件按目录列，列到叶子粒度，不合并、不折叠。
- `node_modules/` **不属于**内部模块（属第三方依赖目录）。

## 排除项（Node 特定补充）

除 SKILL.md 的通用排除项外，Node 还需排除：

- `node_modules/`（第三方依赖目录）。
- 构建产物目录（`dist/` / `build/` / `out/`）。
- 测试固件、配置目录（`__tests__/fixtures`、`.storybook` 等，按通用排除项判定）。
