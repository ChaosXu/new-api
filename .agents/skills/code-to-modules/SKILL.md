---
name: code-to-modules
description: 归纳某个组件的内部模块和导入模块。当用户提到"归纳组件模块"、"组件由哪些模块组成"时使用。
---

## 目的

针对 `specs/03-ARCH/components.md` 中已识别的**某一个组件**，从其源码中归纳出全部**模块**，分为**内部模块**（本组件源码包）和**导入模块**（第三方依赖）。产出一份只包含模块清单的文档，严格按内置模板填写。

## 前置条件（强制）

1. **必须存在 `specs/03-ARCH/components.md`**。若文件缺失，立即停止并提示用户先运行 `code-to-components` skill。
2. **必须由用户指定目标组件名**（即 `components.md` 表中"组件名"列的值）。若用户未指定且 `components.md` 中有多个组件，先询问用户要归纳哪一个；不要默认取第一个。
3. 从 `components.md` 的"路径"列取得目标组件的根目录，后续所有扫描都以此为根，不得越界到其他组件的目录。

## 关键概念

### 模块定义

**模块**：编译/打包进同一组件制品、不独立部署的代码单元。区分两类：

- **内部模块**：位于目标组件源码树内、属于该组件的源码包/目录。
- **导入模块**：来自第三方的外部依赖（如 Go `require`、npm `dependencies`、Maven `<dependencies>`、Python `requirements`），不含指向本仓库内部的 `replace`/workspace 引用（这些归入内部模块）。

与组件的根本区别：**模块没有独立运行入口、不产出独立制品**，只是被组件制品编译/打包进去。

### 划分原则

- **内部模块**：位于本组件源码树内、属于该组件的源码包/目录。
- **导入模块**：来自第三方的外部依赖，不含指向本仓库内部的 `replace`/workspace 引用（这些归入内部模块）。
- 模块没有独立运行入口、不产出独立制品，只是被组件制品编译/打包进去。

### 粒度规则

- **内部模块展开到所有叶子包**：递归列出目标组件源码树内的每一个源码包（Go package）/每一个含源码的子目录，不合并、不折叠。
  - Go：每个 `package xxx` 的目录都是一个内部模块。同一目录只有一个 package 时按目录列；同一目录有多个 package（如 `xxx_test`）合并到该目录。
  - Node：每个 `src/` 下的源码目录/模块文件按目录列，`node_modules` 不属于内部模块。
  - Python：每个含 `.py` 的包目录（含 `__init__.py`）一个模块。
  - Java：每个 `src/main/java/.../` 下的包目录一个模块。
- **排除项**（不计入内部模块）：产物目录（`dist`/`build`/`out`/`target`）、依赖目录（`node_modules`/`vendor`）、测试固件、配置目录、文档目录、CI/构建脚本目录。

## 输出范围控制（重要）

- **不要把内部推理作为产出**：为了识别模块，通常需要扫描目录、读 import 关系、区分依赖类型。
- **不要在产出中输出**：组件级归纳（由 components.md 承担）、判定推理过程、被排除项的列表、传递依赖的全量展开。读者只看到该组件的模块清单。

## 数据源（按技术栈）

| 技术栈 | 内部模块证据 | 导入模块证据 |
| --- | --- | --- |
| Go | 递归列出组件根下所有含 `*.go` 的目录；每个目录读 `package` 声明 | `go.mod` 的 `require` 块；剔除 `replace` 指向本仓库路径的条目（这些是内部子 module，归内部模块） |
| Node/Bun | `src/` 下含 `*.ts`/`*.js`/`*.tsx`/`*.jsx` 的目录 | `package.json` 的 `dependencies` + `devDependencies`；剔除 `workspaces` 指向本仓库的条目 |
| Python | 含 `__init__.py` 的包目录、或含 `*.py` 的源码目录 | `pyproject.toml` 的 `[project.dependencies]` / `requirements.txt` / `Pipfile` |
| Java | `src/main/java/**/` 下的包目录 | `pom.xml` 的 `<dependencies>`、`build.gradle` 的 `dependencies {}` |

## 工作流程

1. **校验前置**：确认 `specs/03-ARCH/components.md` 存在；取得用户指定的组件名；从表中读取该组件的"路径"作为扫描根。
2. **识别技术栈**：根据扫描根下的 manifest（`go.mod` / `package.json` / `pom.xml` / `pyproject.toml`）判断技术栈，选对应数据源规则。多技术栈组件（如同时含 Go 和 Node）按各自规则分别归纳。
3. **枚举内部模块**：递归扫描源码目录，列出每一个叶子包/源码目录。读取每个包的主要源码文件（包注释、`doc.go`、主要导出符号），提炼 1 句中文职责。
4. **枚举导入模块**：解析 manifest 的依赖声明，剔除指向本仓库内部的部分；对剩余第三方依赖**按职能分类**（Web 框架、ORM、缓存、鉴权、云 SDK、计费、支付、媒体、序列化、工具集、可观测性、测试、i18n、标准库扩展……），每类以表格列出"依赖 → 用途"。用途据该依赖在本组件源码中的实际 import/调用位置归纳，不要照抄依赖 README。
5. **按模板产出**：读取 `assets/modules.md`，把内部模块填入"内部模块"区、导入模块填入"导入模块"区。模块/依赖命名用仓库内的实际名称（目录名 / package 名 / 依赖坐标），不臆造。
6. **写入文件**：输出到 `specs/03-ARCH/<组件名>/modules.md`。其中 `<组件名>` 为 `components.md` 中"组件名"列的值。若该目录不存在则创建。

## 与其他 skill 的关系

- **上游**：`code-to-components` 产出 `components.md`，是本 skill 的输入。本 skill 不重新判定组件，只在已确认的组件内做模块归纳。
- **不要越界**：本 skill 只处理**一个**组件。若用户要归纳多个组件，分别调用本 skill，每次产出到各自的 `specs/03-ARCH/<组件名>/modules.md`。
