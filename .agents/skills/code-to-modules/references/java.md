# Java 技术栈规则

适用范围：组件根目录下存在 `pom.xml`（Maven）或 `build.gradle`（Gradle）。本文件被 SKILL.md 在识别到 Java 技术栈时按需读取，提供 Java 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | `src/main/java/**/` 下的包目录。 |
| 导入模块 | `pom.xml` 的 `<dependencies>`；`build.gradle` 的 `dependencies {}`。 |

## 粒度规则

- 每个 `src/main/java/.../` 下的包目录一个内部模块，列到叶子粒度，不合并、不折叠。

## 排除项（Java 特定补充）

除 SKILL.md 的通用排除项外，Java 还需排除：

- `target/`（Maven 构建产物）。
- `build/`（Gradle 构建产物）。
- 测试源码目录 `src/test/`（按通用"测试固件"排除项判定）。
