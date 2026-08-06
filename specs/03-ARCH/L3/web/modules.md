# web 模块索引

> 全部模块的可点击索引。非同构模块详情（职责+正向依赖）在独立文件；同构折叠组见汇总文件。

## 1. 内部模块

### 同构折叠组

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| 路由层 | 59 个 TanStack Router 路由文件（同构折叠） | [routes.md](routes.md) |
| shadcn/ui 原子组件库 | 62 个原子组件（同构折叠） | [components-ui.md](components-ui.md) |
| AI 对话组件 | 42 个 AI 对话呈现组件（同构折叠） | [components-ai-elements.md](components-ai-elements.md) |
| 工具库 | 40 个项目级工具函数（同构折叠） | [lib.md](lib.md) |
| 全局 Hook | 21 个复用 React Hook（同构折叠） | [hooks.md](hooks.md) |
| 图标资源 | 品牌/自定义 SVG 图标（同构折叠） | [assets.md](assets.md) |
| 通用业务组件 | 43 个顶层散组件（同构折叠） | [components-misc.md](components-misc.md) |

### 应用入口 (`entry`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| env.d.ts | 环境变量类型声明（Vite） | [env-d.md](entry/env-d.md) |
| main.tsx | React 应用引导：装配 RouterProvider、QueryClient、主题/字体/方向 Provider，初始化构建元数据与前端缓存 | [main.md](entry/main.md) |
| routeTree.gen.ts | TanStack Router 自动生成的路由树聚合文件（勿手动编辑） | [routeTree-gen.md](entry/routeTree-gen.md) |
| tanstack-table.d.ts | TanStack Table 全局类型补充声明 | [tanstack-table-d.md](entry/tanstack-table-d.md) |

### 基础设施层 (`infra`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| config | 字体加载配置（fonts.ts） | [config.md](infra/config.md) |
| context | React Context Provider：主题（theme-provider）、主题定制（theme-customization-provider）、字体（font-provider）、文字方向（direction-provider）、布局（layout-provider）、搜索（search-provider） | [context.md](infra/context.md) |
| i18n | i18next 初始化、语言列表、静态键管理（config.ts/languages.ts/static-keys.ts） | [i18n.md](infra/i18n.md) |
| stores | Zustand 全局 store：鉴权状态（auth-store）、通知状态（notification-store）、系统配置缓存（system-config-store） | [stores.md](infra/stores.md) |

### 功能特性（feature 模块） (`features`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| features/about | 关于页面内容与 API/类型 | [about.md](features/about.md) |
| features/auth | 认证总入口：auth-layout、API、类型、常量、统一导出 | [auth.md](features/auth.md) |
| features/channels | 渠道总入口：API、类型、常量、统一导出 | [channels.md](features/channels.md) |
| features/chat | 站内客服聊天（chat2link）Hook 与工具 | [chat.md](features/chat.md) |
| features/dashboard | 数据仪表盘总入口（API/类型/常量/区块注册） | [dashboard.md](features/dashboard.md) |
| features/errors | 通用错误状态页：403/404/500/未授权/维护中等 | [errors.md](features/errors.md) |
| features/home | 公共首页内容入口（index/types/api/constants） | [home.md](features/home.md) |
| features/keys | API 令牌管理总入口（API/类型/常量） | [keys.md](features/keys.md) |
| features/legal | 隐私政策、用户协议等法律文档展示（legal-document 及具体文档组件），含 API 与类型 | [legal.md](features/legal.md) |
| features/models | 可用模型管理总入口（API/类型/常量/区块注册） | [models.md](features/models.md) |
| features/performance-metrics | 性能指标查询 API 与工具 | [performance-metrics.md](features/performance-metrics.md) |
| features/playground | AI 对话调试场总入口（API/类型/常量） | [playground.md](features/playground.md) |
| features/pricing | 定价展示总入口（API/类型/常量） | [pricing.md](features/pricing.md) |
| features/profile | 个人中心总入口（API/类型/常量） | [profile.md](features/profile.md) |
| features/rankings | 排行榜总入口（API/类型） | [rankings.md](features/rankings.md) |
| features/redemption-codes | 兑换码管理总入口（API/类型/常量） | [redemption-codes.md](features/redemption-codes.md) |
| features/setup | 首次部署初始化向导（API/类型） | [setup.md](features/setup.md) |
| features/subscriptions | 订阅管理总入口（API/类型/常量） | [subscriptions.md](features/subscriptions.md) |
| features/system-info | 系统运行信息展示 | [system-info.md](features/system-info.md) |
| features/system-settings | 系统设置聚合：API、类型、统一入口 | [system-settings.md](features/system-settings.md) |
| features/usage-logs | 日志查询总入口（API/类型/常量/区块注册） | [usage-logs.md](features/usage-logs.md) |
| features/users | 管理员用户管理总入口（API/类型/常量） | [users.md](features/users.md) |
| features/wallet | 用户钱包总入口（API/类型/常量） | [wallet.md](features/wallet.md) |

### 复合业务组件 (`ui-composite`)

| 模块 | 职责 | 文件 |
| --- | --- | --- |
| components/data-table/core | 数据表格内核：表格视图、行/列头、分页、列固定/尺寸、徽标单元格、行操作菜单、空态/骨架、类型定义 | [data-table-core.md](ui-composite/data-table-core.md) |
| components/data-table/hooks | 数据表格 Hook：表格状态管理、视图模式、列筛选防抖 | [data-table-hooks.md](ui-composite/data-table-hooks.md) |
| components/data-table/index.ts | （待补充） | [data-table-index.md](ui-composite/data-table-index.md) |
| components/data-table/layout | 卡片网格/移动端卡片列表/分页页面等表格布局形态 | [data-table-layout.md](ui-composite/data-table-layout.md) |
| components/data-table/static | 静态（非分页服务端）数据表格实现与行操作 | [data-table-static.md](ui-composite/data-table-static.md) |
| components/data-table/toolbar | 工具栏：批量操作、分面筛选、视图模式切换、视图选项 | [data-table-toolbar.md](ui-composite/data-table-toolbar.md) |
| components/layout/components | 布局细分子组件：app-header/app-sidebar/navbar/footer/logo/nav-group 等 | [layout-components.md](ui-composite/layout-components.md) |
| components/layout/config | 顶部导航与系统设置布局配置 | [layout-config.md](ui-composite/layout-config.md) |
| components/layout/constants.ts | （待补充） | [layout-constants.md](ui-composite/layout-constants.md) |
| components/layout/index.ts | （待补充） | [layout-index.md](ui-composite/layout-index.md) |
| components/layout/lib | 侧边栏视图注册表与 URL 工具 | [layout-lib.md](ui-composite/layout-lib.md) |
| components/layout/types.ts | （待补充） | [layout-types.md](ui-composite/layout-types.md) |


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