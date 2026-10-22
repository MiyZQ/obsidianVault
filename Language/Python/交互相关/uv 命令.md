
uv 是由 Rust 编写的包管理器和环境管理器，速度很快

---
## 管理 Python 版本

uv 内置 Python 版本管理功能，无需额外安装 pyenv 等工具

**查看可用的 Python 版本：**
`uv python list`

输出结果类似如下：
```python
cpython-3.14.0rc2-macos-aarch64-none                 <download available>
cpython-3.13.7-macos-aarch64-none                    <download available>
cpython-3.12.11-macos-aarch64-none                   <download available>
cpython-3.11.13-macos-aarch64-none                   <download available>
cpython-3.10.18-macos-aarch64-none                   <download available>
cpython-3.9.6-macos-aarch64-none                     /usr/bin/python3
pypy-3.11.13-macos-aarch64-none                      <download available>
```

**安装特定版本的 Python：**
`uv python install 3.12`

**pypy 版本：**
`uv python install pypy3.10`

**设置全局默认 Python 版本：**
`uv python default 3.12`

**为当前项目固定 Python 版本（会创建 `.python-version` 文件）：**
`uv python pin 3.12`

执行这个命令后，当前项目下就会生成一个 .python-version，打开后，显示版本号内容：
`3.12`

## 管理虚拟环境

**创建虚拟环境：**
`uv venv`

**使用指定 Python 版本创建虚拟环境：**
`uv venv --python 3.12`

**激活虚拟环境：**
`source .venv/bin/activate` Mac/Linux
`.venv\Scripts\activate` Powershell

**退出虚拟环境：**
`deactivate`

> 日常开发中可以使用 `uv run` 直接运行脚本，无需手动激活虚拟环境。

---

## 包管理（pip 兼容模式）

uv 提供了与 pip 完全兼容的命令接口，可以直接替换已有工作流中的 pip 命令：

安装包：
`uv pip install requests`

**安装特定版本：**
`uv pip install requests==2.31.0`

**从 requirements.txt 批量安装：**
`uv pip install -r requirements.txt`

**升级包：**
`uv pip install --upgrade requests`

**卸载包：**
`uv pip uninstall requests`

**查看已安装的包：**
`uv pip list`

**导出当前环境的依赖到 requirements.txt：**
`uv pip freeze > requirements.txt`

---

## 项目管理（推荐方式）

uv 支持以 `pyproject.toml` 为中心的现代项目管理方式，这是比 pip 模式更推荐的使用方法，尤其适合团队协作和多环境部署。

### 初始化项目

```shell
uv init my_project
cd my_project
```

这会创建以下基本项目结构：
my_project/
├── pyproject.toml    # 项目配置和依赖声明
├── .python-version   # 固定 Python 版本
├── README.md
└── main.py

### 添加和移除依赖

在项目模式下，推荐使用 `uv add` 和 `uv remove` 管理依赖，它们会自动更新 `pyproject.toml` 和 `uv.lock`：

**添加生产依赖：**
`uv add requests`

**添加指定版本的依赖：**
`uv add "requests>=2.31.0"`

**添加开发依赖（只在开发环境使用，如测试框架）：**
`uv add --dev pytest ruff`

**移除依赖：**
`uv remove requests`

**查看依赖：**
`uv tree`

### 安装项目全部依赖（uv sync）

克隆项目或更新 `pyproject.toml` 后，运行以下命令一键安装所有依赖：
`uv sync`

> **uv sync 说明：** 类似于 `pip install -r requirements.txt`，它会根据 `pyproject.toml` 和 `uv.lock` 安装所有依赖，确保环境与其他开发者完全一致。如果安装速度慢，可以在 `pyproject.toml` 中设置国内镜像源：
> 
> [tool.uv]
> index-url = "https://pypi.tuna.tsinghua.edu.cn/simple"

### 生成/更新锁文件

运行： `uv lock`
该命令会解析 `pyproject.toml` 中的依赖并生成（或更新）`uv.lock` 文件。`uv.lock` 应该提交到版本库，确保团队所有成员使用完全相同的依赖版本。

**根据 lock 文件安装环境：**
`uv sync --locked`

---

## 运行脚本（uv run）

`uv run` 是 uv 中非常实用的命令，可以**无需手动激活虚拟环境**直接运行脚本或命令，uv 会自动找到并使用正确的环境：

**直接运行 Python 脚本：**
`uv run main.py`

**运行项目中的测试：**
`uv run pytest`

**运行任意命令（在虚拟环境的上下文中执行）：**
```shell
uv run python -c "import requests; print(requests.__version__)"
```

使用 `uv run` 相比手动激活环境的优势：不会误用错误的 Python 版本，也不会忘记激活环境导致包找不到，特别适合在 CI/CD 和脚本自动化中使用

---

## 迁移到 uv

如果正在使用其他工具，可以按以下方式迁移到 uv：

**从 pip + virtualenv 迁移：**
```shell
# 创建并激活虚拟环境
uv venv
source .venv/bin/activate

# 安装原有依赖
uv pip install -r requirements.txt
```

**从 pip-tools 迁移：**
```shell
# 编译依赖（替代 pip-compile）
uv pip compile requirements.in -o requirements.txt

# 同步环境（替代 pip-sync）
uv pip sync requirements.txt
```

**从 poetry 或 pdm 迁移：**
```shell
# 直接使用现有的 pyproject.toml
uv sync
```