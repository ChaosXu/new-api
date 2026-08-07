# 全局复用 Hook

## 职责

跨页面复用的 React hooks，封装副作用、状态派生与 UI 交互模式：系统配置拉取、通知联动、侧边栏导航装配、权限判定、表格 URL 状态、对话框/命令面板/剪贴板交互、防抖/倒计时/最小加载时长、响应式断点。

## 契约（开放能力）

- **系统配置拉取能力**：自动拉取并应用系统配置（名称/logo/footer/货币），缓存优先同步到 store
- **通知联动能力**：拉取 Notice 公告、计算已读/未读、内容哈希去重，与通知 store 联动
- **侧边栏导航装配能力**：侧边栏模块配置（管理员/用户层合并）、导航项数据装配、当前路由钻入视图解析、顶部导航链接派生
- **权限判定能力**：管理员身份判定、用户显示信息（角色标签等）格式化
- **表格状态能力**：表格分页/筛选/排序的 URL 同步与持久化、按表 key 的紧凑模式跨标签页同步
- **UI 交互能力**：受控对话框状态、命令面板触发、隐藏功能多次点击解锁、剪贴板复制 + toast 反馈
- **时序与异步能力**：值防抖、验证码倒计时、最小骨架屏展示时长防闪烁
- **响应式能力**：通用媒体查询、移动端 768px 断点判定

## 覆盖代码

`web/src/hooks/`（use-system-config、use-status、use-notifications、use-sidebar-config、use-sidebar-data、use-sidebar-view、use-top-nav-links、use-admin、use-user-display、use-table-url-state、use-table-compact-mode、use-dialog、use-search、use-hidden-click-unlock、use-copy-to-clipboard、use-debounce、use-countdown、use-minimum-loading-time、use-media-query、use-mobile）

## 依赖（内部逻辑模块）

- [全局状态与系统配置缓存](infra/global-state.md)
- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [主题与偏好 Provider](framework/theme-prefs.md)
