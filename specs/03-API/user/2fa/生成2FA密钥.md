# 生成 2FA 密钥

> `POST /api/user/2fa/setup`

- **鉴权**：`UserAuth`，附加 `DisableCache`
- **用途**：初始化 2FA 设置，生成 TOTP 密钥、二维码数据与备用码（此时 2FA 尚未启用，需调用「启用 2FA」收尾）。

## 请求

无 Body（已启用 2FA 时会拒绝）。

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 提示扫描二维码并输入验证码完成设置 |
| data.secret | string | TOTP 密钥（Base32） |
| data.qr_code_data | string | otpauth URI，用于生成二维码 |
| data.backup_codes | string[] | 一次性备用码列表 |

```json
{
  "success": true,
  "message": "2FA设置初始化成功，请使用认证器扫描二维码并输入验证码完成设置",
  "data": {
    "secret": "JBSWY3DPEHPK3PXP",
    "qr_code_data": "otpauth://totp/new-api:alice?secret=JBSWY3DPEHPK3PXP&issuer=new-api",
    "backup_codes": ["abc12345", "def67890", "..."]
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 已启用 2FA | `用户已启用2FA，请先禁用后重新设置` |
| 生成密钥失败 | `生成2FA密钥失败` |
| 生成备用码失败 | `生成备用码失败` |
| 保存备用码失败 | `保存备用码失败` |
