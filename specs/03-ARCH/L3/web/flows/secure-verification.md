# 敏感操作二次验证

> 用户执行敏感操作（如查看渠道密钥）时，后端返回 403 要求二次验证，前端弹出安全验证对话框，用户以 2FA OTP 或 Passkey 完成 Security Proof，获取 `proof_token` 后携带 `X-Security-Proof` 头重试敏感 API。跨敏感操作消费方、二次验证模块、HTTP 底座协作。

## 时序图

```mermaid
sequenceDiagram
    autonumber
    participant User
    participant Consumer as 敏感操作消费方
    participant Verify as 敏感操作二次验证
    participant AuthBase as HTTP 与认证会话底座
    participant Backend as 后端

    Note over User,Consumer: 阶段 A：触发敏感操作
    User->>Consumer: 点"查看渠道密钥"（channel.key.read 作用域）
    Consumer->>Verify: withVerification(fetchChannelKey, {scope, preferredMethod:'passkey'})

    Note over Consumer,Backend: 阶段 B：尝试直接调用
    Verify->>AuthBase: apiCall()（POST /api/channel/{id}/key）
    AuthBase->>Backend: 不带 proof 头
    Backend-->>AuthBase: 403 + verification required code
    AuthBase-->>Verify: isVerificationRequiredError=true
    Verify->>User: toast.info（需二次验证）

    Note over Verify,Backend: 阶段 C：检查可用验证方式
    Verify->>AuthBase: checkVerificationMethods（并行 get2FAStatus + getPasskeyStatus + detectPasskeySupport）
    alt 无任何方式
        Verify->>User: toast.error 并中止
    end

    Note over Verify,User: 阶段 D：弹出对话框
    Verify->>User: 渲染 SecureVerificationDialog（默认 passkey，否则 2fa Tab）

    Note over User,Backend: 阶段 E：用户验证
    User->>Verify: 输入 2FA OTP 或完成 Passkey 断言
    alt 2FA
        Verify->>AuthBase: verifyTwoFA（POST /api/verify {method:'2fa', code, scope}）
    else Passkey
        Verify->>AuthBase: beginPasskeyVerification(scope)
        AuthBase->>User: navigator.credentials.get
        User-->>AuthBase: assertion
        AuthBase->>Backend: finishPasskeyVerification(flowToken, assertion)
    end
    Backend-->>AuthBase: proof_token

    Note over Consumer,Backend: 阶段 F：用 proof_token 调敏感 API
    Verify->>Consumer: state.apiCall(proof_token)
    Consumer->>AuthBase: fetchChannelKey(proofToken)
    AuthBase->>Backend: POST /api/channel/{id}/key（X-Security-Proof: proofToken）
    Backend-->>AuthBase: 渠道明文密钥
    AuthBase-->>Consumer: setChannelKey

    Note over Consumer,User: 阶段 G：成功展示
    Consumer->>User: 展示明文密钥
    Verify->>Verify: autoReset 清理状态
```

## 流程说明

1. **触发敏感操作**（`channel-mutate-drawer.tsx:3032`）：用户点"查看密钥"，`handleRevealKey`（行 1378）调 `withVerification(fetchChannelKey, { scope: 'channel.key.read', preferredMethod: 'passkey', title, description })`。
2. **尝试直接调用**（`withVerification`，`use-secure-verification.ts:199`）：先尝试 `apiCall()`；若抛出 `isVerificationRequiredError`（403 + 特定 code，`lib/secure-verification.ts:30`），`toast.info` 后进入 `startVerification`。这是**被动验证模式**——先试调，遇 403 再验证。另有主动验证模式（直接 `startVerification`）。
3. **检查可用验证方式**（`startVerification` 行 82）：`fetchVerificationMethods` → `checkVerificationMethods`（`api.ts:44`）并行 `get2FAStatus` + `getPasskeyStatus` + `detectPasskeySupport`。若无任何方式则 `toast.error` 并 return false。
4. **弹出对话框**：选默认 method（passkey 优先，否则 2fa），`setOpen(true)`，`SecureVerificationDialog` 渲染对应 Tab。
5. **用户验证**（`handleVerify`，`dialog.tsx:78`）：点 Verify → `onVerify(method, code)` → `executeVerification`（`use-secure-verification.ts:135`）→ `verify(method, scope, code)`（`api.ts:78`）。2FA 走 `POST /api/verify`；Passkey 走 `beginPasskeyVerification`(scope) → `navigator.credentials.get` → `finishPasskeyVerification`。两者均返回 `proof_token`。
6. **用 proof_token 调敏感 API**（行 159）：`state.apiCall(proof.proof_token)` → `fetchChannelKey(proofToken)`（行 1354）→ `getChannelKey(channelId, proofToken)`（`channels/api.ts:296`，`POST /api/channel/{id}/key`，带 `X-Security-Proof: proofToken` 头）→ 成功 `setChannelKey`。
7. **成功/失败**：`onSuccess` 触发，`autoReset` 清理；失败 `toast.error`。

## 涉及的 L3 逻辑模块

| 阶段 | 逻辑模块 | 模块文件 |
| --- | --- | --- |
| 触发敏感操作 | 渠道管理 | [../modules/admin-channels/channels.md](../modules/admin-channels/channels.md) |
| 二次验证编排/对话框/proof 获取 | 敏感操作二次验证 | [../modules/auth/secure-verification.md](../modules/auth/secure-verification.md) |
| HTTP 请求/错误识别 | HTTP 与认证会话底座 | [../modules/infra/http-auth-base.md](../modules/infra/http-auth-base.md) |
| Passkey 编解码 | OAuth 与 Passkey 免密登录 | [../modules/auth/oauth-passkey.md](../modules/auth/oauth-passkey.md) |

## 项目约束（若有）

- **proof_token 透传契约**：`verify` 返回的 `proof_token` 必须经消费方放入 `X-Security-Proof` 请求头传给后端敏感 API，不得放入 URL 或 body。
- **真实消费方说明**：当前 secure-verification 的真实消费方是渠道密钥查看（`channel-mutate-drawer` 的 `getChannelKey`）与 Passkey 注册/删除（`passkey-card`）。API Key 明文查询（`fetchTokenKey`）走独立的批量缓存机制（`useRevealTokenKey`），不经过本二次验证流程。
- 支持**主动验证**（直接 `startVerification`）与**被动验证**（`withVerification` 先试调遇 403 再验证）两种触发模式。
