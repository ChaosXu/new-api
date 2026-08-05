# 上传Discord图片
> `POST /mj/submit/upload-discord-images`
- **鉴权**：TokenAuth + Distribute
- **用途**：上传图片到 Discord（Midjourney 后端），返回 Discord 附件 URL，供后续 `imagine`/`blend`/`describe` 引用。

## 请求
请求体（图片列表），示例：
```json
{ "base64Array": ["data:image/png;base64,iVBORw0KG..."] }
```

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `base64Array` | []string | 是 | 待上传图片的 Base64 数组 |

## 响应
返回 `MidjourneyUploadResponse`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `code` | int | `1` 成功 |
| `description` | string | 描述 |
| `result` | []string | Discord 附件 URL 列表 |

## 错误
见 README 错误格式。
