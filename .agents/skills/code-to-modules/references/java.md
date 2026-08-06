# Java 技术栈规则

适用范围：组件根目录下存在 `pom.xml`（Maven）或 `build.gradle`（Gradle）。本文件被 SKILL.md 在识别到 Java 技术栈时按需读取，提供 Java 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | `src/main/java/**/` 下的包目录。 |
| 导入模块 | `pom.xml` 的 `<dependencies>`；`build.gradle` 的 `dependencies {}`。 |
| 依赖关系 | 各 `*.java` 文件的 `import <fqcn>;` 中**指向本组件内部包**的：以本组件的 base package 为前缀的（如 `com.example.app.core.*`）。剔除外部坐标（`com.google.*`、`org.springframework.*` 等）。采集结果填入**每个模块文件**的"直接依赖（内部）"。 |

## 粒度规则

- 每个 `src/main/java/.../` 下的包目录一个内部模块，列到叶子粒度，不合并、不折叠。

## 排除项（Java 特定补充）

除 SKILL.md 的通用排除项外，Java 还需排除：

- `target/`（Maven 构建产物）。
- `build/`（Gradle 构建产物）。
- 测试源码目录 `src/test/`（按通用"测试固件"排除项判定）。

## 同构折叠判定信号（Java 特定）

满足以下信号**之一**的一批包判为同构，折叠到单文件汇总，不各自独立成文件：

1. **实现同一 interface 的同类实现**：同一父包下的多个包都 `implements` 同一接口（如多个 Repository 都实现同一 DAO 接口，或多个 Service 实现同一 Service 接口）。判定信号 = 同父包 + 实现同一 interface + 职责描述只差领域对象名。
2. **正向依赖集合高度重合**：一批包的内部 import 有 ≥80% 共同项。
