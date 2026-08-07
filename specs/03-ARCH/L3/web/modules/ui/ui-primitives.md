# 通用 UI 原子组件

## 职责

基于 Radix + Tailwind 的纯展示/输入原子组件库（约 62 个），无业务逻辑，提供设计系统统一基座。

## 契约（开放能力）

- **表单输入能力**：input、textarea、select、native-select、checkbox、radio-group、switch、slider、toggle/toggle-group、combobox/combobox-input、input-otp、input-group、label、field、form
- **反馈与状态能力**：alert、alert-dialog、sonner(toast)、progress、spinner、skeleton、empty、tooltip、badge/icon-badge、titled-card
- **布局容器能力**：card、separator、scroll-area、resizable、aspect-ratio、tabs、collapsible、accordion
- **导航与菜单能力**：navigation-menu、menubar、breadcrumb、pagination、sidebar、command(命令面板)
- **叠加层能力**：dialog、drawer、sheet、popover、hover-card、context-menu、dropdown-menu
- **复合与富展示能力**：carousel、chart、avatar、table(裸 table 原语)、markdown、kbd、item、button-group、button、direction

## 覆盖代码

`web/src/components/ui/`

## 依赖（内部逻辑模块）

- [主题与偏好 Provider](framework/theme-prefs.md)
- [通用工具库](infra/utils.md)（cn 类名合并）

## 备注

本模块是 shadcn/ui 风格的原子组件库，被全站业务组件消费。同类原子组件归为一个模块，不逐组件列。
