# Agent Skills 详细攻略

## 目录

- [1. 概述与背景](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#1-概述与背景)
- [2. 技术原理：渐进式提示词披露](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#2-技术原理渐进式提示词披露)
- [3. Claude Code 配置与使用](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#3-claude-code-配置与使用)
- [4. Codex 配置与使用](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#4-codex-配置与使用)
- [5. 使用社区分享的 Skills](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#5-使用社区分享的-skills)
- [6. 进阶用法：资源层](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#6-进阶用法资源层)
- [7. Skills 与 MCP 对比](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#7-skills-与-mcp-对比)
- [8. Skills 配合 MCP 实战](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#8-skills-配合-mcp-实战)
- [9. 避坑指南](Agent%20Skills%20_Claude%20Skills_%20详细攻略_一期视频精通_BV1HuiyBQE9G_笔记.md#9-避坑指南)

---

## 1. 概述与背景

### 什么是 Agent Skills

Agent Skills 是一种带目录的说明书，或者说是一种**渐进式披露提示词（Progressive Disclosure）的机制**。它将提示词分成三层结构，只有目录层（Metadata）是必定加载进 AI 上下文的，剩下的两层按需加载。

### 发展历程

- **最初**：Agent Skills 只是 Claude 中的一个小功能模块
- **最近两个月**：越来越多人发现 Skills 非常好用
- **Codex、Cursor、OpenCode 等工具**：陆续加入了对 Agent Skills 的支持
- **2025年12月18日**：Anthropic 正式把 Agent Skills 发布成开放标准，朝着通用、跨平台规范方向发展

### 核心优势

相比传统的 Prompt 或 MCP 方式，Agent Skills 的最大好处是**大幅降低了 Token 消耗与提示词的复杂度**。

---

## 2. 技术原理：渐进式提示词披露

### 三层架构

| 层级 | 名称 | 类比 | 加载方式 |
|------|------|------|----------|
| 第一层 | 原数据（Metadata） | 书籍目录 | 必定加载 |
| 第二层 | 指令（Instructions） | 正文内容 | 按需加载 |
| 第三层 | 资源（Resources） | 附录资料 | 按需加载 |

### 工作流程

```
用户提问 → Agent 扫描所有 skill.md 文件 → 提取 Metadata 形成技能列表
          ↓
AI 根据知识判断 → 可直接回答 或 选择某个 Skill
          ↓
Agent 执行 Skill 加载 → 把 skill.md 的指令细节发送给 AI
          ↓
如需资源 → 按需读取 references/scripts 等辅助文件
          ↓
AI 综合所有信息 → 生成完整回答
```

### 关键设计思想

1. **渐进式披露**：AI 先获取目录，根据需要再决定是否查阅正文与附件
2. **按需加载**：只有必要的提示词内容才会进入上下文
3. **上下文精简**：Metadata 都很简短，大幅减少模型上下文占用

---

## 3. Claude Code 配置与使用

### 3.1 Claude Code 安装

**安装命令**（从 Claude Code 官网复制）：

```bash
# 粘贴到终端执行
```

> 注：最近 Claude Code 的安装方式发生了变化。

### 3.2 配置第三方模型

如果需要使用非官方账户的模型，可以手动配置：

**配置文件位置**：
- Windows：`C:\Users\<用户名>\.claude\claude.json`
- macOS：`~/.claude/claude.json`

**新建配置文件** `~/.claude/claude.json`，内容示例（使用智谱 GLM 模型）：

```json
{
  "analyticsProvider": "logfire",
  "auth": {
    "type": "token",
    "token": "your-token-here"
  }
}
```

> 注意：这里的 token 需要在智谱 AI 开放平台创建。

**跳过登录验证**：在配置文件中添加：

```json
{
  "analyticsProvider": "logfire",
  "auth": {
    "type": "token",
    "token": "your-token-here"
  },
  "skipAuthCheck": true
}
```

### 3.3 创建 Skill 文件结构

Skills 以文件夹形式存放在项目目录 `.claude/skills/` 下：

```
项目根目录/
├── .claude/
│   └── skills/
│       ├── skill-name-1/
│       │   ├── skill.md          # 必须：定义文件
│       │   ├── scripts/         # 可选：可执行脚本
│       │   ├── references/      # 可选：补充文档
│       │   └── assets/          # 可选：图片等资源
│       └── skill-name-2/
│           └── skill.md
```

**关键要点**：
1. 每个 Skill 是一个文件夹
2. 定义文件必须命名为 `skill.md`（大写 skill，小写 md）
3. `skill.md` 中必须包含 Metadata（原数据）

### 3.4 Skill 定义文件格式

`skill.md` 文件结构：

```markdown
---
name: 字幕转markdown
description: 当用户上传 SRT 字幕文件时，调用此 skill 进行处理
---

# 指令部分

## 角色定义
你是一个专业的字幕文本处理助手。

## 任务要求
任务就是把 SRT 字幕文件转换成 Markdown 笔记，禁止任何删减总结或省略，必须保留所有的文字。

## 输出格式
在关键位置插入截图占位符，例如：
- 原始数据：`[screenshot: 00:05:30]`
- 输出格式：`![截图 00:05:30](assets/screenshot_00_05_30.png)`
```

### 3.5 使用自定义 Skill

**启动 Claude Code**：

```bash
# 在项目根目录右键打开终端
claude
```

**查看可用 Skills**：

```
/skills
```

**测试 Skill**：

1. 把 SRT 字幕文件拖拽到 Claude Code
2. Claude Code 检测到字幕文件，询问是否使用 "字幕转 markdown" skill
3. 选择 `yes`
4. AI 先加载 Metadata（目录），确认使用 Skill 后才加载指令（正文）
5. AI 要求读取 SRT 文件
6. 确认后完成转换
7. 在项目根目录生成 Markdown 格式笔记

### 3.6 全局 Skills 配置

创建的 Skills 不仅可以在当前项目生效，也可以变成**全局 Skills**：

**全局配置目录**：
- Windows：`C:\Users\<用户名>\.claude\`
- macOS：`~/.claude/`

**操作步骤**：

1. 打开 `~/.claude/` 目录
2. 新建 `skills` 文件夹
3. 将项目中的 Skills 文件夹复制到此处
4. 全局 Skills 在所有项目中都可使用

### 3.7 示例：来点选题 Skill

**创建路径**：`.claude/skills/来点选题/skill.md`

**内容示例**：

```markdown
---
name: 来点选题
description: 当用户视频创作选题枯竭时，为用户提供对应的选题思路
---

# 视频选题生成器

## 角色
我是一个视频作者助手。

## 输入
用户提供过去数据较好的视频选题。

## 输出
根据这些选题，挑选 10 到 15 个类似的灵感，用中文输出。
```

**测试**：

```
用户：帮我生成一些视频选题灵感
Claude Code：调用 "来点选题" skill，生成 15 个选题
```

---

## 4. Codex 配置与使用

### 4.1 Codex 安装

Codex 的安装步骤在之前一期视频中有完整介绍，本期不再赘述。

> 注：Agent Skills 在 Codex 中仍是**实验性功能**，需要手动开启。

### 4.2 开启 Skills 功能

**配置文件位置**：`C:\Users\<用户名>\.codex\config`

**修改配置文件**，添加：

```json
{
  "experimental": {
    "agentSkills": true
  }
}
```

保存配置文件。

### 4.3 迁移 Skills 从 Claude Code 到 Codex

迁移非常简单，只需要修改路径中的目录名：

**原路径**：
```
~/.claude/skills/字幕转markdown/
~/.claude/skills/来点选题/
```

**新路径**：
```
~/.codex/skills/字幕转markdown/
~/.codex/skills/来点选题/
```

### 4.4 为 Codex 新建项目配置

**项目目录结构**：

```
skill-codeex/
├── .codex/
│   └── skills/
│       ├── 字幕转markdown/
│       │   └── skill.md
│       └── 来点选题/
│           └── skill.md
```

### 4.5 使用 Codex 的 Skills

**启动 Codex**：

```bash
# 在项目根目录右键打开终端
codex
```

**查看可用 Skills**：

```
/skills
```

**测试**：

```
用户：我不知道做什么视频
Codex：调用 "来点选题" skill，生成 15 个选题，效果不错
```

---

## 5. 使用社区分享的 Skills

### 5.1 热门社区资源

**Awesome Claude Skills**：https://github.com/ComposioHQ/awesome-claude-skills
- 已有 14000+ star
- 收录了大量社区分享的成熟 Skills

**Anthropic 官方 Skills 仓库**：https://github.com/anthropics/skills

### 5.2 使用他人 Skill 的步骤

1. 访问 GitHub 仓库，点击 `Code` → `Download ZIP` 下载代码
2. 解压后找到需要的 Skill 文件夹
3. 将整个文件夹拖拽到 `.claude/skills/` 或 `.codex/skills/` 目录
4. 重启 Claude Code / Codex

### 5.3 示例：域名头脑风暴 Skill

**使用流程**：

1. 下载 Awesome Claude Skills 仓库
2. 找到 "域名头脑风暴" Skill 文件夹
3. 将整个文件夹拖拽到 Codex 的 skills 目录
4. 重启 Codex

**测试**：

```
用户：我叫技术爬爬虾，是一个计算机科技类的视频博主，我应该用什么域名？
Codex：调用 "域名头脑风暴" skill，推荐一批域名
```

---

## 6. 进阶用法：资源层

### 6.1 资源层概述

Skill 文件夹中不仅能存放 `skill.md`，还可以放入任意类型的辅助文件作为**资源**：

| 资源类型 | 推荐子文件夹 | 用途 |
|----------|--------------|------|
| 可执行脚本 | `scripts/` | 自动化处理 |
| 补充文档 | `references/` | 参考资料、范文 |
| 图片资源 | `assets/` | 图片等资源 |

### 6.2 示例：视频截图脚本

**需求**：第一版字幕转 markdown skill 生成的 Markdown 文件中，截图位置只是占位符标记，需要真正的截图。

**解决方案**：编写 Python 脚本调用 FFmpeg 对视频进行截图。

**Python 脚本示例**（需要放到 `scripts/` 目录）：

```python
# scripts/generate_screenshots.py
# 使用 FFmpeg 从视频中截取指定时间点的图片
```

**完善 Skill 指令**，在 `skill.md` 指令部分添加：

```markdown
## 后续处理
markdown 生成完毕以后，调用 scripts/ 目录下的截图脚本，对视频进行截图。
```

> 注意：Agent Skills **只执行脚本**，脚本内的代码**不作为上下文传递给 AI**，最大程度降低 Token 消耗。

### 6.3 测试带脚本的 Skill

1. 把字幕文件和对应的视频都放到项目目录
2. 打开 Claude Code，把字幕文件拖拽进去
3. Claude Code 调用 "字幕转 markdown" skill
4. 生成带截图标记的笔记文件
5. Claude Code 调用 Python 脚本对视频截图
6. 最终生成含图片的 Markdown 笔记

### 6.4 示例：帮我写作 Skill（References 用法）

**需求**：结合用户提供的材料进行文案写作，如果是软件/AI/计算机相关，需要先阅读范文学习写作风格。

**创建路径**：`.claude/skills/帮我写作/`

**目录结构**：

```
帮我写作/
├── skill.md
└── references/
    └── style_guide.md    # 风格指南范文
```

**skill.md 示例**：

```markdown
---
name: 帮我写作
description: 当用户需要结合材料进行文案写作时调用此 Skill
---

# 文案写作助手

## 任务
结合用户提供的材料进行文案写作。

## 特殊处理
如果材料是软件、AI、计算机相关的，需要先阅读 references/ 目录下的范文，学习用户的写作风格后再进行写作。
```

**references/style_guide.md**：放入自己的 Markdown 笔记作为范文。

**测试流程**：

1. 用户提供 Open Code 开源项目的零碎资料
2. 要求 Claude Code 帮忙写作
3. Claude Code 调用 "帮我写作" skill
4. AI 意识到是 AI 相关文章，需要阅读范文
5. AI 调用 read 方法读取 `references/style_guide.md`
6. 学习行文风格后，输出与用户风格相近的深度文案
7. 保存任务完成

### 6.5 调用过程分析

```
用户提问 → Claude Code 扫描 skill.md → 提取 Metadata
          ↓
AI 判断 → 需要使用 "帮我写作" skill
          ↓
Claude Code 加载 skill.md 指令部分
          ↓
AI 意识到需要读取 references/ 目录的范文
          ↓
AI 调用 read 方法读取参考文献
          ↓
AI 学习行文风格后输出文案
```

**资源层按需加载体现**：AI 按照指令需要，只把必要的文档加载进上下文，而非一次性加载所有内容。

---

## 7. Skills 与 MCP 对比

### 7.1 功能对比

| 维度 | Agent Skills | MCP |
|------|--------------|-----|
| **重点** | 提示词管理 | 工具调用 |
| **核心机制** | 渐进式提示词披露 | 标准化工具协议 |
| **类比** | 带目录的说明书 | 标准化的工具箱 |
| **主体** | Markdown 文本文件 | Node.js/Python 软件包 |
| **执行脚本** | 辅助功能（跨平台兼容性差） | 核心功能（执行成功率高） |
| **编写难度** | 小（只需写 Markdown） | 大（需搭建完整开发环境） |

### 7.2 提示词加载方式

- **Skills**：按需加载，只加载必要的提示词
- **MCP**：一次性将提示词塞入上下文

### 7.3 Token 消耗

- **Skills**：Token 消耗较小
- **MCP**：需要一次性加载较多内容

### 7.4 脚本执行问题

**Skills 的坑**：每台电脑的 Python 环境不一样，Skill 脚本执行失败的概率比较高。

**建议**：换成 `.cmd`、`.ps1` 或按系统分发的二进制文件可以改善兼容性。

### 7.5 各自的适用场景

| 场景 | 推荐方案 |
|------|----------|
| 管理提示词/工作流 | Skills |
| 标准化工具调用 | MCP |
| 快速原型/轻量级任务 | Skills |
| 复杂工具集成 | MCP |

### 7.6 发展趋势讨论

如果 MCP 能够吸收 Skills 的以下优点：
- 渐进式披露提示词
- 编写简单

推出 **MCP 2.0** 版本，可能是以后一个很好的发展方向。

---

## 8. Skills 配合 MCP 实战

### 8.1 目标

使用 Skills 管理提示词，使用 MCP 调用工具，实现协作工作。

### 8.2 配置 GitHub MCP Server

**参考资源**：GitHub MCP Server 官方页面有详细安装方式。

**安装命令**（在 Claude Code 项目目录执行）：

```bash
npx @anthropic-agents/github-mcp-server install --github-token <your-token>
```

**API Token 创建**：
1. 访问 GitHub Settings → Developer settings → Personal access tokens
2. 点击 `Generate new token (classic)`
3. 设置权限：
   - 仓库权限：`repo` (全部)
   - 在 Permissions 中找到 `administration` 和 `contents`，设置为 `read-write`
4. 创建 Token 并复制

**填入安装命令后回车**，GitHub MCP Server 安装完成。

### 8.3 配置 Skills + MCP 协作

**修改 "帮我写作" skill**，在 `skill.md` 中添加后续处理指令：

```markdown
## 后续处理
先检查用户名下有没有叫做 AIDooc 的 GitHub 仓库。
如果没有，就用 create repository 这个 MCP 工具来创建一个仓库。
用 create or update file 这个工具上传到 GitHub 仓库里面。
```

> 提示：在 MCP server 首页一般都有详细的工具介绍，可以在提示词里写清楚想让 AI 调用哪个具体工具，有助于提高调用效率。

### 8.4 测试完整流程

**操作步骤**：

1. 启动 Claude Code
2. 让 Claude Code 写一个关于 AI 的文案
3. Claude Code 调用 "帮我写作" skill，写好科技文案
4. Claude Code 调用 GitHub MCP server：
   - 检查用户是否有 "AIDooc" 仓库
   - 如果没有，调用 `create repository` 工具创建仓库
   - 调用 `create or update file` 工具上传文件

**验证**：访问 GitHub 仓库，文案已成功上传备份。

### 8.5 协作模式总结

```
Skills 负责：
└── 披露提示词（什么时候调用什么工具、如何组织工作流程）

MCP 负责：
└── 具体工具调用（创建仓库、上传文件等）
```

---

## 9. 避坑指南

### 9.1 Skill 定义文件命名

- **文件名必须是**：`skill.md`（大写 skill，小写 md）
- 错误示例：`Skill.md`、`SKILL.md`、`skill.MD`

### 9.2 Metadata 位置

Metadata 必须写在 `skill.md` 文件开头，用三个横杠 `---` 包裹：

```markdown
---
name: skill-name
description: 当...时调用此 skill
---

# 指令内容
```

### 9.3 脚本兼容性

- Python 脚本在不同机器上环境不一致，容易失败
- 建议使用跨平台方案：`.cmd`、`.ps1` 或系统二进制文件

### 9.4 Skill 迁移注意事项

- 从 Claude Code 迁移到 Codex：把路径中的 `.claude` 改为 `.codex` 即可

### 9.5 MCP 工具调用效率

- 在提示词中明确写出希望 AI 调用的具体工具名称
- 参考 MCP server 首页的工具文档

### 9.6 资源层使用建议

- `references/` 目录放范文和参考文档
- `scripts/` 目录放自动化脚本
- `assets/` 目录放图片等静态资源
- 脚本代码不会被传给 AI，最多只传递脚本执行结果

### 9.7 全局 vs 项目级 Skills

- 项目级 Skills：放在项目 `.claude/skills/` 目录
- 全局 Skills：放在 `~/.claude/skills/` 目录
- 全局 Skills 可通过软链接让其他工具使用

---

## 相关资源链接

| 资源 | 链接 |
|------|------|
| 本期 Skills 源代码仓库 | https://github.com/tech-shrimp/agent-skills-examples |
| Agent Skills 开放标准 | https://agentskills.io/specification |
| Awesome Claude Skills | https://github.com/ComposioHQ/awesome-claude-skills |
| Anthropic 官方 Skills 仓库 | https://github.com/anthropics/skills |

---

## 弹幕精选（补充知识）

- **Skill Creator**：可以使用 Skills 里面自带的 `skill-creator` 进行 Skill 生成
- **npx skills**：可以全局安装 Skills，项目或其他工具用软连接
- **本质理解**：Skills 本质上就是一个结构化 prompt / 外挂提示词
- **功能类比**：像酒馆的预设 / 23 年的 GPT Store
- **技术层面**：可以理解为把 function call 协议定得比较清楚
- **发展趋势**：如果把代码执行引擎也加进来，Skills 就完美了
- **隐私安全**：使用他人 Skill 包可能存在隐私安全问题