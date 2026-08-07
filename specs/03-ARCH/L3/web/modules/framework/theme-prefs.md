# 主题与偏好 Provider

## 职责

跨组件树注入用户偏好与 UI 状态（主题、主题精细化定制、字体、文字方向、侧边栏布局、命令面板），所有偏好以 Cookie 持久化，通过 DOM 属性/class 驱动 CSS 变量级联。

## 契约（开放能力）

- **明暗主题能力**：读取/设置/重置 light/dark/system 主题，写入 `<html>` class 并监听系统偏好变化
- **主题精细化定制能力**：按轴设置预设、字体族、圆角、缩放、内容布局，通过 `<body>` 的 `data-*` 属性驱动 CSS 变量；支持整体重置
- **应用字体能力**：在 inter/manrope/system 间切换并写入 `<html>` 的 `font-*` class
- **文字方向能力**：管理 LTR/RTL 方向，写入 `<html dir>` 并包裹 base-ui DirectionProvider
- **侧边栏布局形态能力**：读取/设置 collapsible 模式与 variant 变体
- **全局命令面板能力**：控制 Cmd/Ctrl+K 命令面板开合并挂载 CommandMenu

## 覆盖代码

`web/src/context/`（theme-provider、theme-customization-provider、font-provider、direction-provider、layout-provider、search-provider）、`web/src/lib/theme-customization.ts`、`web/src/lib/theme-radius.ts`、`web/src/lib/motion.ts`、`web/src/lib/use-controllable-state.ts`

## 依赖（内部逻辑模块）

- [应用引导](framework/app-bootstrap.md)
- [全局状态与系统配置缓存](infra/global-state.md)
- [通用 UI 原子组件](ui/ui-primitives.md)
