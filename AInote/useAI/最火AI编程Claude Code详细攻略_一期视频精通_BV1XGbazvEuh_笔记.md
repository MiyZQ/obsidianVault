# Claude Code 进阶使用技巧完全指南

> 本笔记整理自视频《最火AI编程Claude Code详细攻略，一期视频精通》，涵盖30个高阶使用技巧。

## 目录

1. [安装与启动](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#1-安装与启动)
2. [核心上下文管理命令](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#2-核心上下文管理命令)
3. [思考强度控制](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#3-思考强度控制)
4. [命令行与记忆模式](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#4-命令行与记忆模式)
5. [IDE 集成](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#5-ide-集成)
6. [非交互模式](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#6-非交互模式)
7. [MCP 模型上下文协议](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#7-mcp-模型上下文协议)
8. [权限管理](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#8-权限管理)
9. [自定义命令](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#9-自定义命令)
10. [Hooks 钩子机制](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#10-hooks-钩子机制)
11. [Subagent 子代理](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#11-subagent-子代理)
12. [GitHub 集成](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#12-github-集成)
13. [对话回退与导出](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#13-对话回退与导出)
14. [clouddia 桌面可视化应用](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#14-clouddia-桌面可视化应用)
15. [观众反馈补充](最火AI编程Claude%20Code详细攻略_一期视频精通_BV1XGbazvEuh_笔记.md#15-观众反馈补充)

---

## 1. 安装与启动

### 环境准备

- 需要先安装 **Node.js**（视频提供安装链接）

### 启动方式

| 启动方式 | 命令 | 适用场景 |
|---------|------|----------|
| 官网账户登录 | `claude` | Claude Pro 或 Max 用户 |
| API 接入 | `ccr code` | 使用 Claude Code Router 接入任意大模型 API |
| 非交互模式 | `claude -p <问题>` | 临时一次性对话 |

### 基础使用流程

```bash
# 1. 跳转到项目目录
cd your-project-path

# 2. 启动 Claude Code
claude  # 或 ccr code

# 3. 选择登录方式/输入 API 配置
```

---

## 2. 核心上下文管理命令

### 2.1 `/init` - 项目初始化

**功能**：让 Claude Code 通读整个项目文件夹，生成 `claude.md` 文件作为长期上下文。

```bash
/init
```

**工作原理**：
1. Claude Code 分析当前目录下的所有文件
2. 将项目知识保存到 `claude.md` 文件
3. 后续所有对话都会携带这个文件作为上下文

**文件位置**：`项目目录/.claude.md`

**文件作用**：
- 帮助 AI 更快速理解项目结构和业务逻辑
- 类似于 Cursor 中的 `cursor rules`
- 可手动修改，添加你认为重要的信息（如使用的 CSS 框架知识等）

### 2.2 `/compact` - 上下文压缩

```bash
/compact <指令>
```

**功能**：压缩对话上下文，排除无关内容，提高 AI 专注度，显著降低 token 消耗。

### 2.3 `/clear` - 清除对话

```bash
/clear
```

**最佳实践**：每当开启新任务时，先执行 `/clear` 清除历史对话，保持干净的上下文环境。

---

## 3. 思考强度控制

这是**官方文档支持的**控制模型思考长度的方法：

| 思考强度 | 命令 | 适用场景 |
|---------|------|----------|
| 普通思考 | `/think` | 一般任务 |
| 深度思考 | `/think hard` | 较复杂推理 |
| 更深度思考 | `/think harder` | 困难推理任务 |
| 超深度思考 | `/ultrathink` | 最复杂的推理任务 |

**使用场景**：在开始比较困难的推理任务之前，加上这些提示词可以增加 AI 的思考长度。

> ⚠️ **观众反馈**：新版本 Claude Code 会在必要时自动使用 ultrathink，无需手动添加。

---

## 4. 命令行与记忆模式

### 4.1 `!` - 临时命令行模式

```bash
!<命令>
# 例如：!npm install
```

**功能**：在不离开 Claude Code 的情况下执行临时命令行命令。

**优势**：
- 命令执行结果和过程会自动加入对话上下文
- AI 能看到依赖安装的过程，后续不会重复执行安装命令

### 4.2 `#` - 记忆模式

```bash
# <记忆内容>
```

**功能**：将输入的内容保存为 AI 的长期记忆。

**保存位置选项**：
- **项目级别**：保存到当前项目的 `claude.md` 文件
- **用户级别**：保存到 Claude Code 配置目录
  - Windows 路径：`C:\Users\<用户名>\.claude\claude.md`

**示例**：
```bash
# 项目使用的 NextJS 版本是 15.4.1
```

---

## 5. IDE 集成

### 5.1 `/init` - VS Code 集成

**前置条件**：在 VS Code 中安装插件 **"Claude Code for VS Code"**

**配置步骤**：
1. 在 VS Code 中安装插件
2. 在 Claude Code 中输入 `/init`
3. 选择 VS Code

**功能**：
1. **代码感知**：Claude Code 能读取你在 VS Code 中选中的代码
2. **修改预览**：代码修改时，VS Code 会弹出对比页面显示修改前后差异

### 5.2 编辑流程

```
Claude Code 修改代码 → VS Code 弹出差异预览 → 用户选择是否接受
```

---

## 6. 非交互模式

### 使用方式

```bash
claude -p "<问题>"
# 或使用 CCR：ccr code -p "<问题>"
```

**功能**：Claude Code 在后台进行思考并处理问题，完成后直接打印结果。

**适用场景**：快速获得回答，无需交互式对话。适合脚本调用、自动化任务。

---

## 7. MCP 模型上下文协议

### 7.1 什么是 MCP

**MCP** (Model Context Protocol) 是 AI 与外部工具的中间层协议，可以代替人类访问和操作外部工具。

### 7.2 安装 MCP Server

#### 本地安装

```bash
claude mcp add <名称> -- <启动命令>
```

**示例：安装 claude (代码文档查询)**

```bash
claude mcp add context7 -- <启动命令>
# 根据提示填写启动参数
# 例如：npx <参数>
```

#### 作用域级别

| 参数 | 作用域 | 说明 |
|-----|-------|------|
| 无参数 | 项目级别 | 仅在当前项目生效 |
| `--scope user` | 用户级别 | 所有项目生效 |

#### 远程 MCP Server 安装

**SSE 协议**：
```bash
claude mcp add <名称> -- <SSE 配置>
```

**Streamable HTTP 协议**：
```bash
claude mcp add <名称> -- <协议> -- <MCP名称> -- <服务地址>
```

### 7.3 使用 MCP

```bash
# 查看已安装的 MCP
/init

# 调用特定 MCP
请问如何使用 context7 查询 Tailwind V4 的配置？
```

### 7.4 删除 MCP Server

```bash
claude mcp remove <MCP名称>
# 示例：cloud mcp remove context7
```

### 7.5 实战案例：Tailwind V3 升级到 V4

```bash
# 1. 启动 Claude Code
ccr code

# 2. 让 AI 使用 Context7 查询 Tailwind V4 文档
请使用 context7 查询 Tailwind V4 的升级文档，
帮我把当前 Tailwind V3 项目升级到 V4

# 3. Claude Code 会：
#    - 调用 MCP 工具查找到最新文档
#    - 列出需要修改的内容
#    - 逐个文件进行修改
#    - 自动执行 npm install 安装依赖
#    - 验证项目正常运行
```

### 7.6 常用 MCP Server

| MCP 名称   | 用途           |
| -------- | ------------ |
| context7 | 查询最新代码文档     |
| notion   | Notion 数据库操作 |
| (其他 MCP) | 视频中未详细介绍     |

---

## 8. 权限管理

### 8.1 `/permissions` 命令

**功能**：自定义权限规则，控制 Claude Code 调用工具时是否需要人工确认。

```bash
/permissions
```

#### 规则类型

| 规则类型 | 作用 |
|---------|------|
| `allow` | 添加到允许列表，调用时无需确认 |
| `deny` | 添加到禁止列表，禁止调用 |

#### 规则格式

**内置工具格式**：
```
bsh:<具体命令>
# 示例：bsh:git-commit
```

**MCP 格式**：
```
mcp:<mcp名称>
```

#### 保存级别

- **项目设置**：仅当前项目生效
- **用户设置**：对所有项目生效

### 8.2 示例：允许 Git 命令自动执行

```bash
# 添加一条规则：以后执行 git commit 不需要申请权限
/permissions
# 选择 allow
# 输入规则：bsh:git-commit
# 选择保存级别
```

### 8.3 `--dangerously-skip-permissions` 最高权限模式

**启动命令**：
```bash
claude --dangerously-skip-permissions
# 或使用 CCR：
ccr code --dangerously-skip-permissions
```

**功能**：赋予 Claude Code 最高权限，使用任意工具、执行任意命令都无需申请权限。

> ⚠️ **警告**：这意味着 Claude Code 可以执行删除文件等危险操作，甚至可以删除 C 盘等系统目录，**不要轻易使用**。

---

## 9. 自定义命令

### 9.1 命令文件夹位置

```
项目目录/.claude/commands/
# 或用户级别：
~/.claude/commands/
```

### 9.2 创建自定义命令

1. 在 `commands` 文件夹中创建 `.md` 文件
2. 文件名即为命令名称
3. 文件内容描述命令要执行的任务

### 9.3 示例：Code Review 命令

**创建文件**：`项目目录/.claude/commands/code-review.md`

**文件内容**：
```markdown
帮我对比 $ARGUMENTS 分支与 main 分支的差异，
提出完整的代码审核意见。
```

**使用方式**：
```bash
# 调用自定义命令
/code-review feature-branch-name
```

### 9.4 作用域说明

| 文件夹位置                     | 作用域   |
| ------------------------- | ----- |
| 项目目录 `/.claude/commands/` | 仅当前项目 |
| `~/.claude/commands/`     | 所有项目  |

---

## 10. Hooks 钩子机制

### 10.1 功能

Hooks 允许 Claude Code 在特定时机自动执行某些操作。

### 10.2 配置位置

| 文件名                 | 优先级   | 说明         |
| ------------------- | ----- | ---------- |
| `claude.json`       | 低     | 全局配置       |
| `claude.local.json` | **高** | 本地配置（优先读取） |

**文件位置**：项目目录 `/.claude/` 下

### 10.3 触发事件

常见触发事件：
- `postToolUse`：工具调用完成后触发

### 10.4 示例：自动代码格式检查

**场景**：让 AI 写完代码后自动执行 Prettier 检查格式。

**配置**：
```json
{
  "hooks": {
    "postToolUse": {
      "tools": ["Edit", "Write", "Bash"],
      "command": "npx prettier --check ."
    }
  }
}
```

**工作流程**：
```
AI 修改代码 → Hook 触发 → 执行 prettier --check → 
发现问题 → AI 自动修复
```

### 10.5 更多触发事件

参考官方文档获取完整的触发事件列表。

---

## 11. Subagent 子代理

### 11.1 概念

Subagent 类似于编程中的子线程，可以让 Claude Code 在后台开启多个子任务**并行执行**，提高任务执行效率。

### 11.2 创建 Subagent

```bash
/ag
# 选择 create
# 选择存储级别（项目/用户）
# 填写 agent 描述
# 选择工具权限
# 选择模型
# 选择颜色标识
```

### 11.3 配置文件位置

```
项目目录/.claude/agents/<agent-name>.md
```

### 11.4 配置示例

**Agent 1：代码审核大师**
```yaml
描述：帮我比较 git 分支之间的差异，提出审核意见
工具权限：选择需要的工具
模型：选择模型
颜色：红色
```

**Agent 2：天气预报大师**
```yaml
描述：用联网工具查询天气
工具权限：联网搜索
模型：选择模型
颜色：蓝色
```

### 11.5 使用 Subagent

```bash
/ag
# 选择需要的 subagent
# 输入任务描述
```

### 11.6 执行原理

```
主任务 → 自动拆分 → 分配给不同 subagent（并行执行）
         ↓
    各自获取精简上下文（不受主对话污染）
         ↓
    完成后 → 主 agent 整合结果 → 完整回答
```

---

## 12. GitHub 集成

### 12.1 前置条件

安装 **GitHub CLI**：
1. 访问 GitHub Releases 下载对应系统的安装包
2. 安装后验证：`gh` 命令

### 12.2 基本操作

```bash
# 查看 GitHub 仓库
gh repo list

# 查看 Issues
gh issue list

# 查看某个 Issue
gh issue view <issue-number>
```

### 12.3 实战案例：修复 GitHub Issue

**场景**：用户提交 Issue 反映"还没画完 AI 就开始猜了，缺少提交按钮"

**解决流程**：
```bash
# 1. 让 Claude Code 查看 Issue
请查看 issue number 1 的内容，并进行修复

# 2. Claude Code 自动：
#    - 读取 Issue 内容
#    - 分析代码问题
#    - 创建修复分支
#    - 修改代码
#    - 推送回 GitHub
```

### 12.4 形成闭环

```
GitHub Issue → Claude Code 读取 → 本地修复 → 推送回 GitHub
```

---

## 13. 对话回退与导出

### 13.1 `/resume` - 恢复历史对话

```bash
/resume
```

**功能**：查看并恢复之前的对话话题，敲两下 ESC 可跳转到历史对话的前面继续。

**限制**：只能回退对话内容，不能回退代码。

### 13.2 cc-undo - 同时回退对话和代码

**工具**：GitHub 开源项目 `cc-undo`

```bash
# 安装 cc-undo

# 列出历史记录
cc-undo list
# 输出：列出所有对话记录，前面有编号

# 回退到指定节点
cc-undo <编号>
# 同时回退对话内容和代码
```

### 13.3 `/export` - 导出对话

```bash
/export
# 选择第一个选项：复制到粘贴板
```

**用途**：
- 保存对话历史
- 粘贴给其他 AI 进行交叉验证

---

## 14. clouddia 桌面可视化应用

### 14.1 简介

clouddia 是基于 Claude Code 的**桌面可视化应用**，GitHub 拥有 1 万多 star。

### 14.2 安装

**方式一**：从源码编译（繁琐）

**方式二**：使用社区维护版（有现成安装包）

1. 访问 GitHub 搜索 `clouddia`
2. 进入 `Insights` → `Forks`
3. 找到 star 最多的分叉项目
4. 在 Releases 下载对应系统的安装包
5. 一路点击下一步安装

### 14.3 配置

**官网账户用户**：打开即可直接使用

**API/CCR 用户**：需要额外配置环境变量

1. 点击右上角设置
2. 在"环境"中配置：
   - `ANTHROPIC_API_KEY` = 从 Claude Code 的 `/status` 获取
   - `ANTHROPIC_BASE_URL` = 从 Claude Code 的 `/status` 获取

### 14.4 主要功能

| 功能 | 说明 |
|-----|------|
| 可视化对话 | GUI 界面操作 |
| MCP 管理 | 可视化配置 MCP |
| context9.md 编辑 | 可视化编辑系统提示词 |
| 使用仪表盘 | 查看使用统计 |
| subagent 配置 | 可视化创建和管理子代理 |
| hooks 设置 | 可视化配置钩子 |
| 多标签页 | 方便管理多个对话 |
| **Checkpoint 检查点** | 保存/恢复整个状态（对话+文件） |

### 14.5 Checkpoint 功能（核心亮点）

**功能**：同时回退对话内容和文件改动。

```bash
# 1. 创建检查点
在时间轴上点击 "Create checkpoint"

# 2. 执行操作（如删除文件）
让 AI 删除文件2

# 3. 发现误操作，恢复检查点
点击原来的检查点 → "Restore checkpoint"

# 4. 结果：文件和对话都恢复到之前状态
```

**对比原版 Claude Code**：
| 功能 | 原版 Claude Code | clouddia |
|-----|-----------------|----------|
| 对话回退 | ✅ | ✅ |
| 文件回退 | ❌ | ✅ |
| 检查点 | ❌ | ✅ |

---

## 15. 观众反馈补充

> 以下内容整理自视频弹幕和评论区的有价值反馈：

### 15.1 版本相关

| 反馈内容 | 说明 |
|---------|------|
| 记忆模式（#）在 2.0.76 版本已移除 | 新版本可能已不支持 |
| 现在使用 `skill` 了 | 新版本可能有新的机制 |
| ultrathink 不需要手动添加 | Claude Code 会自动在必要时使用 |

### 15.2 安装建议

| 反馈内容 | 说明 |
|---------|------|
| Windows 添加 `-y` 会报错 | 安装命令中不要加 `-y` |
| 直接用 `scoop` 装更整洁 | 推荐使用 scoop 包管理器安装 Node.js |

### 15.3 权限警告

> ⚠️ `--dangerously-skip-permissions` 模式可以获取全系统权限，不局限于当前目录，**有人这么搞结果被删掉根目录了**。非必要不要使用。

### 15.4 工具对比

| 问题 | 回答 |
|-----|------|
| clouddia 与 Rewind 区别？ | clouddia 是 Claude Code 的可视化界面，Rewind 是另一个工具 |
| Claude Code CLI vs Trae IDE 哪个更快？ | 如果使用相同模型，CLI 和 IDE 本身不影响速度，但 IDE 可能更直观 |

### 15.5 相关工具

| 工具名 | 说明 |
|-------|------|
| `claude -p` | 非交互模式 |
| `ccr code` | Claude Code Router |
| `cc-undo` | 对话+代码同时回退工具 |
| `clouddia` | 桌面可视化应用 |

---

## 总结

本文涵盖了 Claude Code 的 30 个进阶使用技巧，主要包括：

| 类别 | 技巧数量 |
|-----|---------|
| 上下文管理 | 3 个（init/compact/clear） |
| 思考控制 | 4 个（think 系列） |
| 工具集成 | 5+ 个 |
| MCP | 安装/使用/删除 |
| 权限管理 | 2 种方式 |
| 自定义命令 | 创建/使用 |
| Hooks | 配置/触发 |
| Subagent | 创建/并行执行 |
| GitHub 集成 | CLI 集成 |
| 对话管理 | resume/export/undo |
| 可视化 | clouddia/checkpoint |

更多细节和最新功能请参考 [Claude Code 官方文档](https://docs.anthropic.com/claude-code)（提供简体中文版）。