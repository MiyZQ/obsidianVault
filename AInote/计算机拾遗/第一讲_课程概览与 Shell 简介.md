# 计算机教育中缺失的一课 · 第一讲：课程概览与 Shell 简介

***阅读之前先看：***
[讲义（里面有习题）](http://missing-semester-cn-llm.oceansudo.com/)


## 课程背景与动机

### 为什么开设这门课

MIT 三位博士毕业生 Jon、Aniche、Jose 在读研期间担任助教时发现一个普遍现象：学生来问问题，但很多问题其实**不是课程内容本身，而是如何使用工具**——比如怎么用终端、怎么用文本编辑器、怎么高效地完成日常任务。

核心洞察：
- **计算机可以自动化我们与计算机交互的任务**
- 学生不知道这些工具的存在，也不知道可以提问——这是"未知的未知"
- 前人已经解决了大量类似问题，但这些方案不会出现在编译原理或算法课里

### 课程设计理念

这是一门"暴露疗法"式的课程：
- 展示什么是可能的、哪些工具值得了解
- 不可能深入讲解所有工具的每个细节
- 鼓励学生课后就工具自行阅读和实验
- 每节课都配有练习题，是真正学习的关键

---

## 课程信息

| 项目 | 说明 |
|------|------|
| 课时 | 共 9 节，每节 1 小时 |
| 时间 | 每天 1:30 PM（周五 3 PM），周一休息 |
| 最后一节 | Q&A 专题 |
| 录像 | 发布到 YouTube |
| 提问渠道 | Discord 频道（论坛形式）、邮件 |

---

## Shell 是什么

### 定义

**Shell** 是电脑的**文本界面**（textual interface），你输入命令，它执行并打印输出。它先于所有 GUI 存在，是与电脑交互的"核心语言"。

Shell 运行在 **Terminal**（终端）里。Terminal 是 GUI 窗口，Shell 是里面的程序。

### 为什么用 Shell

| GUI | Shell |
|-----|-------|
| 只能做预设的操作 | 可以写任意命令 |
| 不同程序难以组合 | 天生支持程序组合（管道） |
| 复杂任务操作繁琐 | 熟练后效率极高 |
| —— | 本质是编程语言，可自动化 |

实际用途：
- 与开源社区交互（安装、构建、运行工具都靠 Shell）
- CI/CD 配置（软件如何构建、测试、部署）
- 快速完成任务、自动化重复操作

---

## 如何打开终端

| 系统 | 方法 |
|------|------|
| Linux | `Ctrl+Alt+T` 或搜索 "terminal" |
| macOS | `Cmd+Space` 打开 Spotlight，搜索 "terminal" |
| Windows | `Win+R`，输入 `cmd` 或 `powershell` |

> Windows 用户建议安装 **WSL**（Windows Subsystem for Linux）或 Linux 虚拟机，以获得完整的 Bash/Zsh 体验。

---

## 常用 Shell 类型

| Shell | 说明 |
|-------|------|
| **Bash** (Bourne Again Shell) | Linux 默认 |
| **Zsh** (Z Shell) | macOS 默认，部分 Linux 发行版默认；Bash 兼容，功能更丰富 |
| **Fish** | 专为人类友好设计，不完全兼容 Bash |
| **PowerShell** | Windows 新版 Shell，概念相似但语法不同 |

本课程主要使用 **Bash 及 Zsh**。

---

## Shell 提示符（Prompt）解读

```bash
[John@XEO:~]$
```

| 部分     | 含义                     |
| ------ | ---------------------- |
| `John` | 用户名                    |
| `XEO`  | 主机名                    |
| `:`    | 分隔符                    |
| `~`    | 当前目录（`~` = 家目录）        |
| `$`    | 非 root 用户（`#` 表示 root） |

---

## 基本命令

### date —— 显示日期

```bash
date
```

### echo —— 打印参数

```bash
echo hello world
# 输出: hello world
```

### 引号与转义

Bash 按**空格**分割参数。用以下方式处理包含空格的参数：

```bash
echo "hello world"      # 双引号：保留内容
echo 'hello world'      # 单引号：字面值
echo hello\ world       # 反斜杠转义空格
```

**注意**：
- 单引号内不能嵌套单引号
- 混合单引号、双引号、反斜杠可以处理复杂情况

---

## man —— 查看命令手册

```bash
man echo       # 查看 echo 的完整手册
man date       # 查看 date 的手册
man bash       # Bash 手册（非常详尽）
```

短帮助：

```bash
date --help    # 简短帮助信息
date -h        # 同上
```

---

## cd —— 切换目录

### 路径基础

| 符号 | 含义 |
|------|------|
| `/` | 根目录 |
| `~` | 家目录（`/home/用户名`） |
| `.` | 当前目录 |
| `..` | 上级目录（父目录） |

### 绝对路径 vs 相对路径

- **绝对路径**：以 `/` 开头，从根目录开始解析
- **相对路径**：不以 `/` 开头，从当前目录开始解析

```bash
cd /bin              # 绝对路径：进入根目录的 bin
cd bin               # 相对路径：进入当前目录下的 bin
cd ..                # 返回上级目录
cd ../..             # 返回两级
cd ~/project         # 进入家目录下的 project
```

### Tab 自动补全

```bash
cd D<tab><tab>       # 显示所有以 D 开头的目录
cd D<tab>            # 自动补全（如果唯一）
```

---

## PATH —— 命令如何被找到

### 工作原理

当你输入 `date`，Shell 不会魔法般知道程序在哪，而是通过 **`PATH` 环境变量**搜索。

```bash
echo $PATH
# 输出示例：
# /usr/local/bin:/usr/bin:/bin:...
```

PATH 是用冒号 `:` 分隔的目录列表。Shell 按顺序在每个目录里查找同名的可执行文件。

### 查看程序位置

```bash
which date           # 查看 date 程序的具体路径
which echo          # 查看 echo 程序的位置
which -a echo       # -a 显示 PATH 中所有同名程序
```

### 多个同名程序的情况

如果程序出现在多个 PATH 目录中，**先找到的先执行**：

```bash
which -a sh
# 可能输出多个路径，但执行时只用第一个
```

---

## 文件与数据处理命令

### ls —— 列出目录内容

```bash
ls                  # 列出当前目录
ls /bin             # 列出指定目录
ls -l               # 详细信息（权限、大小、日期等）
```

### cat —— 显示文件内容

```bash
cat data.txt        # 将文件内容打印到终端
```

### sort —— 排序打印

```bash
sort data.txt       # 按字典序排序
sort -n data.txt    # -n 按数值排序
```

> **默认是字典序**：`31` 排在 `4` 前面（因为 `"3"` < `"4"`）。

### uniq —— 去重

```bash
uniq data.txt       # 只去除相邻的重复行
sort data.txt | uniq          # 先排序再去重（常见组合）
sort -u data.txt     # 同上
sort data.txt | uniq -c       # -c 统计重复次数
```

### head / tail —— 查看文件头部/尾部

```bash
head data.txt       # 默认显示前 10 行
head -n 5 data.txt  # 显示前 5 行
tail data.txt       # 显示最后 10 行
tail -n 20 data.txt # 显示最后 20 行
```

### grep —— 搜索文件内容

```bash
grep "pattern" file.txt          # 在文件中搜索打印匹配的行（正则匹配）
grep -r "pattern" .              # -r 递归搜索所有子目录
grep -l "pattern" *.md           # -l 只显示文件名
```

grep 使用**正则表达式**作为模式（将在编辑器课程中详细讲解）。

### sed —— 流编辑器（搜索替换）

```bash
# 语法：sed 's/搜索模式/替换内容/g' 文件
sed -i -E 's/Grep/John/g' */*.md   # -i 原地修改，-E 扩展正则
git diff
```

解释：
- `-i`：直接修改文件（不用创建新文件）
- `s/pattern/replacement/g`：`s` = substitute，`g` = global（替换所有匹配，否则只替换每行第一个）

### find —— 查找文件

```bash
# 基本语法：find 路径 [选项]
find . -name "*.md"              # 按名称查找
find . -type f                    # 普通文件
find . -type d                    # 目录
find ~/downloads -mtime +30      # 修改时间 > 30 天
find . -size +100M                # 文件大小 > 100MB
```

#### -exec 执行命令

```bash
# 对每个匹配的文件执行指定命令
find . -size +100M -exec ls -lh {} \;
# -l 为显示更多信息
# -h 为以人类可读格式打印文件大小（不按字节，而是kb、gb等）
# {} 会被替换为匹配文件的路径
# \  表明-exec接收参数的结尾
```

解释：
- `{}` 被替换为找到的路径
- `\;` 标记命令结束（告诉 find 哪些参数是给自己的，哪些是给 `-exec` 执行的）

#### 限制深度

```bash
find . -maxdepth 1 -name "*.md"  # 只搜索当前目录
```

### awk —— 文本解析

awk 将文件按行和空格分割成字段，可以用 `$1`、`$2` 引用各字段：

```bash
# 示例：打印第二列
awk '{print $2}' data.txt

# 打印第二列（逗号分隔的 CSV）
awk -F',' '{print $2}' data.csv
```

> 可以把 awk 理解为一个简陋的 CSV 解析器。

---

## 管道与重定向

### 管道 `|` —— 连接程序

管道将左侧程序的**输出**变为右侧程序的**输入**：

```bash
command1 | command2 | command3
```

### 重定向

| 语法 | 含义 |
|------|------|
| `command > file` | 将输出写入文件（覆盖） |
| `command >> file` | 将输出追加到文件 |
| `command < file` | 从文件读取输入 |

```bash
date > date.txt          # 写入文件
cat data.txt > /dev/null # 丢弃输出
echo "extra" >> date.txt # 追加到文件
sort < data.txt          # 从文件读取输入
```

### `xargs` 标准输入转参数

```bash
echo "a.c b.c c.c" | xargs rm

# 相当于下面命令
rm "a.c b.c c.c"
```

---

## Bash 脚本编程

### if 条件语句

```bash
if grep -q "2026" date.txt; then
    echo "It's 2026"
fi
```

> 缩进风格：`if ... then ... fi`（end if 倒写）

退出状态：命令返回 `0` = 成功，非零 = 失败。grep 找到匹配返回 0，找不到返回 1。

### while 循环

```bash
while grep -q "2026" date.txt; do
    echo "Still 2026"
    sleep 10
    date >> date.txt
done
```

### for 循环

```bash
for var in a b c d; do
    echo $var
done
```

#### 遍历数字序列

```bash
for var in $(seq 1 10); do
    echo $var
done
```

`$(...)` 是**命令替换**：执行括号内的命令，用输出替换整个表达式。
还可以控制seq步长如`seq 1 2 10`

### test / `[ ]` —— 条件测试

```bash
# 字符串比较
[ "hello" = "world" ] && echo "equal" || echo "not equal"
# 更标准的写法
if [ "hello" = "world" ]; then echo "equal"; else echo "not equal"

# 文件测试
[ -f date.txt ] && echo "date.txt exists"
```

> `[ ]` 和 `test` 是同一个程序，`[[ ]]` 是 Bash 内置版本，更安全。

---

## 编写脚本文件

### 创建脚本

```bash
#!/bin/bash
# 这是 Shebang 行，指定用哪个解释器执行这个脚本

date >> log.txt
echo "Done"
```

### Shebang（脚本声明）

```bash
#!/bin/bash        # 用 Bash 执行
#!/usr/bin/python # 用 Python 执行
```

### 赋予执行权限

```bash
chmod +x script.sh   # 添加执行权限
```

### 运行脚本

```bash
./script.sh   # 必须用 ./ 指定当前目录
```

> 如果直接 `script.sh`，Shell 会搜索 PATH 找程序，而不是当前目录。这是**安全设计**，防止恶意文件覆盖系统命令。

---

## 命令组合示例

将 SSH 日志中的用户名提取并统计出现次数最多的前 10 个：

```bash
ssh tsp \
  'journalctl -u sshd -b-1 | grep "Disconnected from"' | \
   sed -E 's/.*Disconnected from .* user (.*) [^ ]+ port.*/\1/' | \
   sort | uniq -c | sort -nk1,1 | tail -n10 | awk '{print $2}' | \
   paste -sd,
```

分解：
1. SSH 连接到远程服务器
2. 获取最近一次启动的日志
3. 筛选断开连接记录
4. 用正则表达式提取用户名
5. 排序 → 去重并统计 → 按数字排序 → 取最后 10 个 → 只打印用户名 → 用逗号连接成一行

---

## 常用辅助工具（参考 lecture notes）

| 工具 | 用途 |
|------|------|
| **Zoxide** | 记住你曾经 cd 过的所有路径，快速跳转 |
| **fd** | find 的现代化替代，更易用 |
| **fzf** | 模糊搜索文件和命令历史 |

---

## 练习建议

1. **理解 PATH**：手动修改 PATH，测试程序查找顺序
2. **写脚本**：实现一个自动化任务（如定时备份文件）
3. **组合命令**：用管道解决实际问题（如统计日志中的错误类型）
4. **权限实验**：`chmod` 的 rwx 模式（Owner/Group/Others）

---

## 观众补充（来自弹幕和评论）

- Windows 上现在 IDE 可以直接帮你编译调试 Java，但理解 Shell 和命令行能让你**更深入地掌控工具**
- 老师使用的是 **NixOS**（一种基于 Nix 包管理器的 Linux 发行版）
- Fish Shell 在某些场景下体验更友好，但不完全兼容 Bash 脚本