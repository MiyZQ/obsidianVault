
一般分为三类：python 解释器运行，交互式运行，IDE 运行

### python 解释器运行

以 Ubuntu 为例，用 mkdir 新建工作目录后，新建 .py 文件
```bash
touch demo.py
```
即可写代码

运行该代码时，需要用 cd 定位到工作目录，输入命令
```bash
python3 demo.py
```
即运行（预先指定 python 解释器环境变量）

### 交互式运行

运行
```bash
python3
```

进入 python 交互式终端，每次键入 python 代码并回车就会执行这个命令，==全程在内存中运行，代码不会保存，适合轻量使用==

> [!NOTE]
> 退出 python 交互式终端输入 exit()或用热键 Ctrl+D
