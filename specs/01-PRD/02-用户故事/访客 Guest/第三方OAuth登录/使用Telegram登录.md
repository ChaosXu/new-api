# 使用 Telegram 登录

## 摘要

让访客通过 Telegram 账号登录或注册站点，为 Telegram 用户提供原生便捷的接入方式。

## 用例：
- **作为** 访客
- **我想要** 使用 Telegram 账号登录或注册站点
- **以便** 我能以惯用的 Telegram 身份快速接入，无需另建账号

## 验收标准：

### 场景：访客使用 Telegram 登录
- **假设：** 站点已启用 Telegram 登录（`TelegramOAuthEnabled`）
- **而且假设：** 访客已在 Telegram 中授权并通过校验
- **当：** 访客访问 `GET /api/oauth/telegram/login`（`controller/telegram.go` `TelegramLogin`）
- **则：** 系统校验 Telegram 登录数据，找到或创建用户后创建登录会话，返回访问令牌，登录成功（method=telegram）
