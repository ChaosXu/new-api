# 数据表格复合组件

## 职责

基于 TanStack Table 的企业级数据表格方案，支持桌面表格/卡片双视图、列固定/尺寸、分页、过滤、批量操作、骨架/空态。分 core/hooks/toolbar/layout/static 五层，`index.ts` 锁定稳定公共 API。

## 契约（开放能力）

- **TanStack 表格渲染能力**：主表 + 行 + 行动作菜单、可排序列头、单元格（badge/badge-list/truncated）
- **表格状态管理能力**：sorting/filtering/pagination/visibility/sizing/selection/expanded 状态及 row model
- **视图切换能力**：table↔card 视图切换，含 localStorage 持久化
- **工具栏能力**：搜索/过滤容器、分面过滤（faceted-filter）、批量操作栏、列可见性、视图模式切换
- **页面级编排能力**：data-table-page 高阶组件组合 toolbar + 桌面表 + 移动卡片 + 分页 + 批量操作，支持自定义 toolbar、isLoading/isFetching、空态、emptyAction
- **静态轻量表能力**：static-data-table，用于不需 TanStack 状态的本地数组
- **固定列与列尺寸能力**：table-sizing、content-sized-columns、column-pinning、data-table-colgroup
- **防抖列过滤能力**：use-debounced-column-filter

## 覆盖代码

`web/src/components/data-table/`（core/、hooks/、toolbar/、layout/、static/、index.ts）

## 内部子能力

- core 表格原语层：data-table-view、data-table-header/row、column-header、pagination、table-skeleton/empty、单元格、列宽、row-action-menu
- hooks 状态与逻辑层：use-data-table、use-data-table-view-mode、use-debounced-column-filter
- toolbar 控件层：toolbar、faceted-filter、bulk-actions、view-options、view-mode-toggle
- layout 页面级响应式编排层：data-table-page、card-grid/card-row-content/mobile-card-list/card-cell-utils
- static 静态数据轻量表层：static-data-table、static-row-actions、static-data-table-classnames

## 依赖（内部逻辑模块）

- [通用 UI 原子组件](ui/ui-primitives.md)
- [全局复用 Hook](infra/hooks.md)（use-table-url-state、use-table-compact-mode）

## 备注

本模块是最重要的复用件，特性列与动作按约定留在各 feature 目录。DataTablePage 作为高阶编排件被用户/渠道/模型/兑换码/订阅/日志等管理页复用。
