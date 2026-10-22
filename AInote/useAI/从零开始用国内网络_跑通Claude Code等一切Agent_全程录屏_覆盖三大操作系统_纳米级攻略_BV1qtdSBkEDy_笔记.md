# AI Agent 环境配置全攻略：Windows / macOS / Linux 保姆级教程

本教程系统性地讲解在 Windows、macOS、Linux 三大操作系统上，从零配置能够运行 Claude Code、Codex、Hermes Agent 等主流 AI Agent 的开发环境。使用国内网络，无需特殊网络条件即可完成所有配置。

---

## 目录

- [Windows 系统配置](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#windows-系统配置)
  - [安装 Node.js](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-nodejs)
  - [安装 Git](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-git)
  - [安装 Claude Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-claude-code)
  - [配置 Claude Code 使用国内模型](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#配置-claude-code-使用国内模型)
  - [安装 VS Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-vs-code)
  - [解锁 GitHub](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#解锁-github)
  - [实战演示：创建项目并上传到 GitHub](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#实战演示创建项目并上传到-github)
  - [安装 Python](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-python)
  - [安装 WSL](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-wsl)
  - [在 WSL 中安装 Hermes Agent](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#在-wsl-中安装-hermes-agent)
  - [安装 Codex](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-coodex)
  - [获取 Claude 官方订阅](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#获取-claude-官方订阅)
- [macOS 系统配置](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#macos-系统配置)
  - [安装 Chrome 浏览器](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-chrome-浏览器)
  - [安装 Xcode 命令行工具](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-xcode-命令行工具)
  - [安装 Node.js（重要：使用 NVM）](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-nodejs重要使用-nvm)
  - [安装 Claude Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-claude-code-mac)
  - [配置 Claude Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#配置-claude-code-mac)
  - [解锁 GitHub](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#解锁-github-mac)
  - [安装 Homebrew](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-homebrew)
  - [安装 Python](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-python-mac)
  - [安装 Codex](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-coodex-mac)
- [Linux 系统配置](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#linux-系统配置)
  - [更新 APT 索引](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#更新-apt-索引)
  - [安装必要工具](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装必要工具)
  - [安装 Node.js](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-nodejs-linux)
  - [安装 Claude Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-claude-code-linux)
  - [配置 Claude Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#配置-claude-code-linux)
  - [安装 VS Code](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-vs-code-linux)
  - [安装 Chrome 浏览器](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#安装-chrome-浏览器-linux)
- [常见问题与注意事项](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#常见问题与注意事项)
- [弹幕补充信息](从零开始用国内网络_跑通Claude%20Code等一切Agent_全程录屏_覆盖三大操作系统_纳米级攻略_BV1qtdSBkEDy_笔记.md#弹幕补充信息)

---

## Windows 系统配置

### 安装 Node.js

Node.js 是一个让电脑可以运行 JavaScript 代码的运行环境，是绝大多数 AI Agent 软件的基础依赖。

**操作步骤：**

1. 访问 Node.js 官网（https://nodejs.org/），找到 Windows 系统的安装包下载
2. 运行安装程序，一路点击"下一步"完成安装

**配置 PowerShell 执行策略：**

安装完成后，需要允许在控制台运行 PowerShell 脚本：

1. 在桌面右键点击"开始菜单"
2. 选择"终端管理员"
3. 输入命令：

```powershell
Set-ExecutionPolicy Unrestricted
```

回车执行。

**验证安装：**

在终端中输入以下命令，检查版本号是否正常显示：

```powershell
node -v
npm -v
```

两个命令都能正常打印版本号，说明 Node.js 安装成功。

---

### 安装 Git

Git 是全世界最流行的版本控制软件，类似论文保存多个历史版本的功能，但更强大。使用 Git 进行版本控制，可以让 AI 随时回退到某个历史节点重新工作。

**操作步骤：**

1. 访问 Git 官网（https://git-scm.com/）
2. 点击下载 Windows 系统的安装包
3. 根据 CPU 架构选择：
   - **x86_64（64位）**：绝大多数 Windows 电脑选择这个
   - **ARM**：仅限 ARM 架构的设备
4. 下载并运行安装程序，一路点击"下一步"完成安装

**验证安装：**

在桌面右键，选择"在终端打开"，输入：

```bash
git --version
```

成功打印版本号即安装成功。

---

### 安装 Claude Code

Claude Code 是现阶段公认的最强 AI Agent 软件。

**操作步骤：**

1. 在桌面右键，选择"使用终端打开"
2. 输入命令：

```bash
npm install -g @anthropic-ai/claude-code
```

回车执行，等待安装完成。

---

### 配置 Claude Code 使用国内模型

Claude Code 默认使用 Anthropic 官方 API，需要配置为国内模型服务商以适应国内网络环境。

**配置文件位置：**

`C:\Users\<你的用户名>\.claude.json`

**操作步骤：**

1. 打开文件资源管理器，进入 `C:\Users\<你的用户名>` 目录
2. 在顶部菜单点击"查看"
3. 勾选"显示隐藏文件"和"文件扩展名"
4. 在空白处右键，新建文本文档
5. 将文件名改为 `.claude.json`（注意前面有个点）
6. 双击打开文件，用记事本编辑

**配置文件内容：**

将以下配置内容复制粘贴到文件中（内容较长，可暂停视频截图后用 AI 识别）：

```json
{
  "env": {
    "ANTHROPIC_API_KEY": "sk-xxxxxxxxxxxxxxxxxxxxxxxx"
  },
  "clinets": [
    {
      "name": "国内模型",
      "clientType": "anthropic-compatible",
      "options": {
        "apiKey": "sk-xxxxxxxxxxxxxxxxxxxxxxxx",
        "baseURL": "https://api.xxxxxxxxx.com/v1"
      }
    }
  ],
  "globalDefaultModel": "国内模型/claude-3-5-sonnet-20241022"
}
```

**需要修改的两个地方：**

| 配置项 | 说明 | 获取方式 |
|--------|------|----------|
| `apiKey`（即 token） | API 密钥 | 在国内 AI 服务商（如硅基流动、火山引擎等）控制台新建 API Key |
| `baseURL` | 模型厂商的 API 地址 | 在服务商文档中查找"在第三方中使用"，里面有对应的 baseURL |

**保存配置：**

按 `Ctrl + S` 保存，然后关闭记事本。

**启动验证：**

在桌面右键打开终端，输入：

```bash
claude
```

启动 Claude Code，选择第一个选项信任当前文件夹，然后打个招呼测试是否正常响应。如果得到回复，说明配置成功。

---

### 安装 VS Code

VS Code 是一款轻量且功能强大的代码编辑器，几乎支持所有编程语言，是使用 AI Agent 进行代码编写的必备工具。

**操作步骤：**

1. 访问 VS Code 官网（https://code.visualstudio.com/）
2. 点击下载 Windows 系统安装程序
3. 运行安装程序，一路点击"下一步"完成安装

---

### 解锁 GitHub

在国内网络使用 GitHub 经常因网络问题导致超时或打不开。使用 **Watt Toolkit**（原 Steam++）可以解决这个问题。

**操作步骤：**

1. 在微软应用商店（Microsoft Store）搜索并安装 **Watt Toolkit**
2. 打开软件
3. 找到"网络加速"功能
4. 勾选 **GitHub**
5. 点击"一键启动加速"

加速成功后，即可顺畅访问 GitHub。

**注册 GitHub 账号：**

1. 访问 github.com，点击 Sign up
2. 填写用户名、邮箱、密码、地区
3. 去邮箱收取验证码，填写后完成注册
4. 点击登录按钮进入 GitHub

---

### 实战演示：创建项目并上传到 GitHub

将前面几步的配置串联起来，演示一个完整的工作流程：

**操作步骤：**

1. 在桌面新建一个文件夹
2. 在文件夹内右键，打开终端
3. 输入命令 `claude` 启动 Claude Code
4. 输入提示词："创建一个 HTML 的坦克大战游戏，并上传到 GitHub 上面变成一个仓库"
5. AI 会申请各种权限，选择同意
6. AI 询问如何上传到 GitHub，选择第二个选项
7. AI 提示需要先创建一个仓库，点击提供的链接
8. 在 GitHub 页面填写仓库名称，点击创建
9. 复制仓库地址，粘贴回 Claude Code
10. 弹出 GitHub 授权窗口，选择使用浏览器登录
11. 点击授权按钮
12. 任务完成，代码已同步上传到 GitHub

---

### 安装 Python

Python 是非常流行的编程语言，很多 Agent 的 Skills 附带的脚本都依赖 Python 运行。

**操作步骤：**

1. 访问 Python 官网（https://www.python.org/）
2. 在 Download 页面点击 **Download Python Installer**
3. 下载完成后运行安装程序
4. 点击"Install Python"
5. 弹出的终端窗口中，全部输入 `y` 回车确认

**验证安装：**

打开终端，输入：

```powershell
python --version
python3 --version
```

都能打印版本号表示安装成功。

使用 `pip install` 命令也可以正常安装 Python 软件包，基础使用就满足了。

**进阶推荐：使用虚拟环境**

使用虚拟环境可以让不同工程的 Python 依赖分文件夹存储，相互之间不会冲突：

```powershell
# 安装指定版本（如 3.13）的 Python
py -3.13 -m pip install python

# 创建项目文件夹并进入
# 然后创建虚拟环境
python -m venv venv

# 激活虚拟环境
.\venv\Scripts\activate

# 在虚拟环境中安装依赖
pip install xxx
```

> **注意**：很多 AI 不喜欢用虚拟环境。建议在提示词中注明："要求 AI 必须使用虚拟环境来进行工作"。

---

### 安装 WSL

WSL 全称是 **Windows Subsystem for Linux**（适用于 Linux 的 Windows 子系统），开启后 Windows 电脑就拥有了一个 Linux 子系统，很多在 Windows 上无法安装或表现不佳的 Agent 软件都能正常运行。

**第一步：开启 Windows 功能**

1. 在 Windows 搜索栏搜索"启用或关闭 Windows 功能"
2. 勾选以下两项：
   - ✅ 适用于 Linux 的 Windows 子系统
   - ✅ 虚拟机平台
3. 点击确定，根据提示重启电脑

**第二步：安装 WSL**

电脑重启后，在桌面右键打开终端，输入：

```powershell
wsl --install --web-download
```

耐心等待下载完成，然后填写用户名和密码，WSL 即安装完成。

**验证安装：**

新开一个终端，输入：

```powershell
wsl --list
```

显示 `Ubuntu` 即表示安装成功。Ubuntu 是目前最流行的 Linux 发行版，也是 WSL 默认安装的版本。

**打开 Ubuntu：**

在终端顶部点击"+"号，在下拉列表中找到 Ubuntu，点击即可进入子系统。

**WSL 与 Windows 文件互通：**

- 在 Windows 中：打开"我的电脑"，左下角有一个 Linux 图标，点击可以进入 Ubuntu 文件系统
- 在 Ubuntu 中：输入 `cd /mnt/c` 可进入 Windows 的 C 盘

例如，进入 Windows 的笔记文件夹：

```bash
cd /mnt/c
cd Users/你的用户名/笔记文件夹
ls
```

---

### 在 WSL 中安装 Hermes Agent

Hermes Agent 是最近很火的 AI Agent，在 Windows 原生环境不支持，但支持 WSL。

**操作步骤：**

1. 在 WSL 窗口中粘贴安装命令：
```bash
curl -L https://github.com/ascclemens/hermes-agent/releases/download/nightly/hermes-agent-x86_64-unknown-linux-musl.tar.gz | tar xz && mv hermes-agent /usr/local/bin/hermes-agent && chmod +x /usr/local/bin/hermes-agent
```

> 注意：可能因网络问题访问失败，多试几次即可。

2. 等待约 20 分钟安装完成
3. 选择模型提供商，这里选择 **OpenRouter**
4. 访问 OpenRouter 创建 API Key（https://openrouter.ai/），复制 API Key 粘贴回 WSL
5. 选择模型，选择一个免费模型
6. 按提示启动聊天功能，打招呼测试是否正常

---

### 安装 Codex

Codex 是近期最推荐的 AI Agent 工具，因为给的额度较高，对中国用户比较友好。

**前提条件：**

Claude Code 至少需要 GPT Plus 订阅才能使用。

**订阅 GPT Plus 的方法：**

1. 在安卓手机上下载 **Google Play 商店**
2. 登录 Google 账号
3. 点击右上角头像 → 设置 → 账号和设备偏好设置 → 把国家和地区改成美国
4. 回到 Google Play 首页，点击头像 → 付款与订阅 → 添加卡片（国内卡片也可绑定）
5. 在 Google Play 搜索并下载 **ChatGPT 手机版 APP**
6. 打开 ChatGPT，点击顶部"获取 Plus" → 选择通过 Google Play 订阅

**安装 Codex：**

订阅完成后，在桌面右键打开终端，输入：

```bash
npm install -g @openai/codex
```

然后输入：

```bash
codex
```

在浏览器打开的登录页面登录 ChatGPT 账号，打招呼测试即可。

---

### 获取 Claude 官方订阅

如果需要使用 Claude 官方订阅（非国内模型），步骤如下：

1. 访问 Claude 官网（https://claude.ai/）
2. **必须使用谷歌账号登录**
3. **注意**：谷歌账号的邮箱必须是 Gmail，使用 Gmail 邮箱不会触发手机验证码步骤
4. 后续步骤与 ChatGPT 类似：
   - 在手机上安装 Google Play，国家地区改成美国
   - 下载 Claude 手机 APP
   - 在手机 APP 中使用 Google Play 完成订阅

---

## macOS 系统配置

### 安装 Chrome 浏览器

macOS 自带的 Safari 浏览器非常不推荐，应立即替换为 Chrome。

**操作步骤：**

1. 打开 Safari，在百度搜索 Chrome（第一个即是官网）
2. 点击下载 Chrome
3. 下载完成后双击安装包
4. 把 Chrome 拖拽进 Application 文件夹完成安装

**设置为默认浏览器：**

1. 打开 Application 文件夹
2. 找到 Chrome，拖拽到程序坞
3. 把自带的 Safari 在程序坞中移除

---

### 安装 Xcode 命令行工具

Xcode 命令行工具包内含大量基础工具，包括 Git。

**操作步骤：**

1. 在 Application 中找到"终端"并打开
2. 输入命令：

```bash
xcode-select --install
```

3. 弹出确认窗口，点击同意，等待安装完成

**验证 Git 安装：**

安装完成后 Git 已包含在内，输入：

```bash
git --version
```

可查看到 Git 版本号。

---

### 安装 Node.js（重要：使用 NVM）

> **大坑警告**：不要使用 Node.js 官网的安装包，安装包会把 Node.js 安装到 root 目录，后续会出现很多权限问题。

**正确做法：使用 NVM 安装**

NVM 是 Node Version Manager，可以管理多个 Node.js 版本，避免权限问题。

**操作步骤：**

1. 打开终端，输入以下命令创建 shell 配置文件：
```bash
touch ~/.zshrc
```

2. 依次执行以下命令（国内网络环境可能会失败，可尝试换用加速器）：
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

3. 清理屏幕：
```bash
clear
```

4. 使用 NVM 安装 Node.js：
```bash
nvm install 24
```

这会把 Node.js 24 安装到电脑上。

**验证安装：**

```bash
node -v
npm -v
```

两个命令都能成功打印版本号，表示安装成功。

---

### 安装 Claude Code

在终端中输入：

```bash
npm install -g @anthropic-ai/claude-code
```

回车执行，等待安装完成。

---

### 配置 Claude Code

**创建配置文件：**

1. 在终端中输入：
```bash
cd ~
touch .claude.json
```

2. 打开访达（Finder），点击用户名进入主目录
3. 按 `Command + Shift + .` 显示隐藏文件
4. 找到刚创建的 `.claude.json` 文件，右键打开

**填入配置：**

将配置内容粘贴进去，同样需要修改两个地方：

- `apiKey`：从国内 AI 服务商申请
- `baseURL`：从服务商文档中获取

按 `Command + S` 保存。

**启动验证：**

在终端输入：

```bash
claude
```

选择第一个选项信任当前文件夹，所有授权窗口都点击允许，打招呼测试是否正常响应。

---

### 解锁 GitHub

**下载 Watt Toolkit：**

访问 https://wwtt.me 下载 Watt Toolkit，下载完成后双击安装包运行，把软件拖入 Application 文件夹。

**安全策略阻止：**

如果软件被安全策略阻止无法打开：

1. 前往"系统设置" → "隐私与安全性"
2. 点击"仍要打开"按钮即可

**开启加速：**

1. 打开 Watt Toolkit
2. 找到"网络加速"功能
3. 勾选 **GitHub**
4. 点击"一键加速"
5. 如果遇到权限错误，填写 mac 电脑的用户名，复制下方提供的命令
6. 打开终端执行该命令
7. 再次尝试加速 GitHub，成功后即可正常使用

> 有关注册 GitHub 账号以及把 Claude Code 开发的项目备份上传到 GitHub 的方法，请参考前面 Windows 章节的详细说明。

---

### 安装 Homebrew

Homebrew 是 macOS 上最流行的命令行软件管理器，安装后用一行命令就能安装、更新、卸载各种软件。

**操作步骤：**

1. 访问 Homebrew 官网（https://brew.sh/）
2. 复制一键安装命令：
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. 打开终端，粘贴命令并回车执行

> 注意：该命令依赖 GitHub 上的脚本，因此需要先解决 GitHub 网络问题后再执行。

安装完成后即可使用 Homebrew 管理软件。

**示例：使用 Homebrew 安装 Python：**

```bash
brew install python@3.12
```

等待安装完成。

---

### 安装 Python

**安装 Python 3.12：**

```bash
brew install python@3.12
```

**配置 Python 别名：**

1. 在访达中点击用户名进入主目录
2. 找到 `.zshrc` 文件，双击打开
3. 添加以下四行内容：
```bash
alias python="/opt/homebrew/opt/python@3.12/bin/python3.12"
alias pip="/opt/homebrew/opt/python@3.12/bin/pip3.12"
```

4. 按 `Command + S` 保存

以后在命令行中输入 `python` 或 `python3` 都是使用的 Python 3.12。

**重要：必须使用虚拟环境**

Homebrew 安装的 Python 直接在终端执行 `pip` 命令安装依赖会报错，因为 Homebrew 禁止全局安装 Python 依赖。必须使用虚拟环境：

```bash
# 创建项目文件夹并进入
cd ~/Projects/my-project

# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
source venv/bin/activate

# 安装依赖
pip install xxx
```

> **注意**：很多 AI 不喜欢用虚拟环境，建议在提示词中注明"要求 AI 必须使用虚拟环境来进行工作"。

---

### 安装 Codex

**安装命令：**

```bash
npm install -g @openai/codex
```

启动方式：

```bash
codex
```

在浏览器中打开的页面登录 ChatGPT 账号即可使用。

有关订阅 GPT Plus 和获取 Claude 官方订阅的方法，请参考前面 Windows 章节的详细说明。

---

## Linux 系统配置

本章节面向动手能力较强的 Linux 用户，讲解速度会相对快一些。

### 更新 APT 索引

APT 是 Ubuntu 系统安装软件的工具。更新索引让系统知道现在有哪些软件可以安装、最新版本是什么。

**操作步骤：**

1. 在桌面右键打开终端
2. 输入命令：
```bash
sudo apt update
```

3. 填写电脑密码回车，等待更新完成

---

### 安装必要工具

安装 Curl 和 Git：

```bash
sudo apt install curl
sudo apt install git
```

分别输入 `y` 回车确认执行。

---

### 安装 Node.js

同样选择 NVM 安装方式，依次执行以下四个命令：

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# 或者使用国内镜像
curl -o- https://gitee.com/mirrors/nvm.git/install.sh | bash

source ~/.bashrc

nvm install 24
```

**验证安装：**

```bash
node -v
```

显示版本号表示安装成功。

---

### 安装 Claude Code

在终端输入：

```bash
npm install -g @anthropic-ai/claude-code
```

等待安装完成。

---

### 配置 Claude Code

**创建配置文件：**

```bash
cd ~
touch .claude.json
```

**打开配置文件：**

1. 打开文件管理器，进入主文件夹
2. 打开左上角菜单，点击"显示隐藏文件"
3. 双击打开刚创建的 `.claude.json`
4. 将配置内容粘贴进去

**需要修改的内容：**

- `apiKey`：从国内 AI 服务商申请
- `baseURL`：从服务商文档中获取

具体方法请参考前面 Windows 和 macOS 章节的详细说明。

**保存并启动：**

```bash
# 保存配置文件

# 启动 Claude Code
claude
```

打个招呼测试是否正常响应。

---

### 安装 VS Code

**下载安装包：**

1. 访问 VS Code 官网，网站会自动识别 Linux Ubuntu 系统
2. 下载左侧的 `.deb` 格式安装包

**安装命令：**

进入下载目录，在终端中输入：

```bash
sudo apt install ./code_xxx_amd64.deb
```

安装完成后，在左下角应用程序中可以看到 VS Code，点击即可运行。

---

### 安装 Chrome 浏览器

**下载 Chrome：**

1. 访问 Chrome 国内版官网
2. 点击下载，选择 `.deb` 格式安装包

**安装命令：**

进入下载目录，在终端中输入：

```bash
sudo apt install ./google-chrome-stable_current_amd64.deb
```

安装完成后，在左下角应用程序中即可找到 Chrome 浏览器。

---

## 常见问题与注意事项

### 关于 Node.js 安装

| 操作系统 | 推荐方式 | 原因 |
|---------|---------|------|
| Windows | 官网安装包 | 简单直接 |
| macOS | **NVM**（必须） | 避免 root 权限问题 |
| Linux | NVM | 便于多版本管理 |

> **macOS 大坑**：不要使用 Node.js 官网安装包，会导致后续出现大量权限问题。

### 关于 Python 虚拟环境

**必须使用虚拟环境的场景：**

- macOS 使用 Homebrew 安装的 Python
- 任何需要同时管理多个项目不同依赖的场景

**提示词建议：**

在与 AI Agent 交互时，主动在提示词中注明要求 AI 使用虚拟环境进行工作。

### 关于 GitHub 访问

国内网络访问 GitHub 的解决方案：

- **Watt Toolkit**：开源免费工具，支持 GitHub 加速
- 也可以使用其他同类工具

### 关于软件安装位置

> **建议**：尽量安装到 C 盘，否则后续调用时可能出现问题。

---

## 弹幕补充信息

以下内容来自视频弹幕区观众的补充和纠错：

| 弹幕内容 | 说明 |
|---------|------|
| `Set-ExecutionPolicy Unrestricted` 这部分可以使用 `cc-switch` 来完成 | Windows 上可以用 cc-switch 替代该步骤 |
| npm 挂国内镜像是大学生入门标配 | 国内网络环境建议配置 npm 镜像以提高安装成功率 |
| nodejs 也可以用 nvm 安装 | 推荐使用 nvm 管理 Node.js 版本 |
| mac 安装 Homebrew 后这些都可以用 Homebrew 来装 | macOS 上 Homebrew 可以安装大部分开发工具 |
| 现在官方好像不用 npm 安装了 | Claude Code 安装方式可能有变化，建议查看最新官方文档 |
| snap 可以安装 VS Code | Linux 上可以用 snap 方式安装 VS Code |
| 可以直接装 | 部分软件支持直接安装，无需复杂配置 |
| 最好安装到 C 盘，不然调死人 | 再次强调软件安装位置的重要性 |
| 要在 BIOS 中开启 CPU 虚拟化 | 运行 WSL 或虚拟机时需要硬件虚拟化支持 |
| 现在官方好像不用 npm 安装了 | 确认安装方式可能有更新 |
| git hub 搜索把可能的关键词每个分别试一下，或组合试一下 | GitHub 搜索技巧的补充 |

---

本教程覆盖了三大操作系统配置 AI Agent 运行环境的完整流程。按照视频演示的操作步骤执行，配合国内网络即可顺利完成所有配置。