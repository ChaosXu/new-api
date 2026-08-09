# 渠道管理流程（测试 / 自动禁用 / 自动启用）

> 渠道（Channel，上游 AI 提供商）的生命周期管理。除标准 CRUD 外，两个有跨模块协作的关键能力：**渠道测试**（实际发请求探活）与**自动禁用/启用**（中继失败时自动拉黑、定时探活恢复）。

## 时序图

```mermaid
sequenceDiagram
    autonumber
    participant Admin as 管理员
    participant Ctrl as 控制器
    participant Relay as 编排入口<br/>(测试用)
    participant Adapt as 渠道适配框架
    participant Select as 渠道选择
    participant Data as 数据访问

    Note over Admin,Data: 场景一：渠道测试（主动探活）
    Admin->>Ctrl: POST /api/channel/test/:id
    Ctrl->>Data: 查渠道配置
    Ctrl->>Relay: 构造测试请求(chat/completions 探活)
    Relay->>Adapt: GetAdaptor + 发起一次真实调用
    Adapt-->>Relay: 成功/失败 + 耗时
    Relay-->>Ctrl: 测试结果
    Ctrl-->>Admin: 返回(成功/失败 + 延迟 + 余额)

    Note over Admin,Data: 场景二：中继失败触发自动禁用（被动）
    Relay->>Adapt: 中继请求失败(连续/严重错误)
    Note over Relay: ShouldDisableChannel(err) 判定<br/>(如鉴权失败/余额不足/超时累计)
    alt channel.AutoBan 开启 且 判定应禁用
        Relay->>Select: DisableChannel(渠道ID, 原因)
        Select->>Data: 渠道状态置为禁用 + 记录原因
        Note over Select: 后续 distributor 选渠道时<br/>跳过此渠道
    end

    Note over Admin,Data: 场景三：自动启用恢复（定时探活，可选）
    loop 定时
        Select->>Data: 查被禁用且可恢复的渠道
        opt 配置允许自动重试
            Select->>Relay: 探活调用
            alt 探活成功
                Select->>Data: 渠道状态恢复启用
            end
        end
    end
```

## 流程说明

**标准 CRUD**：渠道的增删改查（`server/internal/controller/channel.go`），管理员配置渠道（类型/密钥/BaseURL/模型列表/分组等）。CRUD 不涉及跨模块协作。

**场景一：渠道测试**（主动探活）
1. 管理员触发测试，控制器查渠道配置后，构造一次测试请求（`server/internal/controller/channel-test.go`，发 `/v1/chat/completions` 探活），经编排入口 + 适配器发真实调用。
2. 返回成功/失败、延迟、余额（部分渠道支持余额查询，`server/internal/controller/channel-billing.go`）。

**场景二：自动禁用**（被动，中继失败触发）
3. 中继请求失败时（`server/internal/controller/relay.go:367`），`ShouldDisableChannel`（`server/internal/service/channel.go:45`）判定错误是否严重（鉴权失败/余额不足/连续超时等）。
4. 若渠道 `AutoBan` 开启且判定应禁用，`DisableChannel`（`server/internal/service/channel.go:19`）把渠道状态置为禁用 + 记录原因。此后 distributor 选渠道时跳过它。

**场景三：自动启用恢复**（定时探活，可选）
5. 若配置允许，定时对被禁渠道探活，成功则恢复启用。

## 涉及的 L3 逻辑模块

| 场景 | 逻辑模块 | 模块文件 |
| --- | --- | --- |
| CRUD/测试控制器 | 控制器 | [api/controller.md](../modules/api/controller.md) |
| 测试探活调用 | 编排入口、渠道适配框架 | [relay/relay-orchestration.md](../modules/relay/relay-orchestration.md)、[relay/relay-adaptor.md](../modules/relay/relay-adaptor.md) |
| 禁用/启用逻辑 | 渠道选择（含 DisableChannel/ShouldDisableChannel） | [service/channel-select.md](../modules/service/channel-select.md) |
| 渠道状态持久化 | 实体数据访问 | [data/data-access.md](../modules/data/data-access.md) |

## 项目约束

- `ShouldDisableChannel` 的判定逻辑改动需谨慎：误禁用会误伤正常渠道，漏禁用会让故障渠道持续拖慢中继（重试链路）。
- 渠道测试/余额查询若走真实上游，会产生真实计费（`server/internal/controller/channel-test.go` 构造的 `/v1/chat/completions` 路径）。
