# 使用 Passkey 通行密钥登录

## 摘要

让访客使用已绑定的 Passkey（通行密钥）无密码登录，获得便捷且高安全的登录体验。

## 用例：
- **作为** 访客
- **我想要** 使用设备上的 Passkey 通行密钥登录账号
- **以便** 我无需输入密码即可快速、安全地登录，避免密码泄露风险

## 验收标准：

### 场景：访客发起 Passkey 登录
- **假设：** 站点已启用 Passkey（passkey 设置开启）
- **而且假设：** 访客的账号已绑定 Passkey 凭证
- **当：** 访客请求 `POST /api/user/passkey/login/begin`（`controller/passkey.go` `PasskeyLoginBegin`）
- **则：** 系统返回 Passkey 断言（authentication）挑战选项，供浏览器调用 authenticator

### 场景：访客完成 Passkey 登录
- **假设：** 访客已在设备上完成生物识别/ PIN 验证并获得凭据断言
- **当：** 访客提交 `POST /api/user/passkey/login/finish`（`controller/passkey.go` `PasskeyLoginFinish`）携带断言凭据
- **则：** 系统验证凭据通过后创建登录会话，返回访问令牌与会话信息，登录成功并记录审计日志（method=passkey）
