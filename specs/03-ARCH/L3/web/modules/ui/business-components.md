# 业务复用组件

## 职责

非原子、非布局、非表格的顶层业务复用组件：JSON/HTML/Markdown 编辑与渲染、表单选择器（多选/标签/模型分组/密码/日期时间）、反馈与状态对话框、交互工具（命令面板/配置抽屉/复制/搜索）、展示（长文本/遮罩值/徽章）、主题语言账户切换、Turnstile 校验。

## 契约（开放能力）

- **代码与富文本编辑能力**：json-code-editor（含 utils + 测试）、json-editor、html-content、rich-content、markdown 相关
- **表单选择器能力**：multi-select、tag-input、model-group-selector、password-input、datetime-picker、date-picker
- **反馈与状态能力**：confirm-dialog、risk-acknowledgement-dialog、sign-out-dialog、empty-state、error-state、loading-state、auto-skeleton、coming-soon、notification-popover
- **交互工具能力**：command-menu（命令面板）、config-drawer、copy-button、search、learn-more、skip-to-main、navigation-progress、page-transition、animate-in-view、turnstile
- **展示能力**：long-text/truncated-text、masked-value-display、table-id、group-badge/provider-badge/status-badge、react-icon-by-name
- **主题语言账户切换能力**：theme-switch/theme-quick-switcher、language-switcher、profile-dropdown

## 覆盖代码

`web/src/components/` 根目录（json-code-editor/、model-group-selector/、json-code-editor.tsx、json-editor.tsx、html-content.tsx、rich-content.tsx、multi-select.tsx、tag-input.tsx、password-input.tsx、datetime-picker.tsx、confirm-dialog.tsx、risk-acknowledgement-dialog.tsx、sign-out-dialog.tsx、command-menu.tsx、config-drawer.tsx、copy-button.tsx、search.tsx、long-text.tsx、truncated-text.tsx、masked-value-display.tsx、group-badge.tsx、provider-badge.tsx、status-badge.tsx、theme-switch.tsx、language-switcher.tsx、profile-dropdown.tsx、turnstile.tsx 等）、`web/src/assets/`（logo、clerk-logo、brand-icons/、custom/）、`web/src/styles/`（index.css、theme.css、theme-presets.css）

## 内部子能力

- JSON 编辑器（json-code-editor 含 utils + 测试，可视化 + JSON 双模式）
- 模型分组选择器（model-group-selector，含目录）
- 命令面板（command-menu，Cmd/Ctrl+K 触发）
- 风险确认对话框（risk-acknowledgement-dialog，服务于渠道 status_code_mapping 等风险操作确认）
- 品牌/图标资源（assets/logo、clerk-logo、brand-icons、custom）
- 全局样式与主题（styles/index.css、theme.css、theme-presets.css）

## 依赖（内部逻辑模块）

- [通用 UI 原子组件](ui/ui-primitives.md)
- [主题与偏好 Provider](framework/theme-prefs.md)
- [全局复用 Hook](infra/hooks.md)
- [通用工具库](infra/utils.md)

## 备注

这些组件跨多个 feature 复用，但非原子级（含业务逻辑如模型分组选择、JSON 校验），故单独归为一组而非并入原子组件库。
