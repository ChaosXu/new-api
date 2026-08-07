# 如何写一个新的 web feature

> 适用：新增一个业务功能模块（如 `announcements` 公告管理）。23 个现有 feature 都遵循此范式。feature = 一组协同的业务页面（列表/表单/对话框）+ 其 API/类型/常量。

## 代码范式

### 目录与四件套

新建 `web/src/features/<feature>/`，核心四件套：

```
web/src/features/<feature>/
├── api.ts           # 后端 API 调用函数（CRUD）
├── types.ts         # 实体类型（zod schema + 推导类型）
├── constants.ts     # 状态枚举、列定义、配置常量
├── index.tsx        # feature 主入口组件（页面装配）
├── components/      # UI 组件（表格、对话框、表单、按钮）
│   ├── <feature>-table.tsx
│   ├── <feature>-dialogs.tsx
│   └── <feature>-provider.tsx
└── lib/             # 业务工具（校验、映射）——简单 feature 可省
```

### api.ts 范式

```typescript
import { api } from '@/lib/api'   // api 是 axios 实例，定义在 lib/http-client.ts
import type { Xxx, ApiResponse, GetXxxParams } from './types'

export async function getXxxList(params: GetXxxParams = {}): Promise<GetXxxResponse> {
  const { p = 1, page_size = 10 } = params
  const res = await api.get(`/api/xxx/?p=${p}&page_size=${page_size}`)
  return res.data
}

export async function createXxx(data: XxxFormData): Promise<ApiResponse<Xxx>> {
  const res = await api.post('/api/xxx/', data)
  return res.data
}
```

**要点**：
- `api` 来自 `@/lib/api`（re-export 自 `@/lib/http-client` 的 axios 实例，已配拦截器/错误处理）
- 每个函数显式标注返回类型（从 `./types` 导入）
- 路径形如 `/api/<resource>/?p=&page_size=`

### types.ts 范式

```typescript
import { z } from 'zod'

// zod schema 定义实体，推导出 TS 类型
export const xxxSchema = z.object({
  id: z.number(),
  name: z.string(),
  status: z.number(),
})
export type Xxx = z.infer<typeof xxxSchema>

// 表单数据类型
export type XxxFormData = Omit<Xxx, 'id' | 'created_at'>

// API 响应类型
export type ApiResponse<T> = { data: T; success: boolean; message?: string }
```

### index.tsx 范式（页面装配）

```tsx
import { useTranslation } from 'react-i18next'
import { SectionPageLayout } from '@/components/section-page-layout'  // 统一页面骨架
import { XxxTable } from './components/xxx-table'
import { XxxDialogs } from './components/xxx-dialogs'
import { XxxProvider } from './components/xxx-provider'  // Context 共享弹窗状态

export function Xxx() {
  const { t } = useTranslation()
  return (
    <XxxProvider>
      <SectionPageLayout fixedContent>
        <SectionPageLayout.Title>{t('Xxx Management')}</SectionPageLayout.Title>
        <SectionPageLayout.Actions><XxxPrimaryButtons /></SectionPageLayout.Actions>
        <SectionPageLayout.Content><XxxTable /></SectionPageLayout.Content>
      </SectionPageLayout>
      <XxxDialogs />
    </XxxProvider>
  )
}
```

### 路由注册

feature 写完后，在 `web/src/routes/_authenticated/<feature>/index.tsx` 注册路由（TanStack Router 文件式路由）：

```tsx
import { createFileRoute, redirect } from '@tanstack/react-router'
import { xxxRoute } from '@/features/<feature>'  // 或直接 import 组件

export const Route = createFileRoute('/_authenticated/<feature>/')({
  component: Xxx,
  beforeLoad: () => { /* 鉴权检查 */ }
})
```

文件式路由会自动被 `routeTree.gen.ts` 采集，无需手动注册到路由表。

## 关键契约

| 契约 | 来源 | 用法 |
| --- | --- | --- |
| `api`（axios 实例） | `@/lib/api`（定义于 `lib/http-client.ts:44`） | `api.get/post/put/delete`，返回 `res.data` |
| `SectionPageLayout` | `@/components/section-page-layout` | 列表页统一骨架（Title/Actions/Content 插槽） |
| data-table | `@/components/data-table` | 列表表格（core/hooks/toolbar/layout 子模块） |
| `useQuery`/`useMutation` | `@tanstack/react-query` | 服务端状态管理（查询/变更/缓存） |
| Zustand store | `@/stores/*` | 全局状态（鉴权/通知/系统配置） |

## 项目约束（摘自 AGENTS.md + web/AGENTS.md）

- **i18n**：所有用户可见文案必须用 `t('English key')`（`useTranslation()`）。英文是 key，翻译写入 `web/src/i18n/locales/{lang}.json`。
- **包管理器**：用 `bun`（`bun install`/`bun run dev`/`bun run build`），不用 npm/yarn/pnpm。
- **组件库**：用 Base UI + Tailwind（`components/ui/` 的 shadcn 原子组件），不自造轮子。
- **版权头**：每个源码文件必须有 QuantumNous 的 AGPL 版权头（见现有文件，**受保护信息，不得删除**）。
- **类型安全**：用 TypeScript strict 模式；实体类型用 zod schema 推导；禁用 `any`。

## 样板指针

写新 feature 前，先读这 1-2 个真实 feature：

| feature 复杂度 | 仿写 |
| --- | --- |
| 简单（列表 + CRUD 对话框，无复杂表单） | `web/src/features/redemption-codes/`（四件套清晰，结构典型） |
| 复杂（data-table + 多种对话框 + 编辑抽屉 + 子分区） | `web/src/features/channels/`（含 components/dialogs/drawers/hooks/lib） |
| 含分区注册（仪表盘式的多 section） | `web/src/features/dashboard/`（section-registry 模式） |

**最简起步**：复制 `features/redemption-codes/` 整套，改 feature 名、API 路径、实体类型，再在 `routes/_authenticated/<feature>/index.tsx` 注册路由。用 `bun run dev` 验证页面可访问。
