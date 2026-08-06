# <!-- 本组件名 --> 的编译时关系

<!--
本模板由 code-to-components skill 使用，每个组件一份（可选），放置于 specs/03-ARCH/L2/{组件名}/build.md。
填写规则：
- 描述该组件的编译时关系——构建期间其他组件产物如何嵌入本组件制品，或本组件产物如何被嵌入其他组件制品。
- 典型机制：go:embed、打包工具 bundle/extraResources、workspaces 构建链、Go replace（本地 module 编译期链接）。
- 区分：编译时嵌入（本文件）vs 运行时调用（归 relation/）。
- 若本组件无任何编译时嵌入关系，不建此文件。
- 命名用 components.md 中的实际组件名。
- 删除所有 HTML 注释后再交付。
-->

```mermaid
graph LR
  Me[<!-- 本组件 -->]
  Other[<!-- 对方组件 -->]

  Other -- <!-- 嵌入机制 --> --> Me
```

| 对方组件 | 方向 | 机制 | 说明 |
| --- | --- | --- | --- |
| <!-- 对方 --> | <!-- 本组件嵌入对方/对方嵌入本组件 --> | <!-- go:embed/extraResources/workspaces/replace 等 --> | <!-- 嵌入细节 --> |
