# web 模块索引

> 全部**逻辑模块**与**业务流程**的可点击索引。模块从代码职责提炼归类，不与源码目录 1:1 对应；流程描述一个请求/场景在模块间怎么流转。两者互补。

## 关键流程（模块间动态协作）

**请求/交互驱动流程**（用户操作入口）：

| 场景 | 流程文档 |
| --- | --- |
| 用户在钱包页充值，经试算、确认、多支付网关分发完成支付 | [flows/topup-payment.md](flows/topup-payment.md) |
| 查看渠道密钥等敏感操作触发 2FA/Passkey 二次验证获取 proof_token | [flows/secure-verification.md](flows/secure-verification.md) |
| Playground 发送消息，SSE 流式接收并增量渲染 LLM 响应 | [flows/playground-streaming.md](flows/playground-streaming.md) |

**启动驱动流程**（应用入口，非用户操作）：

| 场景 | 流程文档 |
| --- | --- |
| 前端从 main.tsx 挂载到首屏就绪，含 setup 检查与认证引导 | [flows/app-startup.md](flows/app-startup.md) |
| 系统未初始化时强制重定向到 4 步部署向导完成首次初始化 | [flows/setup-wizard.md](flows/setup-wizard.md) |

## 1. 内部模块（逻辑模块）

### 应用框架 (`framework`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 应用引导 | React 应用根引导：装配 Provider 链、初始化 QueryClient/Router、预加载系统品牌 | `main.tsx`、`routeTree.gen.ts`、`config/` | [app-bootstrap.md](modules/framework/app-bootstrap.md) |
| 路由层与权限守卫 | TanStack Router 文件路由骨架、布局路由外壳、登录与角色守卫、遗留路由重定向、错误边界 | `routes/`、`lib/nav-modules.ts`、`lib/legacy-route.ts` | [routing-guard.md](modules/framework/routing-guard.md) |
| 主题与偏好 Provider | 跨组件树注入主题/主题定制/字体/方向/侧边栏布局/命令面板偏好，Cookie 持久化驱动 CSS 变量 | `context/`、`lib/theme-*.ts`、`lib/motion.ts` | [theme-prefs.md](modules/framework/theme-prefs.md) |

### 基础设施 (`infra`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| HTTP 与认证会话底座 | axios 实例（认证拦截/自动刷新/去重/错误处理）、认证 bundle 解析、跨标签页会话同步 | `lib/http-client.ts`、`lib/api.ts`、`lib/auth-session*.ts`、`lib/handle-server-error.ts`、`lib/secure-verification.ts` | [http-auth-base.md](modules/infra/http-auth-base.md) |
| 全局状态与系统配置缓存 | Zustand 管理认证态/通知已读/系统配置缓存，区分内存与持久化，提供非 React 同步选择器 | `stores/auth-store.ts`、`stores/notification-store.ts`、`stores/system-config-store.ts` | [global-state.md](modules/infra/global-state.md) |
| 通用工具库 | 格式化/剪贴板/权限角色/第三方认证编解码/Cookie-DOM-缓存/可视化辅助等纯函数底座 | `lib/format.ts`、`lib/currency.ts`、`lib/roles.ts`、`lib/oauth.ts`、`lib/passkey.ts`、`lib/utils.ts` 等 | [utils.md](modules/infra/utils.md) |
| 全局复用 Hook | 跨页面复用 hooks：系统配置拉取、通知联动、侧边栏导航、权限判定、表格状态、UI 交互、防抖/倒计时、响应式 | `hooks/` | [hooks.md](modules/infra/hooks.md) |
| 国际化基础 | i18next 初始化、7 语言清单与编码映射、静态翻译键登记 | `i18n/config.ts`、`i18n/languages.ts`、`i18n/static-keys.ts`、`i18n/locales/` | [i18n.md](modules/infra/i18n.md) |

### 认证与会话 (`auth`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 登录与注册 | 密码登录/注册、2FA OTP、密码找回、邀请码、Turnstile、登出与会话恢复 | `features/auth/sign-in/`、`sign-up/`、`forgot-password/`、`otp/`、`reset-password-confirm/` | [sign-in-up.md](modules/auth/sign-in-up.md) |
| OAuth 与 Passkey 免密登录 | 第三方 OAuth 登录（GitHub/Discord/OIDC/Telegram/WeChat/自定义）、Passkey WebAuthn 登录/管理、账号绑定 | `features/auth/components/`、`features/auth/passkey/`、`features/auth/lib/`、`lib/oauth.ts`、`lib/passkey.ts` | [oauth-passkey.md](modules/auth/oauth-passkey.md) |
| 敏感操作二次验证 | 2FA/Passkey 作为 Security Proof 的作用域驱动二次验证，统一对话框，proof_token 透传 | `features/auth/secure-verification/`、`lib/secure-verification.ts` | [secure-verification.md](modules/auth/secure-verification.md) |
| 个人中心与自助 | 用户自助资料/安全/会话/签到/侧栏管理，以及 API Key 自助管理 | `features/profile/`、`features/keys/` | [profile-self.md](modules/auth/profile-self.md) |

### 计费与支付 (`billing`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 钱包与支付 | 钱包主页、充值配置/试算、多支付网关在线支付、兑换码兑换、推广返佣、账单历史 | `features/wallet/` | [wallet-payment.md](modules/billing/wallet-payment.md) |
| 订阅套餐管理 | 订阅套餐全生命周期（管理员 CRUD/用户管理，用户查询/计费偏好/多通道支付），合规门控 | `features/subscriptions/` | [subscriptions.md](modules/billing/subscriptions.md) |
| 兑换码管理 | 管理员兑换码（一次性预付面值卡）批量生成/编辑/启停/删除/清理 | `features/redemption-codes/` | [redemption-codes.md](modules/billing/redemption-codes.md) |
| 定价广场 | 公开模型广场：模型价格/能力/分组倍率展示，多维筛选，表格/卡片双视图 | `features/pricing/` | [pricing.md](modules/billing/pricing.md) |

### 渠道与系统管理 (`admin-channels`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 渠道管理 | 50+ 上游供应商渠道全生命周期：CRUD/测试/批量运维/密钥/模型映射（最复杂功能） | `features/channels/` | [channels.md](modules/admin-channels/channels.md) |
| 模型目录管理 | 模型目录元数据（model_name/vendor/匹配规则）、上游同步、缺失检测、io.net GPU 部署 | `features/models/` | [models.md](modules/admin-channels/models.md) |
| 用户管理 | 管理员用户账户管理：CRUD/角色状态/配额/Passkey-2FA 重置/OAuth 绑定/权限目录 | `features/users/` | [users.md](modules/admin-channels/users.md) |
| 监控与日志 | 数据仪表盘（概览/模型/流量/用户）、用量日志（调用/绘图/任务）、性能指标查询 | `features/dashboard/`、`features/usage-logs/`、`features/performance-metrics/` | [dashboard-logs.md](modules/admin-channels/dashboard-logs.md) |
| 系统设置 | 7 子类别（站点/认证/计费/模型路由/安全/内容/运维）服务端配置，嵌套 drill-in 侧边栏 | `features/system-settings/`、`components/layout/config/system-settings.config.ts` | [system-settings.md](modules/admin-channels/system-settings.md) |
| 区块注册框架 | 通用 createSectionRegistry 工厂，驱动仪表盘/日志/系统设置多分区页面 | `features/system-settings/utils/section-registry.ts` | [section-registry.md](modules/admin-channels/section-registry.md) |
| AI 对话调试场 | 登录用户 AI 对话测试场：分组/模型选择、推理参数、SSE 流式 chat completions | `features/playground/` | [playground.md](modules/admin-channels/playground.md) |
| 系统信息与首次部署 | Root 系统运行信息（实例/任务）、未初始化时 4 步部署向导 | `features/system-info/`、`features/setup/` | [system-info-runtime.md](modules/admin-channels/system-info-runtime.md) |
| 公共内容与错误页 | 公共首页/关于/法律/排行榜、站内客服聊天（链接型）、401-503 错误页 | `features/home/`、`about/`、`legal/`、`rankings/`、`chat/`、`errors/` | [public-content.md](modules/admin-channels/public-content.md) |

### UI 组件库 (`ui`)

| 模块 | 职责 | 覆盖代码 | 文件 |
| --- | --- | --- | --- |
| 通用 UI 原子组件 | Radix + Tailwind 原子组件库（约 62 个），设计系统统一基座，无业务逻辑 | `components/ui/` | [ui-primitives.md](modules/ui/ui-primitives.md) |
| AI 对话呈现组件 | ai-elements 风格对话 UI 原语：响应渲染引擎、推理链、工具调用、画布/工作流 | `components/ai-elements/` | [ai-elements.md](modules/ui/ai-elements.md) |
| 布局框架 | 应用级布局（侧边栏/顶栏/内容/页脚）+ 嵌套 drill-in 侧边栏视图，五层分层 | `components/layout/` | [layout-framework.md](modules/ui/layout-framework.md) |
| 数据表格复合组件 | TanStack Table 企业级表格方案，表格/卡片双视图，五层分层（core/hooks/toolbar/layout/static） | `components/data-table/` | [data-table.md](modules/ui/data-table.md) |
| 业务复用组件 | 非原子业务组件：JSON/富文本编辑、选择器、反馈对话框、交互工具、展示、主题语言切换、品牌资源、全局样式 | `components/`（根目录散组件）、`assets/`、`styles/` | [business-components.md](modules/ui/business-components.md) |
