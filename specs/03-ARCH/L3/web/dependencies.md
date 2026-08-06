# web

## 1. 内部模块直接依赖

> 采集自 `web/src/` 下所有 `.ts/.tsx/.js/.jsx` 文件的 `import` 声明中指向组件内部的路径（`@/` 别名与 `./` / `../` 相对路径），剔除第三方裸包与标准库，按目录归约到模块级，去重并剔除自引用。指向 `src/i18n/locales`（纯翻译数据目录）的引用已剔除。

### 应用入口与路由层

| 模块 | 直接依赖（内部） |
| --- | --- |
| `src`（`main.tsx` 装配） | `src/context`、`src/lib`、`src/routes`、`src/routes/(auth)`、`src/routes/(auth)/user`、`src/routes/(errors)`、`src/routes/_authenticated`、`src/routes/_authenticated/channels`、`src/routes/_authenticated/chat`、`src/routes/_authenticated/dashboard`、`src/routes/_authenticated/errors`、`src/routes/_authenticated/keys`、`src/routes/_authenticated/models`、`src/routes/_authenticated/playground`、`src/routes/_authenticated/profile`、`src/routes/_authenticated/redemption-codes`、`src/routes/_authenticated/subscriptions`、`src/routes/_authenticated/system-info`、`src/routes/_authenticated/system-settings`、`src/routes/_authenticated/system-settings/{auth,billing,content,models,operations,security,site}`、`src/routes/_authenticated/usage-logs`、`src/routes/_authenticated/users`、`src/routes/_authenticated/wallet`、`src/routes/about`、`src/routes/oauth`、`src/routes/pricing`、`src/routes/pricing/$modelId`、`src/routes/rankings`、`src/routes/setup` |
| `src/routes`（`__root`） | `src/components`、`src/components/ui`、`src/context`、`src/features/auth/lib`、`src/features/errors`、`src/features/home`、`src/features/legal`、`src/features/setup`、`src/hooks`、`src/lib`、`src/stores` |
| `src/routes/(auth)` | `src/features/auth`、`src/features/auth/forgot-password`、`src/features/auth/lib`、`src/features/auth/otp`、`src/features/auth/reset-password-confirm`、`src/features/auth/sign-in`、`src/features/auth/sign-up`、`src/lib`、`src/stores` |
| `src/routes/(auth)/user` | `src/features/auth/reset-password-confirm` |
| `src/routes/(errors)` | `src/features/errors` |
| `src/routes/_authenticated` | `src/components/layout`、`src/features/chat/hooks`、`src/features/chat/lib`、`src/stores` |
| `src/routes/_authenticated/channels` | `src/features/channels`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/chat` | `src/components/ui`、`src/features/chat/hooks`、`src/features/chat/lib` |
| `src/routes/_authenticated/dashboard` | `src/features/dashboard` |
| `src/routes/_authenticated/errors` | `src/components`、`src/components/layout`、`src/features/errors` |
| `src/routes/_authenticated/keys` | `src/features/keys` |
| `src/routes/_authenticated/models` | `src/features/models`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/playground` | `src/components/layout`、`src/features/playground`、`src/lib` |
| `src/routes/_authenticated/profile` | `src/features/profile` |
| `src/routes/_authenticated/redemption-codes` | `src/features/redemption-codes`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/subscriptions` | `src/features/subscriptions`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/system-info` | `src/features/system-info`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/system-settings` | `src/features/system-settings`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/system-settings/{auth,billing,content,models,operations,security,site}` | 对应 `src/features/system-settings/{auth,billing,content,models,operations,security,site}` |
| `src/routes/_authenticated/usage-logs` | `src/features/usage-logs` |
| `src/routes/_authenticated/users` | `src/features/users`、`src/lib`、`src/stores` |
| `src/routes/_authenticated/wallet` | `src/features/wallet` |
| `src/routes/about` | `src/features/about` |
| `src/routes/oauth` | `src/features/auth`、`src/features/auth/components`、`src/features/auth/lib`、`src/lib` |
| `src/routes/pricing` | `src/features/pricing`、`src/lib`、`src/stores` |
| `src/routes/pricing/$modelId` | `src/features/pricing/components`、`src/lib`、`src/stores` |
| `src/routes/rankings` | `src/features/rankings`、`src/lib`、`src/stores` |
| `src/routes/setup` | `src/features/setup` |

### 基础设施层（lib / hooks / stores / context / config / i18n / assets）

| 模块 | 直接依赖（内部） |
| --- | --- |
| `src/lib` | `src/assets/custom`、`src/context`、`src/stores` |
| `src/hooks` | `src/components/layout`、`src/components/layout/lib`、`src/features/auth`、`src/lib`、`src/stores` |
| `src/stores` | `src/lib` |
| `src/context` | `src/components`、`src/config`、`src/lib` |
| `src/assets` | `src/lib` |
| `src/assets/brand-icons` | `src/lib` |
| `src/assets/custom` | `src/context`、`src/lib` |
| `src/i18n` | （无内部依赖，仅被依赖） |

### 通用组件库（components）

| 模块 | 直接依赖（内部） |
| --- | --- |
| `src/components`（barrel） | `src/assets/custom`、`src/components/data-table/core`、`src/components/json-code-editor`、`src/components/layout/lib`、`src/components/model-group-selector`、`src/components/ui`、`src/context`、`src/features/auth`、`src/hooks`、`src/i18n`、`src/lib`、`src/stores` |
| `src/components/ai-elements` | `src/components/ui`、`src/lib` |
| `src/components/data-table`（barrel） | `src/components/data-table/{core,hooks,layout,static,toolbar}` |
| `src/components/data-table/core` | `src/components`、`src/components/ui`、`src/lib` |
| `src/components/data-table/hooks` | `src/hooks` |
| `src/components/data-table/layout` | `src/components`、`src/components/data-table/{core,hooks,toolbar}`、`src/components/layout/components`、`src/components/ui`、`src/hooks`、`src/lib` |
| `src/components/data-table/static` | `src/components/data-table/core`、`src/components/ui`、`src/lib` |
| `src/components/data-table/toolbar` | `src/components/data-table/hooks`、`src/components/ui`、`src/hooks`、`src/lib` |
| `src/components/json-code-editor` | （仅依赖第三方 CodeMirror） |
| `src/components/layout` | `src/components/layout/{components,config,lib}` |
| `src/components/layout/components` | `src/components`、`src/components/layout`、`src/components/layout/{config,lib}`、`src/components/ui`、`src/context`、`src/features/chat/{hooks,lib}`、`src/hooks`、`src/lib`、`src/stores` |
| `src/components/layout/config` | `src/components/layout`、`src/features/system-settings/{auth,billing,content,models,operations,security,site}` |
| `src/components/layout/lib` | `src/components/layout`、`src/components/layout/config` |
| `src/components/model-group-selector` | （仅依赖第三方/`src/lib`，跨特性被引用） |
| `src/components/ui` | `src/context`、`src/hooks`、`src/lib` |

### 特性模块（features）

> 特性内部普遍遵循 `feature 根 → components/hooks/lib 子层 → 共享基础设施` 的层级；跨特性耦合仅在有显式依赖时列出。

| 模块 | 直接依赖（内部） |
| --- | --- |
| `src/features/about` | `src/components`、`src/components/layout`、`src/components/ui`、`src/lib` |
| `src/features/auth` | `src/components/ui`、`src/features/auth/{components,forgot-password,hooks,lib,otp,sign-in,sign-up}`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/auth/components` | `src/assets/brand-icons`、`src/components`、`src/components/ui`、`src/features/auth`、`src/features/auth/hooks`、`src/lib` |
| `src/features/auth/forgot-password` | `src/features/auth`、`src/features/auth/forgot-password/components` |
| `src/features/auth/forgot-password/components` | `src/components`、`src/components/ui`、`src/features/auth`、`src/features/auth/hooks`、`src/hooks`、`src/lib` |
| `src/features/auth/hooks` | `src/features/auth`、`src/features/auth/lib`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/auth/lib` | `src/features/auth`、`src/lib`、`src/stores` |
| `src/features/auth/otp` | `src/features/auth`、`src/features/auth/otp/components` |
| `src/features/auth/otp/components` | `src/components/ui`、`src/features/auth`、`src/features/auth/{hooks,lib}`、`src/lib`、`src/stores` |
| `src/features/auth/passkey` | `src/features/auth/passkey/hooks`、`src/features/auth/secure-verification`、`src/lib` |
| `src/features/auth/passkey/hooks` | `src/features/auth/passkey`、`src/lib` |
| `src/features/auth/reset-password-confirm` | `src/components/ui`、`src/features/auth`、`src/hooks`、`src/lib` |
| `src/features/auth/secure-verification` | `src/features/auth`、`src/features/auth/passkey`、`src/features/auth/secure-verification/{components,hooks}`、`src/lib` |
| `src/features/auth/secure-verification/components` | `src/components`、`src/components/ui`、`src/features/auth/secure-verification` |
| `src/features/auth/secure-verification/hooks` | `src/features/auth/secure-verification`、`src/lib` |
| `src/features/auth/sign-in` | `src/features/auth`、`src/features/auth/components`、`src/features/auth/sign-in/components`、`src/hooks` |
| `src/features/auth/sign-in/components` | `src/components`、`src/components/ui`、`src/features/auth`、`src/features/auth/{components,hooks}`、`src/features/auth/passkey`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/auth/sign-up` | `src/features/auth`、`src/features/auth/components`、`src/features/auth/sign-up/components`、`src/hooks` |
| `src/features/auth/sign-up/components` | `src/components`、`src/components/ui`、`src/features/auth`、`src/features/auth/{components,hooks,lib}`、`src/hooks`、`src/lib` |
| `src/features/channels` | `src/components/layout`、`src/components/ui`、`src/features/channels/components`、`src/features/users`、`src/lib`、`src/stores` |
| `src/features/channels/components` | `src/components`、`src/components/data-table`、`src/components/data-table/core`、`src/components/ui`、`src/features/channels`、`src/features/channels/components/{dialogs,drawers}`、`src/features/channels/{hooks,lib}`、`src/hooks`、`src/i18n`、`src/lib`、`src/stores` |
| `src/features/channels/components/dialogs` | `src/components`、`src/components/data-table`、`src/components/ui`、`src/features/channels`、`src/features/channels/components`、`src/features/channels/lib`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/channels/components/drawers` | `src/components`、`src/components/ui`、`src/features/auth/secure-verification`、`src/features/channels`、`src/features/channels/components`、`src/features/channels/components/dialogs`、`src/features/channels/components/drawers/sections`、`src/features/channels/{hooks,lib}`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/channels/components/drawers/sections` | `src/components`、`src/components/ui`、`src/lib` |
| `src/features/channels/hooks` | `src/features/channels`、`src/features/channels/lib`、`src/lib`、`src/stores` |
| `src/features/channels/lib` | `src/features/channels`、`src/lib` |
| `src/features/chat/hooks` | `src/features/auth`、`src/features/chat/lib`、`src/features/keys`、`src/hooks`、`src/stores` |
| `src/features/chat/lib` | `src/features/keys` |
| `src/features/dashboard` | `src/components`、`src/components/layout`、`src/components/ui`、`src/features/dashboard/components/{models,overview}`、`src/features/dashboard/lib`、`src/features/system-settings/utils`、`src/lib`、`src/stores` |
| `src/features/dashboard/components/flow` | `src/components`、`src/components/ui`、`src/features/dashboard`、`src/features/dashboard/lib`、`src/lib`、`src/stores` |
| `src/features/dashboard/components/models` | `src/components`、`src/components/ui`、`src/context`、`src/features/dashboard`、`src/features/dashboard/{hooks,lib}`、`src/features/performance-metrics`、`src/features/performance-metrics/lib`、`src/i18n`、`src/lib`、`src/stores` |
| `src/features/dashboard/components/overview` | `src/components`、`src/components/ui`、`src/features/dashboard`、`src/features/dashboard/components/ui`、`src/features/dashboard/{hooks,lib}`、`src/features/keys`、`src/features/performance-metrics`、`src/features/performance-metrics/lib`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/dashboard/components/ui` | `src/components/ui`、`src/lib` |
| `src/features/dashboard/components/users` | `src/components/ui`、`src/context`、`src/features/dashboard`、`src/features/dashboard/lib`、`src/lib` |
| `src/features/dashboard/hooks` | `src/components/ui`、`src/features/dashboard`、`src/features/dashboard/lib`、`src/hooks` |
| `src/features/dashboard/lib` | `src/features/dashboard`、`src/lib` |
| `src/features/errors` | `src/components/ui`、`src/lib` |
| `src/features/home` | `src/components`、`src/components/layout`、`src/components/layout/components`、`src/context`、`src/features/home/components`、`src/features/home/hooks`、`src/lib`、`src/stores` |
| `src/features/home/components` | `src/components/ui`、`src/features/home`、`src/features/home/components/sections`、`src/lib` |
| `src/features/home/components/sections` | `src/components`、`src/components/ui`、`src/features/home/components`、`src/hooks` |
| `src/features/home/hooks` | `src/features/home`、`src/lib` |
| `src/features/keys` | `src/components`、`src/components/layout`、`src/features/keys/components`、`src/lib` |
| `src/features/keys/components` | `src/components`、`src/components/data-table`、`src/components/data-table/core`、`src/components/ui`、`src/features/chat/{hooks,lib}`、`src/features/keys`、`src/features/keys/components/dialogs`、`src/features/keys/lib`、`src/hooks`、`src/i18n`、`src/lib` |
| `src/features/keys/components/dialogs` | `src/components`、`src/components/ui`、`src/lib` |
| `src/features/keys/lib` | `src/features/keys`、`src/lib` |
| `src/features/legal` | `src/components`、`src/components/layout`、`src/components/ui`、`src/lib` |
| `src/features/models` | `src/components/layout`、`src/components/ui`、`src/features/models/components`、`src/features/models/components/dialogs`、`src/features/models/{hooks,lib}`、`src/features/system-settings/utils`、`src/lib` |
| `src/features/models/components` | `src/components`、`src/components/data-table`、`src/components/data-table/core`、`src/components/ui`、`src/features/models`、`src/features/models/components/{dialogs,drawers}`、`src/features/models/lib`、`src/hooks`、`src/lib` |
| `src/features/models/components/dialogs` | `src/components`、`src/components/data-table`、`src/components/data-table/static`、`src/components/ui`、`src/features/models`、`src/features/models/components`、`src/features/models/components/drawers`、`src/features/models/lib`、`src/hooks`、`src/lib` |
| `src/features/models/components/drawers` | `src/components`、`src/components/ui`、`src/features/models`、`src/features/models/components`、`src/features/models/lib`、`src/features/system-settings`、`src/features/system-settings/{hooks,models,utils}` |
| `src/features/models/hooks` | `src/features/models` |
| `src/features/models/lib` | `src/features/models`、`src/lib` |
| `src/features/performance-metrics` | `src/lib` |
| `src/features/performance-metrics/lib` | （仅被依赖，无内部出边） |
| `src/features/playground` | `src/features/playground/components/{chat,input}`、`src/features/playground/hooks`、`src/lib` |
| `src/features/playground/components/chat` | `src/components/ai-elements`、`src/components/ui`、`src/features/playground`、`src/features/playground/components/message`、`src/features/playground/lib` |
| `src/features/playground/components/input` | `src/components`、`src/components/ai-elements`、`src/components/ui`、`src/features/playground`、`src/features/playground/lib`、`src/features/playground/lib/parameters`、`src/hooks`、`src/lib` |
| `src/features/playground/components/message` | `src/components/ai-elements`、`src/components/ui`、`src/features/playground`、`src/features/playground/hooks`、`src/features/playground/lib`、`src/features/playground/lib/message`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/playground/hooks` | `src/features/playground`、`src/features/playground/lib`、`src/lib` |
| `src/features/playground/lib`（barrel） | `src/features/playground/lib/{input,message,options,parameters,state,storage,streaming}` |
| `src/features/playground/lib/input` | `src/features/playground` |
| `src/features/playground/lib/message` | `src/features/playground` |
| `src/features/playground/lib/options` | `src/features/playground` |
| `src/features/playground/lib/parameters` | `src/features/playground` |
| `src/features/playground/lib/state` | `src/features/playground`、`src/features/playground/lib/storage` |
| `src/features/playground/lib/storage` | `src/features/playground`、`src/features/playground/lib/message` |
| `src/features/playground/lib/streaming` | `src/features/playground`、`src/features/playground/lib/message` |
| `src/features/pricing` | `src/components`、`src/components/layout`、`src/features/pricing/components`、`src/features/pricing/hooks`、`src/lib` |
| `src/features/pricing/components` | `src/components`、`src/components/ai-elements`、`src/components/data-table`、`src/components/layout`、`src/components/ui`、`src/context`、`src/features/performance-metrics`、`src/features/performance-metrics/lib`、`src/features/pricing`、`src/features/pricing/{hooks,lib}`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/pricing/hooks` | `src/features/pricing`、`src/features/pricing/lib`、`src/hooks` |
| `src/features/pricing/lib` | `src/features/pricing`、`src/lib` |
| `src/features/profile` | `src/components`、`src/components/layout`、`src/features/profile/components`、`src/features/profile/hooks`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/profile/components` | `src/components`、`src/components/ui`、`src/features/auth/passkey`、`src/features/auth/secure-verification`、`src/features/profile`、`src/features/profile/components/{dialogs,tabs}`、`src/features/profile/{hooks,lib}`、`src/hooks`、`src/i18n`、`src/lib`、`src/stores` |
| `src/features/profile/components/dialogs` | `src/components`、`src/components/ui`、`src/features/auth`、`src/features/profile`、`src/features/profile/hooks`、`src/hooks`、`src/lib` |
| `src/features/profile/components/tabs` | `src/assets/brand-icons`、`src/components`、`src/components/ui`、`src/features/auth`、`src/features/auth/lib`、`src/features/profile`、`src/features/profile/components/dialogs`、`src/features/profile/lib`、`src/hooks`、`src/lib` |
| `src/features/profile/hooks` | `src/features/profile`、`src/hooks`、`src/lib` |
| `src/features/profile/lib` | `src/features/profile` |
| `src/features/rankings` | `src/components`、`src/components/layout`、`src/components/ui`、`src/features/rankings/components`、`src/features/rankings/hooks`、`src/lib` |
| `src/features/rankings/components` | `src/features/rankings`、`src/features/rankings/lib`、`src/lib` |
| `src/features/rankings/hooks` | `src/features/rankings` |
| `src/features/redemption-codes` | `src/components`、`src/components/layout`、`src/features/redemption-codes/components`、`src/lib` |
| `src/features/redemption-codes/components` | `src/components`、`src/components/data-table`、`src/components/data-table/core`、`src/components/ui`、`src/features/redemption-codes`、`src/features/redemption-codes/lib`、`src/hooks`、`src/lib` |
| `src/features/redemption-codes/lib` | `src/features/redemption-codes`、`src/lib` |
| `src/features/setup` | `src/components`、`src/components/ui`、`src/features/setup/components`、`src/hooks`、`src/lib` |
| `src/features/setup/components` | `src/components`、`src/components/ui`、`src/features/setup`、`src/lib` |
| `src/features/subscriptions` | `src/components/layout`、`src/components/ui`、`src/features/subscriptions/components`、`src/lib` |
| `src/features/subscriptions/components` | `src/components`、`src/components/data-table`、`src/components/ui`、`src/features/subscriptions`、`src/features/subscriptions/components/dialogs`、`src/features/subscriptions/lib`、`src/features/system-settings/hooks`、`src/hooks`、`src/lib` |
| `src/features/subscriptions/components/dialogs` | `src/components`、`src/components/data-table`、`src/components/ui`、`src/features/subscriptions`、`src/features/subscriptions/components`、`src/features/subscriptions/lib`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/subscriptions/lib` | `src/features/subscriptions`、`src/lib` |
| `src/features/system-info` | `src/components/layout`、`src/components/ui`、`src/features/system-info/components`、`src/lib` |
| `src/features/system-info/components` | `src/components`、`src/components/ui`、`src/features/system-info`、`src/features/system-settings`、`src/i18n`、`src/lib` |
| `src/features/system-settings` | `src/lib` |
| `src/features/system-settings/auth` | `src/components`、`src/components/ui`、`src/features/system-settings`、`src/features/system-settings/auth/custom-oauth`、`src/features/system-settings/components`、`src/features/system-settings/hooks`、`src/features/system-settings/utils` |
| `src/features/system-settings/auth/custom-oauth` | `src/components`、`src/components/ui`、`src/features/system-settings/auth`、`src/features/system-settings/auth/custom-oauth/{components,hooks}`、`src/features/system-settings/components`、`src/lib` |
| `src/features/system-settings/auth/custom-oauth/components` | `src/components`、`src/components/data-table/core`、`src/components/data-table/static`、`src/components/ui`、`src/features/system-settings/auth`、`src/features/system-settings/auth/custom-oauth`、`src/features/system-settings/auth/custom-oauth/hooks`、`src/features/system-settings/components` |
| `src/features/system-settings/auth/custom-oauth/hooks` | `src/features/system-settings/auth/custom-oauth` |
| `src/features/system-settings/billing` | `src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/{general,integrations,models}`、`src/features/system-settings/utils`、`src/lib` |
| `src/features/system-settings/components` | `src/components`、`src/components/layout`、`src/components/ui`、`src/features/system-settings`、`src/features/system-settings/hooks`、`src/lib` |
| `src/features/system-settings/content` | `src/components`、`src/components/data-table/{core,static}`、`src/components/ui`、`src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/{hooks,utils}`、`src/lib` |
| `src/features/system-settings/general` | `src/components/ui`、`src/features/system-settings/components`、`src/features/system-settings/{hooks,utils}`、`src/lib`、`src/stores` |
| `src/features/system-settings/general/channel-affinity` | `src/components`、`src/components/data-table`、`src/components/ui`、`src/features/system-settings/components`、`src/features/system-settings/hooks`、`src/lib` |
| `src/features/system-settings/hooks` | `src/features/system-settings`、`src/features/system-settings/utils` |
| `src/features/system-settings/integrations` | `src/components`、`src/components/data-table/static`、`src/components/ui`、`src/features/models`、`src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/{hooks,utils}`、`src/features/wallet`、`src/features/wallet/lib`、`src/lib` |
| `src/features/system-settings/maintenance` | `src/components`、`src/components/ui`、`src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/{hooks,utils}`、`src/lib` |
| `src/features/system-settings/models` | `src/components`、`src/components/data-table`、`src/components/data-table/{core,static}`、`src/components/ui`、`src/features/channels`、`src/features/pricing/lib`、`src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/general/channel-affinity`、`src/features/system-settings/{hooks,integrations,utils}`、`src/hooks`、`src/lib` |
| `src/features/system-settings/operations` | `src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/{general,integrations,maintenance}`、`src/features/system-settings/utils`、`src/hooks` |
| `src/features/system-settings/request-limits` | `src/components`、`src/components/data-table/static`、`src/components/ui`、`src/features/system-settings/components`、`src/features/system-settings/{hooks,utils}` |
| `src/features/system-settings/security` | `src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/request-limits`、`src/features/system-settings/utils` |
| `src/features/system-settings/site` | `src/features/system-settings`、`src/features/system-settings/components`、`src/features/system-settings/{general,maintenance}`、`src/features/system-settings/utils` |
| `src/features/usage-logs` | `src/components`、`src/components/layout`、`src/components/ui`、`src/features/system-settings/general/channel-affinity`、`src/features/system-settings/utils`、`src/features/usage-logs/components`、`src/features/usage-logs/components/dialogs`、`src/features/usage-logs/{data,lib}`、`src/hooks`、`src/lib` |
| `src/features/usage-logs/components` | `src/components`、`src/components/data-table`、`src/components/ui`、`src/features/usage-logs`、`src/features/usage-logs/{data,lib}`、`src/hooks`、`src/lib` |
| `src/features/usage-logs/components/columns` | `src/components`、`src/components/data-table`、`src/components/ui`、`src/features/usage-logs`、`src/features/usage-logs/components`、`src/features/usage-logs/components/dialogs`、`src/features/usage-logs/{data,lib}`、`src/lib` |
| `src/features/usage-logs/components/dialogs` | `src/components`、`src/components/ui`、`src/features/pricing/components`、`src/features/usage-logs`、`src/features/usage-logs/{data,lib}`、`src/hooks`、`src/lib` |
| `src/features/usage-logs/data` | （数据 schema，无内部出边） |
| `src/features/usage-logs/lib` | `src/components`、`src/features/pricing/lib`、`src/features/usage-logs`、`src/features/usage-logs/components/columns`、`src/features/usage-logs/data` |
| `src/features/users` | `src/components/layout`、`src/features/users/components`、`src/lib` |
| `src/features/users/components` | `src/components`、`src/components/data-table`、`src/components/data-table/core`、`src/components/ui`、`src/features/subscriptions/components/dialogs`、`src/features/users`、`src/features/users/components/dialogs`、`src/features/users/lib`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/users/components/dialogs` | `src/components`、`src/components/ui`、`src/features/users`、`src/lib` |
| `src/features/users/lib` | `src/features/users`、`src/lib` |
| `src/features/wallet` | `src/components/layout`、`src/features/wallet/components`、`src/features/wallet/components/dialogs`、`src/features/wallet/{hooks,lib}`、`src/hooks`、`src/lib` |
| `src/features/wallet/components` | `src/components`、`src/components/ui`、`src/features/subscriptions`、`src/features/subscriptions/components/dialogs`、`src/features/subscriptions/lib`、`src/features/wallet`、`src/features/wallet/lib`、`src/lib` |
| `src/features/wallet/components/dialogs` | `src/components`、`src/components/ui`、`src/features/wallet`、`src/features/wallet/{hooks,lib}`、`src/hooks`、`src/lib`、`src/stores` |
| `src/features/wallet/hooks` | `src/features/wallet`、`src/features/wallet/lib`、`src/hooks`、`src/lib` |
| `src/features/wallet/lib` | `src/components`、`src/features/wallet`、`src/lib` |

> 说明：`src/features/{performance-metrics/lib, usage-logs/data, i18n}` 等为纯被依赖叶子，无内部出边，仅出现在第 2 节的消费者列表中。

## 2. 枢纽模块及其主要消费者

> 枢纽判定：被 ≥ 5 个内部模块直接依赖（广泛依赖），或承载跨模块复用的核心契约（关键 Context/Store/类型/桶导出）。消费者按模块级去重计数，多时列代表性模块并注明"等 N 个"。

| 枢纽模块 | 主要消费者（内部） | 为何是枢纽 |
| --- | --- | --- |
| `src/lib` | `src/features/*`（几乎所有特性根、components、hooks、lib）、`src/components/*`、`src/hooks`、`src/stores`、`src/context`、`src/routes/*` 等 119 个模块 | 广泛依赖：项目级工具与基础设施桶（HTTP 客户端、权限/角色、会话、缓存、错误处理、主题、时间、格式化、Passkey、OAuth、导航模块等） |
| `src/components/ui` | `src/components/*`、`src/features/*/components`（几乎所有）、`src/features/*/components/dialogs`、`src/features/*/{hooks,lib}`、`src/routes/_authenticated/*` 等 75 个模块 | 广泛依赖：shadcn/ui 风格原子组件桶（button/dialog/drawer/tabs/table/tooltip 等 60+ 组件） |
| `src/components`（barrel） | `src/features/*/components`、`src/components/{data-table,layout}/*`、`src/routes/*` 等 64 个模块（按 `@/components` 及子路径归约） | 广泛依赖：跨特性通用展示/交互组件桶（确认框、复制按钮、状态徽章、空/错/加载态、命令菜单等） |
| `src/hooks` | `src/features/*/components`、`src/features/*/hooks`、`src/components/*`、`src/routes/*` 等 47 个模块 | 广泛依赖：跨特性通用 React Hooks（侧边栏、通知、对话框、移动端、查询、系统配置等） |
| `src/stores` | `src/features/*`（auth/channels/keys/playground/pricing/profile/users/wallet 等）、`src/hooks`、`src/lib`、`src/routes/*` 等 41 个模块 | 广泛依赖：Zustand 全局状态（auth-store / notification-store / system-config-store） |
| `src/components/layout` | `src/features/*`（about/dashboard/home/keys/legal/models/pricing/rankings/redemption-codes/subscriptions/system-info/system-settings/usage-logs/users/wallet）、`src/routes/_authenticated`、`src/routes/_authenticated/{errors,playground}` 等 25 个模块 | 广泛依赖：页面外壳布局（authenticated-layout、页眉/侧边栏/页脚/导航/品牌） |
| `src/features/auth` | `src/features/{channels,chat,keys,profile,users}/components`、`src/features/chat/hooks`、`src/features/{passkey,secure-verification}`、`src/hooks`、`src/routes/{(auth),oauth,_authenticated}` 等 20 个模块 | 核心契约 + 广泛依赖：认证总入口（登录态、OAuth、Passkey、安全验证），被多特性跨域引用 |
| `src/features/system-settings/utils` | `src/features/system-settings/{auth,billing,content,general,integrations,maintenance,models,operations,security,site,request-limits}`、`src/features/system-settings/hooks`、`src/features/{dashboard,models,usage-logs}` 等 17 个模块 | 广泛依赖：系统设置跨分区公共工具（分区注册表、JSON 解析校验、数值字段、路由配置），并被外部特性引用 |
| `src/features/system-settings/components` | `src/features/system-settings/{auth,auth/custom-oauth,billing,content,general,general/channel-affinity,integrations,maintenance,models,operations,request-limits,security,site}`、`src/features/system-info/components` 等 14 个模块 | 广泛依赖：系统设置通用组件（设置页容器、分区页、表单布局、手风琴、导航守卫） |
| `src/features/system-settings` | `src/features/system-settings/*`（全部子分区）、`src/features/{models/system-settings, system-info/components, usage-logs}`、`src/routes/_authenticated/system-settings/*` 等 14 个模块 | 核心契约：系统设置聚合入口（全局 API 与类型），被所有分区及外部特性依赖 |
| `src/components/data-table`（barrel） | `src/features/{channels,keys,models,pricing,redemption-codes,subscriptions,usage-logs,users,wallet}/components`、`src/features/system-settings/{auth/custom-oauth/components,content,models,general/channel-affinity}` 等 14 个模块 | 核心契约 + 广泛依赖：数据表格桶导出（聚合 core/hooks/layout/static/toolbar） |
| `src/features/playground` | `src/features/playground/{components/{chat,input,message},hooks,lib/*}`、`src/routes/_authenticated/playground` 等 12 个模块 | 核心契约：Playground 总入口（API、类型、常量），被其全部子层引用 |
| `src/components/data-table/core` | `src/components/{data-table/layout,data-table/static}`、`src/features/{channels,keys,models,redemption-codes,usage-logs/users,wallet}/components`、`src/features/system-settings/{auth/custom-oauth/components,content,models}` 等 12 个模块 | 核心契约：数据表格内核（表格视图、分页、行操作、列定义），实现 `@tanstack/react-table` 契约 |
| `src/features/system-settings/hooks` | `src/features/system-settings/{auth,auth/custom-oauth,billing,content,general,general/channel-affinity,integrations,maintenance,models,operations,request-limits}`、`src/features/{models/components/drawers,subscriptions/components}` 等 11 个模块 | 广泛依赖：系统设置通用 Hooks（选项更新、表单脏检测、手风琴状态、表单管理） |
| `src/context` | `src/components/ui`、`src/features/{dashboard/components/models,pricing/components,home,profile/components}`、`src/features/dashboard/components/users`、`src/lib`、`src/routes` 等 11 个模块 | 核心契约 + 广泛依赖：全局 Provider（主题、字体、布局、主题定制、搜索、文本方向） |
| `src/features/auth/lib` | `src/features/auth/{components,hooks,lib,otp/components,sign-in/components,sign-up/components}`、`src/features/profile/components/tabs`、`src/routes/{(auth),oauth}` 等 9 个模块 | 广泛依赖：认证工具（OAuth、Telegram、绑定窗口、回调模式、重定向、校验） |
| `src/features/channels` | `src/features/{channels/components,channels/components/dialogs,channels/components/drawers,channels/hooks,channels/lib}`、`src/features/system-settings/models`、`src/routes/_authenticated/channels` 等 8 个模块 | 核心契约：渠道总入口（API、类型、常量），被渠道子层与系统设置-模型分区引用 |
| `src/features/models` | `src/features/models/{components,components/dialogs,components/drawers,hooks,lib}`、`src/features/system-settings/integrations`、`src/routes/_authenticated/models` 等 7 个模块 | 核心契约：模型管理总入口（API、类型、常量、区块注册） |
| `src/features/keys` | `src/features/keys/{components,components/dialogs,lib}`、`src/features/chat/{hooks,lib}`、`src/features/dashboard/components/overview`、`src/routes/_authenticated/keys` 等 7 个模块 | 核心契约：API 令牌管理总入口（API、类型、常量） |
| `src/features/dashboard` | `src/features/dashboard/components/{flow,models,overview,ui,users}`、`src/features/dashboard/{hooks,lib}`、`src/routes/_authenticated/dashboard` 等 7 个模块 | 核心契约：仪表盘总入口（API、类型、常量、默认筛选） |
| `src/components/data-table/static` | `src/components/data-table/layout`、`src/features/{models,usage-logs}/components`、`src/features/models/components/dialogs`、`src/features/system-settings/{auth/custom-oauth/components,content,integrations,models,request-limits}` 等 7 个模块 | 广泛依赖：静态（非服务端分页）数据表格实现 |
| `src/i18n` | `src/components`、`src/features/{channels/components,pricing/hooks,profile/components,system-info/components}`、`src/features/dashboard/components/models 等 6 个模块 | 广泛依赖：i18next 初始化、语言列表与静态键（en/zh/zh-TW/fr/ja/ru/vi） |
| `src/features/wallet` | `src/features/wallet/{components,components/dialogs,hooks,lib}`、`src/features/system-settings/integrations`、`src/routes/_authenticated/wallet` 等 6 个模块 | 核心契约：钱包总入口（API、类型、常量） |
| `src/features/usage-logs` | `src/features/usage-logs/{components,components/columns,components/dialogs,data,lib}`、`src/routes/_authenticated/usage-logs` 等 6 个模块 | 核心契约：用量日志总入口（API、类型、常量、区块注册） |
| `src/features/profile` | `src/features/profile/{components,components/dialogs,components/tabs,hooks,lib}`、`src/routes/_authenticated/profile` 等 6 个模块 | 核心契约：个人中心总入口（API、类型、常量） |
| `src/features/dashboard/lib` | `src/features/dashboard/components/{flow,models,overview,users}`、`src/features/dashboard/hooks`、`src/features/dashboard` 等 6 个模块 | 广泛依赖：仪表盘业务工具（过滤器、统计、格式化、流量处理） |
| `src/features/auth/hooks` | `src/features/auth/{components,forgot-password/components,otp/components,sign-in/components,sign-up/components}`、`src/features/auth` 等 6 个模块 | 广泛依赖：认证通用 Hooks（邮件验证、登录重定向、OAuth、Turnstile） |
| `src/features/auth/components` | `src/features/auth`、`src/features/auth/{sign-in,sign-up}`、`src/routes/oauth` 等 6 个模块 | 广泛依赖：跨认证子流程复用的公共组件（OAuth 提供商、Telegram、法律同意、回调屏） |
