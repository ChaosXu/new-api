# 自定义 OAuth 提供商

路由前缀：`/api/custom-oauth-provider`，全部需要 RootAuth（超级管理员）。用于管理接入的第三方 OIDC/OAuth 提供商。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
| --- | --- | --- | --- |
| OAuth发现.md | POST | /api/custom-oauth-provider/discovery | 获取 OIDC discovery 文档 |
| 自定义OAuth列表.md | GET | /api/custom-oauth-provider/ | 列出全部提供商 |
| 获取自定义OAuth.md | GET | /api/custom-oauth-provider/:id | 获取单个提供商 |
| 创建自定义OAuth.md | POST | /api/custom-oauth-provider/ | 创建提供商 |
| 更新自定义OAuth.md | PUT | /api/custom-oauth-provider/:id | 更新提供商 |
| 删除自定义OAuth.md | DELETE | /api/custom-oauth-provider/:id | 删除提供商 |
