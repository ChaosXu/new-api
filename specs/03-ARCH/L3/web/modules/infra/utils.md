# 通用工具库

## 职责

与框架/业务无关的纯函数工具底座：格式化（数字/日期/货币/内容）、剪贴板、权限角色、第三方认证编解码、Cookie/DOM/缓存、图标与渠道连接信息编解码、全局常量。

## 契约（开放能力）

- **格式化能力**：数字/日期/货币格式化（含 USD↔本地币↔Token 三方换算与价格比率）、HTTP/HTML 内容探测、Unix 时间与粒度处理、dayjs 插件装配
- **剪贴板能力**：Clipboard API + execCommand 降级复制
- **权限与角色能力**：管理员权限矩阵类型与资源/动作目录、用户角色常量（SUPER_ADMIN/ADMIN/USER/GUEST）与本地化标签
- **第三方认证编解码能力**：GitHub/Discord/OIDC OAuth URL 构造、WebAuthn 凭据的 base64url↔ArrayBuffer 编解码与选项规范化
- **Cookie/DOM/缓存能力**：Cookie 读写删、favicon 注入、前端缓存版本清理、构建元数据多通道注入
- **可视化辅助能力**：用户头像配色生成、渠道连接信息编解码、Lobe 图标解析、语义颜色映射、VChart 选项、动画 transition/variants
- **通用工具能力**：类名合并（cn）、sleep、分页、截断、JSON 美化、CSS 变量名清洗

## 覆盖代码

`web/src/lib/format.ts`、`web/src/lib/currency.ts`、`web/src/lib/content-format.ts`、`web/src/lib/time.ts`、`web/src/lib/dayjs.ts`、`web/src/lib/copy-to-clipboard.ts`、`web/src/lib/admin-permissions.ts`、`web/src/lib/roles.ts`、`web/src/lib/oauth.ts`、`web/src/lib/passkey.ts`、`web/src/lib/cookies.ts`、`web/src/lib/dom-utils.ts`、`web/src/lib/frontend-cache.ts`、`web/src/lib/build-metadata.ts`、`web/src/lib/avatar.ts`、`web/src/lib/channel-connection-info.ts`、`web/src/lib/constants.ts`、`web/src/lib/utils.ts`、`web/src/lib/colors.ts`、`web/src/lib/vchart.ts`、`web/src/lib/lobe-icon.tsx`、`web/src/lib/use-chart-theme.ts`

## 依赖（内部逻辑模块）

- 无（被广泛依赖的基础设施）
