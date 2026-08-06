# <!-- 本组件名 --> 的入站·内部关系

<!--
本模板由 code-to-components skill 使用，放置于 specs/03-ARCH/L2/{组件名}/relation/inbound-internal.md。
分类判定：运行时，其他组件主动调用/连入本组件（如父进程 spawn、其他组件的 HTTP 调用）。
只列本组件的直接入站关系；经其他组件中转的不列。无此类关系则不建此文件。
命名用 components.md 中的实际组件名。删除所有 HTML 注释后再交付。
-->

```mermaid
graph LR
  Me[<!-- 本组件 -->]
  Other[<!-- 对方组件 -->]

  Other -- <!-- 方式 --> --> Me
```

| 对方组件 | 方式 | 说明 |
| --- | --- | --- |
| <!-- 对方 --> | <!-- spawn/HTTP/RPC 等 --> | <!-- 交互细节 --> |
