# 获取 Uptime 监控状态

> `GET /api/uptime/status`

- **鉴权**：无（公开接口）
- **用途**：聚合 Uptime Kuma 监控分组的状态数据（每个分类下的监控项名称、可用率、当前状态），用于面板的可用性展示。

## 请求

无参数。

## 响应

标准信封 `{success, message, data}`。`data` 为分类结果数组，元素结构如下：

`UptimeGroupResult`：

| 字段 | 类型 | 说明 |
|---|---|---|
| categoryName | string | 分类名称 |
| monitors | array | 监控项列表 |

`Monitor`（monitors 元素）：

| 字段 | 类型 | 说明 |
|---|---|---|
| name | string | 监控项名称 |
| uptime | float | 24 小时可用率（百分比，如 99.9） |
| status | int | 最新心跳状态（来自 Uptime Kuma） |
| group | string | 监控所属分组名（可省略） |

```json
{
  "success": true,
  "message": "",
  "data": [
    {
      "categoryName": "核心服务",
      "monitors": [
        {
          "name": "API Gateway",
          "uptime": 99.98,
          "status": 1,
          "group": "Main"
        }
      ]
    }
  ]
}
```

未配置分组时返回空数组：

```json
{ "success": true, "message": "", "data": [] }
```

## 错误码

无。始终返回 HTTP 200。后端拉取失败时对应 monitor 不写入数据。
