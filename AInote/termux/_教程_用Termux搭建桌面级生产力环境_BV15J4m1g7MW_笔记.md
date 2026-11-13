 # 用Termux搭建桌面级生产力环境

## 前言

本教程讲解如何在Android设备上通过Termux模拟Linux环境，搭配Mobox，最终实现在手机上运行桌面级生产力软件（如VS Code、Blender、Photoshop、LibreOffice、QQ等）。

### 基础要求

- Android手机或平板一部
- 具备Linux基础知识更佳（没有也没关系，教程会尽量讲细致）
- 一套键鼠（方便操作）
- 足够的耐心
- **不推荐使用ZeroTermux等魔改版Termux**，可能出现不可预测的问题

---

## 一、Termux安装

### 1.1 下载方式

- **官方下载**：在F-Droid搜索Termux，官网为 `f-droid.org`
- 进入下载页后点击下面的 `Download PKG` 获取安装包
- 如果F-Droid网页打不开，也可通过其他途径获取安装包

### 1.2 Termux是什么

Termux是一个**终端模拟器**，提供了一个开箱即用的模拟Linux环境。特点：

- 可以像使用Linux一样使用它
- 支持安装大量第三方包
- **不是虚拟机**，而是直接调用Android底层系统接口

> ⚠️ **警告**：如果在里面执行清理垃圾文件等命令，可能导致手机文件丢失。

---

## 二、基础配置：换源

由于国内网络难以连接Termux官方软件仓库，需要更换下载源。

### 2.1 手动换源

```bash
termux-change-repo
```

操作流程：

1. 默认情况下只有一个Termux官方软件包仓库，直接回车继续
2. 使用上下方向键选择**清华源**
3. 回车继续

### 2.2 其他方案

- 使用VPN连接
- 使用镜像源（如科大源，有用户反馈比清华源更快）

> 💡 弹幕提示：换源时回车前都要按一下空格键。

---

## 三、APT包管理基础

### 3.1 APT简介

APT（全称Advanced Packaging Tool）是Debian系Linux发行版的软件包管理工具，也是Termux使用的包管理工具，本教程中会多次使用。

### 3.2 常用命令

| 命令 | 说明 |
|------|------|
| `apt update` | 更新软件包信息 |
| `apt search <关键词>` | 搜索软件包 |
| `apt install <包名>` | 安装软件包 |
| `apt install -y <包名>` | 自动输入Y继续（无需手动确认） |
| `apt remove <包名>` | 删除软件包 |

> 💡 如果记不住命令，也可以使用新立得（Synaptic）等图形化软件包管理器作为前端。但大多数时候还是推荐使用命令操作。

---

## 四、安装桌面环境（XFCE4）

### 4.1 安装X11软件仓库

XFCE4桌面环境需要从X11软件仓库下载，所以必须先安装它：

```bash
apt update
apt install x11-repo
```

> 同样可以对X11仓库执行换源操作，方法同上。

### 4.2 安装XFCE4桌面

```bash
apt search xfce4
# 搜索结果中以绿色字体显示的就是我们要找的包
apt install xfce4
# 询问是否继续时输入Y回车
```

> ⏳ 等待过程比较久，耐心等待即可。

### 4.3 安装X11客户端

Termux的X11客户端是图形界面程序与用户交互的媒介。

1. 访问Termux X11的官方GitHub项目页面
2. 进入Releases页面（不是Actions），找到Latest下面的文件
3. 下载最新的arm构建版本（Universal通用版包含v8a和v7a，无架构限制）
4. 下载的是压缩包，解压后安装里面的APK文件

> 💡 弹幕提示：进Releases页面需要在页面最下面往上看，找到标签是Releases的部分，下面一段末尾有绿字Latest，点进去就到文件下载界面了。

### 4.4 安装X11服务器并启动

回到Termux，安装X11服务端：

```bash
apt install termux-x11
```

### 4.5 启动X11服务器

```bash
termux-x11 :0 &>/dev/null &
 ```

命令解析：

- `termux-x11` — 启动X11服务端
- `:0` — 显示编号
- `&>/dev/null` — 不显示输出信息
- `&` — 后台运行，将输出重定向到/dev/null，避免阻塞终端

### 4.6 设置DISPLAY环境变量

```bash
export DISPLAY=:0
startxfce4
```

> ⚠️ 如果出现错误，可能是手机缺少某些库文件，可以尝试安装：
> ```bash
> apt install libexpat
> ```
> 不报错就不用管。

### 4.7 成功启动桌面

切换到Termux X11应用即可看到桌面环境。

#### 桌面设置

桌面长按图标可设置首选项：
- 屏幕分辨率切换
- 横竖屏切换
- 显示功能键盘
- 隐藏屏幕刘海等

都是简单的英文，不懂的单词查一下就懂。

---

## 五、VNC连接方式（可选）

如果需要在其他设备上远程连接，可以安装VNC。

### 5.1 安装VNC服务器

```bash
apt install tigervnc
```

### 5.2 启动VNC服务器

```bash
vncserver :1 -localhost no 
```
不行换编号，如0、2

- `:1` — 显示编号
- 执行后会要求输入VNC连接密码
- 再设置一个仅观看密码（可选）

> ⚠️ 弹幕提醒：冒号前面有空格，折腾了不少人。

### 5.3 设置环境变量

```bash
export DISPLAY=:1
```
要与上面vnc编号相同

### 5.4 连接方式

- **手机本地**：打开VNC Viewer，地址填 `127.0.0.1`，端口填 `5900` + 显示编号（如590X，X表示填的编号），即`127.0.0.1:5901`
- **其他设备**：输入手机的IP地址进行连接

连接后如果颜色深度有问题，将画面质量改为高。

> 💡 在其他设备上用VNC客户端输入手机IP也能连接，适合手机屏幕太小的情况。

退出termux前，先正常关闭vnc：`vncserver -kill :1`

---

## 六、解决Signal 9问题

在使用过程中可能出现画面突然断开连接，返回Termux出现Signal 9错误。这是**Android 12以上引入的stop copying子进程的机制**导致的。

### 6.1 验证问题原因

`apt install xfce4-taskmanager`
安装KDE Task Manager（任务管理器）查看当前进程数。每个XFCE进程都是Termux的子进程，如果多开程序超过32个进程，Termux后台就会被杀掉。

### 6.2 关闭机制的方法

**方法一（推荐）**：

1. 打开手机设置 → 设备信息
2. 在全部参数里连续点击系统版本5次，打开开发者选项
3. 在开发者选项中找到「停止强制子进程」并打开

> 实测这样就不会杀进程了。

**方法二**：使用ANR（Application Not Responding）来关闭这个机制（up主在视频中未详细演示）。

### 6.3 其他优化

- 关闭省电优化：长按Termux图标 → 应用信息 → 省电策略 → 选择「无限制」
- up主之前一直连不上VS Code就是这么解决的

---

## 七、创建启动脚本

每次启动桌面都要重复之前的命令，比较麻烦。可以写一个启动脚本来简化步骤。

### 7.1 安装文本编辑器

```bash
apt install mousepad -y
```

### 7.2 创建脚本文件

打开文件管理器，在导航栏输入 `$PATH` 导航到home目录。

空白处右键 → 创建新文件 → 命名为 `startx11`（之后都用这个名字作为命令启动桌面）。

### 7.3 编写脚本内容

```bash
#!/bin/bash

export DISPLAY=:0
termux-x11 :0 &>/dev/null &
sleep 3
startxfce4  &>/dev/null &
am start --user 0 -n com.termux.x11/.MainActivity &>/dev/null
```

> 说明：
> - `#!/data/data/com.termux/files/usr/bin/sh` — 指定Shell解释器
> - `termux-x11 :1 > /dev/null 2>&1 &` — 启动X11，后台运行
> - `sleep 3` — 延迟确保X服务器启动
> - `startxfce4 > /dev/null 2>&1 &` — 启动桌面
> - `am start -n com.termux.x11/.HomeActivity` — 跳转到Termux X11主界面

### 7.4 添加执行权限

```bash
chmod +x startx11
```

### 7.5 使用启动脚本

1. 将Termux X11后台划掉，重新打开Termux
2. 输入 `startx11` 即可一键启动

> 💡 VNC启动脚本写法类似，可以自己尝试。

> 💡 命令不多，别老想着复制粘贴，自己写一遍，加深理解。

---

## 八、安装Mobox

Mobox用于运行Windows程序（如游戏、生产力软件等），其前身是Termux-Box，作者后来改用Box64/Box86替代Proot，因此创建了新项目Mobox。

### 8.1 安装Mobox

1. 进入Mobox官方GitHub项目仓库
2. 复制安装命令
3. 回到Termux粘贴执行

```bash
# 复制安装命令并执行
# 如果执行命令没反应，可能是网络原因
# GitHub在国内通常难以访问，可能需要加速
```

> ⏳ 安装过程比较久，跳过。

### 8.2 选择Box类型

中途会出现选择，输入 `2` 选择 **box64**，继续。

### 8.3 启动Mobox

```bash
mobox
```

选择 Start Wine 进入Mobox，第一次可能比较久。

### 8.4 解决Mobox覆盖XFCE的问题

启动Mobox后，它会将XFCE桌面覆盖。解决方法：

1. 找到 `start.sh` 文件 `/data/data/com.termux/files/usr/glibc/opt/scripts/start-tfm   `
2. 先**备份**一份原文件，方便恢复：
3. 修改文件内容：
   - 在开头找到 `stop all`，在前面加 `#` 注释掉
   - 在尾部也找到 `stop all，同样加 `#` 注释掉
1. 打开搜索，搜索 `explorer /desktop=shell,$RESOLUTION `，能搜索到四个匹配的地方
2. 把后面三处匹配的 `metacity-theme` 部分删掉
3. 保存并退出

### 8.5 验证效果

再次启动Mobox，可以看到Mobox已经与XFCE4完美融合了。

> 💡 如果不需要XFCE（即只是玩游戏），可以把备份的原文件换回去，那么在Termux X11内启动Mobox就是最纯粹的Mobox。

---

## 九、常规应用安装

### 9.1 Termux可直接安装的应用

使用 `apt search` 搜索，常用的如VS Code、火狐等：

```bash
apt search python
apt search firefox
apt install <包名>
```

### 9.2 Mobox内安装Windows程序

像Photoshop等软件可以用Mobox安装：

1. 在Mobox内下载EXE安装包
2. 安装时留意安装路径
3. 安装完成后找到EXE文件启动
4. 默认Mobox的D盘就是手机的 `Download` 目录，很多软件默认下载路径也是这个

> ⚠️ 能安装的软件还是太少，例如Office就装不上。这时候就需要Proot-distro。

---

## 十、Proot-distro：更完整的Linux环境

### 10.1 为什么需要Proot-distro

Termux模拟的Linux环境与真实的Linux环境有很多差别。之前用apt直接安装的软件其实都是为Termux专门适配的版本。

Proot-distro能进一步模拟一个更完善的Linux环境，从而兼容更多的软件运行（如Office、QQ等）。

### 10.2 安装Proot-distro

```bash
apt install proot proot-distro
```

### 10.3 可用的发行版

```bash
proot-distro list
# 可以看到有很多可用的发行版
# 安装时需要使用它们的alias
```

### 10.4 安装Debian

```bash
proot-distro install debian
```

> ⏳ 安装过程比较久。

### 10.5 登录Debian

```bash
proot-distro login debian
```

> 💡 新版Proot-distro可以简写为 `pd`：
> - `pd install debian`
> - `pd login debian`

登录后默认是**root用户**（即使手机没有root），这点与外面的Termux单用户环境不同。

### 10.6 验证登录效果

```bash
neofetch
#
whoami
# 可以看到当前是root用户
```

对比内外信息：
- 外面能正常识别桌面和分辨率
- Proot-distro内**不能**正常获取分辨率和桌面

### 10.7 解决Proot内图形显示问题

1. **注销Debian**：
   ```bash
   exit
   ```

2. **重新登录并共享临时目录**：
   ```bash
   proot-distro login debian --shared-tmp
   ```

3. **设置DISPLAY环境变量**（与之前保持一致）：
   ```bash
   export DISPLAY=:1
   ```
   如果像上面vnc脚本启动是1，原脚本是0

4. **再次验证**：
   ```bash
   neofetch
   # 可以看到已经能正常获取分辨率和桌面环境了
   ```

> 💡 弹幕提示：这里的DISPLAY编号如果是 `:0`，需要改成 `:1`（与之前启动脚本中的编号保持一致）。

---

## 十一、在Proot内安装LibreOffice

### 11.1 安装

```bash
apt update
apt search libreoffice
apt install libreoffice
```

> ⏳ 安装过程比较久，跳过。

### 11.2 启动

```bash
libreoffice
```

---

## 十二、解决中文字体问题

### 12.1 安装中文语言包

```bash
apt install libreoffice-l10n-zh-cn
```

在选项页面选择需要的语言并设置为默认。(user interface)

### 12.2 安装中文字体

1. 重启LibreOffice后，工具栏左上角菜单 → 选项 → 语言设置
2. 界面语言改为中文
3. 从网上下载字体文件或从Windows系统目录（C:\Windows\Fonts）复制字体文件
4. 导航到Proot-distro安装的发行版的根目录：`/data/data/com.termux/files/usr/var/lib/proot-distro/debian/root`
5. 开启显示隐藏文件，进入 `.fonts` 目录（如果没有就创建一个）
6. 将字体文件放入此目录
7. 重启LibreOffice即可看到中文字体正常显示

> 💡 可以将目录添加到书签方便访问。

---

## 十三、创建LibreOffice启动器

每次使用都要登录到Debian再手动输入命令很麻烦，可以创建启动器：

1. 在桌面右键 → 创建启动器
2. 名字输入 `LibreOffice`
3. 命令栏输入：
```bash
proot-distro login debian --shared-tmp --sh -c 'export DISPLAY=:1 && libreoffice'
```

> 💡 如果DISPLAY编号为0，记得改成1。

启动器创建完成后双击即可快速启动LibreOffice。

---

## 十四、在Proot内安装其他应用（以QQ为例）

### 14.1 下载安装包

1. 打开QQ下载页
2. 下载ARM架构的deb包

### 14.2 安装

```bash
浏览器下载qq linux arm deb包
# 登录后
dpkg -i <deb包路径>
```

### 14.3 修复依赖

如果安装时提示缺少依赖：

```bash
apt install -f
# 修复完依赖后重新安装
dpkg -i <deb包路径>
```

### 14.4 启动

由于Electron程序不让root用户运行，需要加 `--no-sandbox` 参数：

```bash
export DISPLAY=:1
# 启动命令加启动参数
qq --no-sandbox
# 或其他应用
```

### 14.5 创建启动器

按照之前LibreOffice启动器的方法创建即可。

---

## 十五、常见问题

### Q1：为什么不在Proot内安装XFCE？

其实把XFCE装在Proot里确实更好的选择（包括用Termux-all-in-one安装桌面环境的话，它也会帮你把XFCE装在Proot里）。up主主要是为了Mobox考虑。Mobox前身是Termux-Box，作者选择新开仓库改名为Mobox换成box64/box86是有原因的。如果再把Mobox装回Proot中，有点本末倒置的感觉。

当然理论上也是可以把Mobox装在Proot外面共用同一个X11的，这里就不多说了。

### Q2：鸿蒙系统无法启动怎么办？

鸿蒙系统直接输入 `./startx11` 可能无法启动。需要：

1. 在系统设置 → 应用和服务 → 应用启动管理里把所有应用都改成**手动管理**，并**全部打开**
2. 或者尝试输入 `./startx11` 时念"云梯云梯吽！急急如律令！"（弹幕玩笑）

### Q3：Termux无法访问手机用户目录？

鸿蒙4.2的Termux可能根本无法访问手机用户目录，这是系统限制。

### Q4：如何换其他桌面环境？

可以换其他桌面如MATE等，不一定非要XFCE4：

```bash
apt search mate
apt install <包名>
```

### Q5：启动后黑屏怎么办？

先安装测试：

```bash
apt install libwayland-egl1
```

### Q6：VNC连接不上？

确保启动VNC时加了 `:1` 显示编号，并在VNC客户端地址中填 `127.0.0.1:5901`（端口号 = 5900 + 显示编号）。

### Q7：如何删除软件？

```bash
# 退出proot-distro
exit
# 删除软件
apt remove <包名>
```

> 💡 弹幕提示：删库跑路常用命令，大家做好笔记。

---

## 十六、总结

通过本教程，你学会了：

1. **安装Termux**并配置换源
2. **安装XFCE4桌面环境**和Termux X11
3. **配置VNC远程连接**
4. **解决Signal 9进程被杀问题**
5. **编写启动脚本**简化操作
6. **安装Mobox**运行Windows程序
7. **安装Proot-distro**获得更完整的Linux环境
8. **在Proot内安装LibreOffice、QQ等应用**
9. **配置中文字体和中文语言**
10. **创建桌面启动器快速启动应用**

整个环境搭建完成后，你可以在Android设备上本地运行VS Code、Blender、Photoshop、LibreOffice、QQ等生产力软件。