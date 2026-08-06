# Python 技术栈规则

适用范围：组件根目录下存在 `pyproject.toml` / `requirements.txt` / `Pipfile`。本文件被 SKILL.md 在识别到 Python 技术栈时按需读取，提供 Python 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | 含 `__init__.py` 的包目录，或含 `*.py` 的源码目录。 |
| 导入模块 | `pyproject.toml` 的 `[project.dependencies]` / `requirements.txt` / `Pipfile`。 |
| 依赖关系 | 各 `*.py` 文件的 `import <pkg>` / `from <pkg> import ...` 中**指向本组件内部**的包：以本组件根包名为前缀的相对/绝对导入（如 `from .sibling` / `from myapp.core`）。剔除标准库与 site-packages 第三方。采集结果填入**每个模块文件**的"直接依赖（内部）"。 |

## 粒度规则

- 每个含 `*.py` 的包目录（含 `__init__.py`）一个内部模块，列到叶子粒度，不合并、不折叠。

## 排除项（Python 特定补充）

除 SKILL.md 的通用排除项外，Python 还需排除：

- 虚拟环境目录（`.venv/` / `venv/` / `env/`）。
- 构建产物目录（`dist/` / `build/` / `*.egg-info/`）。

## 同构折叠判定信号（Python 特定）

满足以下信号**之一**的一批包判为同构，折叠到单文件汇总，不各自独立成文件：

1. **同一父包下的同构子模块**：同一父包下的多个子模块职责同构（如多个 provider 适配器都继承同一基类/实现同一协议）。判定信号 = 同父包 + 继承同一基类或实现同一 Protocol/ABC + 职责描述只差 provider 名。
2. **正向依赖集合高度重合**：一批子模块的内部 import 有 ≥80% 共同项。
