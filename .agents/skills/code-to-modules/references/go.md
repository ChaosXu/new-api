# Go 技术栈规则

适用范围：组件根目录下存在 `go.mod`。本文件被 SKILL.md 在识别到 Go 技术栈时按需读取，提供 Go 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | 递归列出组件根下所有含 `*.go` 的目录；每个目录读取其 `package` 声明确定包名。 |
| 导入模块 | `go.mod` 的 `require` 块；**剔除** `replace` 指向本仓库路径的条目（这些是内部子 module，归内部模块）。 |
| 依赖关系 | 各 `*.go` 文件 import 块中**指向本 module 内其他包**的路径：以本 module 的 import path 为前缀的（如 `github.com/QuantumNous/new-api/relay/common`）；`replace` 指向仓库内子 module 的（如 `.../relaykit/...`）也算内部依赖。剔除标准库与第三方 `require`。采集结果填入**每个模块文件**的"直接依赖（内部）"。 |

## 粒度规则

- 每个 `package xxx` 的目录都是一个内部模块，列到叶子包粒度，不合并、不折叠。
- 同一目录只有一个 package 时按目录列。
- 同一目录存在多个 package（如 `xxx` 与 `xxx_test`）时，合并到该目录一行。
- **子 module（纯库型内部模块）**：有独立 `go.mod`、无运行入口、只被宿主以 `require` + `replace` 引入的纯库（例如 `relaykit`），单独列出并注明 module 关系，不与普通内部包混排。

## 排除项（Go 特定补充）

除 SKILL.md 的通用排除项外，Go 还需排除：

- `vendor/`（vendored 依赖，属第三方，不归内部模块）。
- 由构建生成的目录（如 `dist/`、`build/`、`out/`）。

## 同构折叠判定信号（Go 特定）

满足以下信号**之一**的一批 Go 包判为同构，折叠到单文件汇总，不各自独立成文件：

1. **实现同一 interface 的同类实现**：同一父目录下的多个包都 import 并实现了同一接口包（如 `relay/channel/*` 都 import `relay/channel` 并实现 `Adaptor`/`TaskAdaptor`）。判定信号 = 同一父目录 + 都 import 同一接口包 + 职责描述只差 provider 名（"X 上游适配器"）。
2. **正向依赖集合 80% 重合**：一批包的直接依赖（内部）有 ≥80% 共同项（如 34/39 个适配器都依赖 `relay/channel`+`relay/common`+`relaykit/dto`+`relaykit/types`）。
3. **子 module 内部的同构包**：如 `relaykit/relayconvert/internal/*`（claude_messages/gemini_chat/oai_chat/oai_responses 等协议转换器结构同构）。

折叠文件形态：开头注明共性依赖，表列各包的**特例**（非共性依赖、协议特殊性）。典型示例：`adaptors-sync.md` 汇总 39 个同步适配器。
