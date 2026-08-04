# 管理 Passkey 通行密钥

## 摘要

让普通用户注册或删除 Passkey 通行密钥，实现无密码的安全登录方式。

## 用例：
- **作为** 普通用户
- **我想要** 为账号注册或删除 Passkey 通行密钥
- **以便** 我能使用设备生物识别快速安全地登录，并在不再需要时移除

## 验收标准：

### 场景：用户查看 Passkey 状态
- **假设：** 用户已登录
- **当：** 用户请求 `GET /api/user/passkey`（`controller/passkey.go` `PasskeyStatus`）
- **则：** 返回 Passkey 是否已注册及最后使用时间

### 场景：用户注册 Passkey
- **假设：** 管理员已启用 Passkey 功能
- **而且假设：** 若用户已开启 2FA，需先完成安全验证（step-up）
- **当：** 用户依次调用 `POST /api/user/passkey/register/begin`（`PasskeyRegisterBegin`）和 `POST /api/user/passkey/register/finish`（`PasskeyRegisterFinish`）
- **则：** 系统完成 Passkey 凭证注册，推进 auth version 并下发新令牌

### 场景：用户删除 Passkey
- **假设：** 用户已注册 Passkey
- **而且假设：** 用户通过安全验证（2FA 或 Passkey 本身）
- **当：** 用户提交 `DELETE /api/user/passkey`（`PasskeyDelete`）
- **则：** 系统删除该用户的 Passkey 凭证
