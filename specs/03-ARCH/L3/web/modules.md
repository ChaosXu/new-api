# web

## 1. 内部模块

### 应用入口与路由装配

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| 应用入口 | `web/src/main.tsx` | React 应用引导：装配 RouterProvider、QueryClient、主题/字体/方向 Provider，初始化构建元数据与前端缓存 |
| 路由树（生成产物） | `web/src/routeTree.gen.ts` | TanStack Router 自动生成的路由树聚合文件 |
| 根路由 | `web/src/routes/__root.tsx` | 全局根路由：布局壳、Outlet 与全局 Provider 挂载 |
| 公共首页路由 | `web/src/routes/index.tsx` | 落地首页路由入口 |
| 认证路由组 | `web/src/routes/(auth)/` | 未登录可访问路由分组：sign-in/sign-up/otp/forgot-password/reset/oauth 及其 route.tsx |
| 认证路由组-用户 | `web/src/routes/(auth)/user/` | 认证流程下的用户相关子路由 |
| 错误页路由组 | `web/src/routes/(errors)/` | 401/403/404/500/503 状态页路由分组 |
| 认证后路由组 | `web/src/routes/_authenticated/` | 需登录的路由分组壳（route.tsx）与各业务页面路由 |
| 认证后路由-渠道 | `web/src/routes/_authenticated/channels/` | 渠道管理页面路由 |
| 认证后路由-聊天 | `web/src/routes/_authenticated/chat/` | 客服聊天页面路由 |
| 认证后路由-chat2link | `web/src/routes/_authenticated/chat2link.tsx` | chat2link 客服跳转路由 |
| 认证后路由-仪表盘 | `web/src/routes/_authenticated/dashboard/` | 数据仪表盘页面路由 |
| 认证后路由-错误页 | `web/src/routes/_authenticated/errors/` | 认证后区域内的错误状态页路由 |
| 认证后路由-令牌 | `web/src/routes/_authenticated/keys/` | API 令牌管理页面路由 |
| 认证后路由-模型 | `web/src/routes/_authenticated/models/` | 模型管理页面路由 |
| 认证后路由-Playground | `web/src/routes/_authenticated/playground/` | AI 对话调试场页面路由 |
| 认证后路由-个人资料 | `web/src/routes/_authenticated/profile/` | 用户个人中心页面路由 |
| 认证后路由-兑换码 | `web/src/routes/_authenticated/redemption-codes/` | 兑换码管理页面路由 |
| 认证后路由-订阅 | `web/src/routes/_authenticated/subscriptions/` | 订阅管理页面路由 |
| 认证后路由-系统信息 | `web/src/routes/_authenticated/system-info/` | 系统信息页面路由 |
| 认证后路由-系统设置 | `web/src/routes/_authenticated/system-settings/` | 系统设置页面路由及各分区子路由（auth/billing/content/models/operations/security/site） |
| 认证后路由-用量日志 | `web/src/routes/_authenticated/usage-logs/` | 用量日志页面路由 |
| 认证后路由-用户 | `web/src/routes/_authenticated/users/` | 用户管理页面路由 |
| 认证后路由-钱包 | `web/src/routes/_authenticated/wallet/` | 钱包页面路由 |
| 关于页路由 | `web/src/routes/about/` | 关于页面路由 |
| OAuth 路由 | `web/src/routes/oauth/` | OAuth 回调/绑定页面路由 |
| 定价路由 | `web/src/routes/pricing/` | 定价页面路由及其 `$modelId` 模型详情路由 |
| 排行榜路由 | `web/src/routes/rankings/` | 排行榜页面路由 |
| 初始化向导路由 | `web/src/routes/setup/` | 首次部署初始化向导路由 |
| 公开法律页路由 | `web/src/routes/privacy-policy.tsx`、`web/src/routes/user-agreement.tsx` | 隐私政策与用户协议公开页路由 |

### 基础设施层

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| 工具库 | `web/src/lib/` | 项目级工具函数：HTTP 客户端（http-client/api）、权限（admin-permissions/roles）、会话（auth-session）、缓存（frontend-cache）、错误处理（handle-server-error/server-error-message）、主题（theme-customization/theme-radius/colors）、时间（dayjs/time）、格式化（format/currency）、导航（nav-modules/legacy-route）、Passkey、OAuth、头像、常量等 |
| 全局 Hook | `web/src/hooks/` | 跨特性复用的 React Hook：管理员判定、剪贴板、倒计时、防抖、弹窗、移动端判定、媒体查询、通知、侧边栏、系统配置、表格紧凑/URL 状态、用户展示等 |
| 全局状态 | `web/src/stores/` | Zustand 全局 store：鉴权状态（auth-store）、通知状态（notification-store）、系统配置缓存（system-config-store） |
| 全局上下文 | `web/src/context/` | React Context Provider：主题（theme-provider）、主题定制（theme-customization-provider）、字体（font-provider）、文字方向（direction-provider）、布局（layout-provider）、搜索（search-provider） |
| 全局配置 | `web/src/config/` | 字体加载配置（fonts.ts） |
| 全局样式 | `web/src/styles/` | 全局 CSS、主题变量与预设主题（index.css/theme.css/theme-presets.css） |
| 环境声明 | `web/src/env.d.ts`、`web/src/tanstack-table.d.ts` | 环境变量与 TanStack Table 的全局类型声明 |

### 国际化

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| i18n 配置 | `web/src/i18n/` | i18next 初始化、语言列表、静态键管理（config.ts/languages.ts/static-keys.ts） |
| 语言资源 | `web/src/i18n/locales/` | 多语言翻译文件：en（基准）/zh/zh-TW/fr/ja/ru/vi，及 `_reports/` 翻译校验报告 |

### 静态资源

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| 品牌图标 | `web/src/assets/brand-icons/` | 第三方品牌 SVG 图标（GitHub/Discord/微信/Telegram 等）及统一导出 |
| 自定义图标 | `web/src/assets/custom/` | 项目自定义图标：布局模式、侧边栏样式、主题、子项目 logo 等 |
| Logo 资源 | `web/src/assets/` | 项目主 Logo 与 Clerk 登录用 Logo 组件 |

### 通用 UI 基础组件

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| shadcn/ui 组件库 | `web/src/components/ui/` | 基于 Base UI/Tailwind 的通用原子组件集合：按钮、表单、对话框、表格、抽屉、下拉菜单、选择器、侧边栏、图表、Markdown 等 60+ 组件 |
| 布局组件 | `web/src/components/layout/` | 应用骨架布局：认证后布局（authenticated-layout）、公共布局、页眉/侧边栏/页脚、导航、系统品牌、Mockup 等，含布局配置与侧边栏视图注册 |
| 布局配置 | `web/src/components/layout/config/` | 顶部导航与系统设置布局配置 |
| 布局工具 | `web/src/components/layout/lib/` | 侧边栏视图注册表与 URL 工具 |
| 布局子组件 | `web/src/components/layout/components/` | 布局细分子组件：app-header/app-sidebar/navbar/footer/logo/nav-group 等 |

### 复合业务组件

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| AI 元素组件 | `web/src/components/ai-elements/` | AI 对话专用呈现组件：消息、推理、思维链、工具调用、引用、代码块、画布、工作流节点/边、响应渲染器与响应类型等 |
| 数据表格核心 | `web/src/components/data-table/core/` | 数据表格内核：表格视图、行/列头、分页、列固定/尺寸、徽标单元格、行操作菜单、空态/骨架、类型定义 |
| 数据表格 Hook | `web/src/components/data-table/hooks/` | 数据表格 Hook：表格状态管理、视图模式、列筛选防抖 |
| 数据表格布局 | `web/src/components/data-table/layout/` | 卡片网格/移动端卡片列表/分页页面等表格布局形态 |
| 数据表格静态模式 | `web/src/components/data-table/static/` | 静态（非分页服务端）数据表格实现与行操作 |
| 数据表格工具栏 | `web/src/components/data-table/toolbar/` | 工具栏：批量操作、分面筛选、视图模式切换、视图选项 |
| JSON 代码编辑器 | `web/src/components/json-code-editor/` | 基于 CodeMirror 的 JSON 代码编辑器及其工具函数与测试 |
| 模型分组选择器 | `web/src/components/model-group-selector/` | 模型分组多选/单选选择器及其布局工具与测试 |

### 功能特性（feature 模块）

| 模块 | 路径 | 职责 |
| --- | --- | --- |
| 首页 | `web/src/features/home/` | 公共首页内容入口（index/types/api/constants） |
| 首页-组件 | `web/src/features/home/components/`、`web/src/features/home/components/sections/` | 首页各区块组件（API 信息、公告、FAQ 等 section） |
| 首页-Hook | `web/src/features/home/hooks/` | 首页业务 Hook |
| 首页-Lib | `web/src/features/home/lib/` | 首页业务工具 |
| 认证 | `web/src/features/auth/` | 认证总入口：auth-layout、API、类型、常量、统一导出 |
| 认证-忘记密码 | `web/src/features/auth/forgot-password/`、`.../components/` | 忘记密码流程及表单组件 |
| 认证-Hook | `web/src/features/auth/hooks/` | 认证通用 Hook：登录重定向、邮箱验证、OAuth 登录、Turnstile |
| 认证-Lib | `web/src/features/auth/lib/` | 认证工具：OAuth、Telegram 登录、绑定窗口、回调模式、重定向、存储、校验 |
| 认证-OTP | `web/src/features/auth/otp/`、`.../components/` | OTP 验证流程及表单组件 |
| 认证-Passkey | `web/src/features/auth/passkey/`、`.../hooks/` | Passkey 注册/管理与 Hook |
| 认证-重置密码 | `web/src/features/auth/reset-password-confirm/` | 重置密码确认流程 |
| 认证-安全验证 | `web/src/features/auth/secure-verification/`、`.../components/`、`.../hooks/` | 敏感操作安全验证对话框与 Hook |
| 认证-登录 | `web/src/features/auth/sign-in/`、`.../components/` | 登录流程及用户认证表单 |
| 认证-注册 | `web/src/features/auth/sign-up/`、`.../components/` | 注册流程及注册表单 |
| 认证-公共组件 | `web/src/features/auth/components/` | 跨认证子流程复用的组件 |
| 关于页 | `web/src/features/about/` | 关于页面内容与 API/类型 |
| 法律文档 | `web/src/features/legal/` | 隐私政策、用户协议等法律文档展示（legal-document 及具体文档组件），含 API 与类型 |
| 错误页 | `web/src/features/errors/` | 通用错误状态页：403/404/500/未授权/维护中等 |
| 渠道管理 | `web/src/features/channels/` | 渠道总入口：API、类型、常量、统一导出 |
| 渠道-组件 | `web/src/features/channels/components/` | 渠道表格、批量/行操作、标签编辑、模型映射编辑、Provider 等 |
| 渠道-对话框 | `web/src/features/channels/components/dialogs/` | 渠道相关对话框：测试、余额查询、复制、标签编辑、多密钥管理、上游更新、参数覆盖等 |
| 渠道-抽屉 | `web/src/features/channels/components/drawers/`、`.../sections/` | 渠道编辑抽屉及其分区（基础/认证/API/模型/高级） |
| 渠道-Hook | `web/src/features/channels/hooks/` | 渠道编辑表单与上游更新 Hook |
| 渠道-Lib | `web/src/features/channels/lib/` | 渠道工具：表单、字段更新、类型配置、模型映射校验、多密钥、Ollama、状态码风险、上游同步等 |
| 令牌管理 | `web/src/features/keys/` | API 令牌管理总入口（API/类型/常量） |
| 令牌-组件 | `web/src/features/keys/components/`、`.../dialogs/` | 令牌列表、编辑对话框等组件 |
| 令牌-Lib | `web/src/features/keys/lib/` | 令牌业务工具与校验 |
| 模型管理 | `web/src/features/models/` | 可用模型管理总入口（API/类型/常量/区块注册） |
| 模型-组件 | `web/src/features/models/components/`、`.../dialogs/`、`.../drawers/` | 模型配置对话框/抽屉 |
| 模型-Hook | `web/src/features/models/hooks/` | 模型管理业务 Hook |
| 模型-Lib | `web/src/features/models/lib/` | 模型管理业务工具 |
| 仪表盘 | `web/src/features/dashboard/` | 数据仪表盘总入口（API/类型/常量/区块注册） |
| 仪表盘-概览 | `web/src/features/dashboard/components/overview/` | 概览面板：公告、API 信息、FAQ、性能健康、运行时间、汇总卡片 |
| 仪表盘-模型分析 | `web/src/features/dashboard/components/models/` | 模型消耗分布、性能概览、模型图表与过滤 |
| 仪表盘-流量 | `web/src/features/dashboard/components/flow/` | 流量图表与节点过滤 |
| 仪表盘-用户分析 | `web/src/features/dashboard/components/users/` | 用户分析图表 |
| 仪表盘-UI | `web/src/features/dashboard/components/ui/` | 仪表盘局部 UI（面板壳、统计卡） |
| 仪表盘-Hook | `web/src/features/dashboard/hooks/` | 仪表盘业务 Hook |
| 仪表盘-Lib | `web/src/features/dashboard/lib/` | 仪表盘业务工具 |
| 用量日志 | `web/src/features/usage-logs/` | 日志查询总入口（API/类型/常量/区块注册） |
| 用量日志-组件 | `web/src/features/usage-logs/components/`、`.../dialogs/` | 日志展示与详情对话框 |
| 用量日志-列定义 | `web/src/features/usage-logs/components/columns/` | 日志/绘图/任务日志的列定义与列辅助 |
| 用量日志-数据 | `web/src/features/usage-logs/data/` | 日志查询数据 schema |
| 用量日志-Lib | `web/src/features/usage-logs/lib/` | 日志查询与处理工具 |
| Playground | `web/src/features/playground/` | AI 对话调试场总入口（API/类型/常量） |
| Playground-聊天组件 | `web/src/features/playground/components/chat/` | Playground 聊天面板与空态 |
| Playground-输入组件 | `web/src/features/playground/components/input/` | 输入框、输入控制、工具与参数面板 |
| Playground-消息组件 | `web/src/features/playground/components/message/` | 消息内容、操作、错误、元数据、编辑器 |
| Playground-Hook | `web/src/features/playground/hooks/` | Playground 业务 Hook |
| Playground-Lib-输入 | `web/src/features/playground/lib/input/` | 输入控制与工具函数 |
| Playground-Lib-消息 | `web/src/features/playground/lib/message/` | 消息内容/动作/错误/布局/推理/流式/编辑/更新等工具 |
| Playground-Lib-选项 | `web/src/features/playground/lib/options/` | Playground 选项工具 |
| Playground-Lib-参数 | `web/src/features/playground/lib/parameters/` | Playground 参数定义 |
| Playground-Lib-状态 | `web/src/features/playground/lib/state/` | Playground 状态工具 |
| Playground-Lib-存储 | `web/src/features/playground/lib/storage/` | 本地持久化存储与 schema |
| Playground-Lib-流式 | `web/src/features/playground/lib/streaming/` | SSE 请求构造、流式解析与错误处理 |
| 聊天客服 | `web/src/features/chat/`、`.../hooks/`、`.../lib/` | 站内客服聊天（chat2link）Hook 与工具 |
| 定价 | `web/src/features/pricing/` | 定价展示总入口（API/类型/常量） |
| 定价-组件 | `web/src/features/pricing/components/` | 定价展示组件 |
| 定价-Hook | `web/src/features/pricing/hooks/` | 定价业务 Hook |
| 定价-Lib | `web/src/features/pricing/lib/` | 定价业务工具 |
| 排行榜 | `web/src/features/rankings/` | 排行榜总入口（API/类型） |
| 排行榜-组件 | `web/src/features/rankings/components/` | 排行榜展示组件 |
| 排行榜-Hook | `web/src/features/rankings/hooks/` | 排行榜业务 Hook |
| 排行榜-Lib | `web/src/features/rankings/lib/` | 排行榜业务工具 |
| 个人资料 | `web/src/features/profile/` | 个人中心总入口（API/类型/常量） |
| 个人资料-组件 | `web/src/features/profile/components/` | 个人资料相关组件 |
| 个人资料-对话框 | `web/src/features/profile/components/dialogs/` | 个人资料编辑对话框 |
| 个人资料-标签页 | `web/src/features/profile/components/tabs/` | 账号绑定、通知等标签页 |
| 个人资料-Hook | `web/src/features/profile/hooks/` | 个人资料业务 Hook |
| 个人资料-Lib | `web/src/features/profile/lib/` | 个人资料业务工具 |
| 兑换码 | `web/src/features/redemption-codes/` | 兑换码管理总入口（API/类型/常量） |
| 兑换码-组件 | `web/src/features/redemption-codes/components/` | 兑换码列表与兑换组件 |
| 兑换码-Lib | `web/src/features/redemption-codes/lib/` | 兑换码业务工具 |
| 钱包 | `web/src/features/wallet/` | 用户钱包总入口（API/类型/常量） |
| 钱包-组件 | `web/src/features/wallet/components/` | 钱包余额、账单、交易组件 |
| 钱包-对话框 | `web/src/features/wallet/components/dialogs/` | 充值、账单详情等对话框 |
| 钱包-Hook | `web/src/features/wallet/hooks/` | 钱包业务 Hook |
| 钱包-Lib | `web/src/features/wallet/lib/` | 钱包业务工具 |
| 用户管理 | `web/src/features/users/` | 管理员用户管理总入口（API/类型/常量） |
| 用户-组件 | `web/src/features/users/components/`、`.../dialogs/` | 用户表格与编辑对话框 |
| 用户-Lib | `web/src/features/users/lib/` | 用户管理业务工具 |
| 订阅 | `web/src/features/subscriptions/` | 订阅管理总入口（API/类型/常量） |
| 订阅-组件 | `web/src/features/subscriptions/components/`、`.../dialogs/` | 订阅计划列表与编辑对话框 |
| 订阅-Lib | `web/src/features/subscriptions/lib/` | 订阅业务工具 |
| 系统信息 | `web/src/features/system-info/`、`.../components/` | 系统运行信息展示 |
| 性能指标 | `web/src/features/performance-metrics/`、`.../lib/` | 性能指标查询 API 与工具 |
| 初始化向导 | `web/src/features/setup/` | 首次部署初始化向导（API/类型） |
| 初始化向导-组件 | `web/src/features/setup/components/` | 向导步骤组件 |
| 系统设置（总） | `web/src/features/system-settings/` | 系统设置聚合：API、类型、统一入口 |
| 系统设置-公共组件 | `web/src/features/system-settings/components/` | 设置页/卡片/分区/表单守卫等公共组件 |
| 系统设置-Hook | `web/src/features/system-settings/hooks/` | 设置表单、脏守卫、折叠状态、JSON 状态、更新选项等 Hook |
| 系统设置-工具 | `web/src/features/system-settings/utils/` | JSON 解析校验、数值字段、路由配置、分区注册 |
| 系统设置-认证 | `web/src/features/system-settings/auth/` | 认证设置：基础认证、OAuth、Passkey、机器人防护，含分区注册与回调 URL |
| 系统设置-自定义 OAuth | `web/src/features/system-settings/auth/custom-oauth/`、`.../components/`、`.../hooks/` | 自定义 OAuth 提供商配置：API、组件、Hook、类型 |
| 系统设置-计费 | `web/src/features/system-settings/billing/` | 计费设置分区注册 |
| 系统设置-内容 | `web/src/features/system-settings/content/` | 内容设置：公告、API 信息、聊天/绘图设置（含可视化编辑）、仪表盘、FAQ、JSON 开关、Uptime Kuma 等 |
| 系统设置-通用 | `web/src/features/system-settings/general/` | 通用设置：签到、定价、配额、系统行为、系统信息 |
| 系统设置-渠道亲和 | `web/src/features/system-settings/general/channel-affinity/` | 渠道亲和规则编辑、缓存统计对话框 |
| 系统设置-集成 | `web/src/features/system-settings/integrations/` | 集成设置：邮件、支付（Creem/Waffo/Pancake 可视化编辑）、ioNet 部署、监控、Worker 等 |
| 系统设置-维护 | `web/src/features/system-settings/maintenance/` | 维护设置：日志、性能、公告、侧边栏模块、更新检查、头部导航 |
| 系统设置-模型 | `web/src/features/system-settings/models/` | 模型计费设置：渠道选择、各家（Claude/Gemini/Grok）设置卡片、全局设置、分组倍率（含可视化编辑）、模型倍率表（含可视化编辑）、分层定价、工具计价、上游倍率同步、路由可靠性等 |
| 系统设置-运营 | `web/src/features/system-settings/operations/` | 运营设置分区注册 |
| 系统设置-请求限制 | `web/src/features/system-settings/request-limits/` | 请求限制：限流（含可视化编辑）与敏感词设置 |
| 系统设置-安全 | `web/src/features/system-settings/security/` | 安全设置分区注册 |
| 系统设置-站点 | `web/src/features/system-settings/site/` | 站点设置分区注册 |

---

## 2. 导入模块（第三方依赖）

### 核心框架

| 依赖 | 用途 |
| --- | --- |
| `react` / `react-dom` | React 19 渲染运行时与 DOM 适配 |
| `@tanstack/react-router` | 文件式路由系统，驱动 `routes/` 下的页面与路由组 |
| `@tanstack/react-query` | 服务端状态/数据请求缓存（`features/*/api.ts` 的查询与变更） |
| `@tanstack/react-table` | `components/data-table/` 的表格内核 |
| `@tanstack/react-virtual` | 长列表虚拟滚动 |
| `zustand` | `stores/` 全局状态管理（鉴权、通知、系统配置） |

### 构建工具链（devDependencies）

| 依赖 | 用途 |
| --- | --- |
| `@rsbuild/core` | Rsbuild 构建/开发服务器 |
| `@rsbuild/plugin-react` | Rsbuild 的 React 支持 |
| `@rsbuild/plugin-tailwindcss` | Rsbuild 的 Tailwind CSS 集成 |
| `@tanstack/router-plugin` | Rsbuild 下的 TanStack Router 文件式路由插件（生成 routeTree） |
| `@tanstack/react-query-devtools` / `@tanstack/react-router-devtools` | 开发态调试面板 |
| `@typescript/native-preview`（tsgo） | TypeScript 类型检查（`bun run typecheck`） |
| `oxlint` / `oxfmt` | 代码 lint 与格式化 |
| `knip` | 未使用代码/依赖检测 |
| `shadcn` | shadcn/ui 组件脚手架（`components/ui/`） |
| `happy-dom` | 测试用 DOM 环境 |
| `@types/{node,react,react-dom}` | 类型声明 |

### UI 基础组件与样式

| 依赖 | 用途 |
| --- | --- |
| `@base-ui/react` | `components/ui/` 组件底层原语（Base UI） |
| `tailwindcss` / `tailwind-merge` / `tw-animate-css` | Tailwind 工具类与合并、动画工具 |
| `class-variance-authority` / `clsx` | 组件变体与条件类名 |
| `lucide-react` / `react-icons` / `@hugeicons/react` / `@hugeicons/core-free-icons` / `@lobehub/icons` | 图标库 |
| `@fontsource-variable/{lora,public-sans}` | 内嵌字体资源 |
| `next-themes` | 主题（深/浅色）切换驱动 |
| `motion` | 动画（Framer Motion） |
| `cmdk` | 命令面板 |
| `vaul` | 抽屉（Drawer）组件 |
| `input-otp` | OTP 输入组件（认证 OTP 流程） |
| `embla-carousel-react` | 轮播组件 |
| `react-resizable-panels` | 可调大小面板 |
| `react-day-picker` / `dayjs` | 日期选择与日期处理 |
| `@xyflow/react` | 工作流/流程图节点编辑（ai-elements 画布与节点/边） |

### AI / Markdown / 富文本渲染

| 依赖 | 用途 |
| --- | --- |
| `ai` | AI SDK（Playground 流式对话） |
| `marked` | Markdown 解析 |
| `shiki` | 代码语法高亮 |
| `katex` | 数学公式渲染 |
| `dompurify` | HTML 净化（Markdown 渲染防 XSS） |
| `stream-markdown-parser` | 流式 Markdown 解析 |
| `@codemirror/{state,view,language,lang-markdown}` / `@lezer/highlight` / `yace` | 代码编辑器（JSON 编辑器、Markdown 编辑） |
| `auto-skeleton-react` | 骨架屏加载占位 |
| `use-stick-to-bottom` | 聊天消息自动滚动到底 |
| `tokenlens` | Token 计数 |

### 数据可视化

| 依赖 | 用途 |
| --- | --- |
| `@visactor/react-vchart` / `@visactor/vchart` | 仪表盘与统计图表（VChart） |
| `recharts` | 部分图表 |

### 表单与校验

| 依赖 | 用途 |
| --- | --- |
| `react-hook-form` / `@hookform/resolvers` | 表单状态与提交管理 |
| `zod` | Schema 校验（表单与 API 数据） |

### 网络、状态与工具

| 依赖 | 用途 |
| --- | --- |
| `axios` | HTTP 客户端（`lib/http-client.ts`、`lib/api.ts`） |
| `sse.js` | SSE 流式响应处理（Playground/聊天） |
| `nanoid` | 唯一 ID 生成 |
| `react-top-loading-bar` | 顶部加载进度条 |
| `qrcode.react` | 二维码渲染（OAuth/Passkey 绑定等） |

### 国际化

| 依赖 | 用途 |
| --- | --- |
| `i18next` / `react-i18next` / `i18next-browser-languagedetector` | 多语言（`i18n/`，支持 en/zh/zh-TW/fr/ja/ru/vi） |

### 提示与交互

| 依赖 | 用途 |
| --- | --- |
| `sonner` | Toast 通知 |
