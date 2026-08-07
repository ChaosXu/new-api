# Java 技术栈规则

适用范围：组件根目录下存在 `pom.xml`（Maven）或 `build.gradle`（Gradle）。本文件提供 Java 专属的**代码理解切入点**。通用概念（逻辑模块定义、判定信号、粒度）见 SKILL.md。

## 核心原则

**Java package 是覆盖代码的粒度，不是模块粒度。** 一个逻辑模块可覆盖多个 package；多个内聚的 package 也可归为一个逻辑模块。不要"每 package = 一模块"。

## 代码理解切入点

| 标志 | 用法 |
| --- | --- |
| `interface` 声明 | 对外契约，一个 interface 常定义一个逻辑模块的边界 |
| `implements` 同一 interface 的多个类 | 归为一个逻辑模块（如多个 Repository 都实现同一 DAO 接口 → "数据访问·仓储"一个模块），不各列 |
| Spring `@Service`/`@Repository`/`@Controller` | 职责标注，辅助判断内聚 |
| 调用链（import 关系） | 内聚性证据 |

## Java 特定的归类模式

- **一个 interface + 多实现 = 一个模块**：实现同一 interface 的多个包归为一个逻辑模块。
- **跨包内聚 = 合并**：分散在多包但共同实现一个能力的代码合并（如"鉴权"跨 security/web/auth 包）。
- 同构实现不各列（反例见 SKILL.md）。

## 覆盖代码标注

用 package 路径标注（相对组件根），例：`com.app.relay.adaptors.*`（多个适配器包通配）、`com.app.auth/`。

## 排除项

`target/`（Maven）、`build/`（Gradle）、测试源码 `src/test/`。
