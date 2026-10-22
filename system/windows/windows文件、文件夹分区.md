
## 文件类型
#### 配置与数据
- .ini 老式配置文件
- .json / .xml / xyaml 现代常用配置
- .cfg / .conf 通用配置
#### 资源
- .exe
- .res / .rc 编译前资源脚本
- .dll 
#### 本地化/语言
- .lng 
- .mo / .po
- .mui
#### 字体、图片、音效
- .ttf / .otf 字体
- .png / .jpg / .bmp / .gif
- .wav / .mp3 / .ogg 音效、背景音乐
#### 数据库、缓存
- .db / .sqlite 本地数据库
- .dat 通用数据文件
- .log 日志
#### 插件
- .dll
- .pak / .bundle / .plugin
- .ucas / .assets
#### 运行时依赖
- .exe.config .NET程序带
- .jar Java软件带
- .pyc / .pyd Python打包带
#### 系统/驱动
- .sys 内核级驱动
- .drv 老式驱动
- .ocx ActiveX控件（老软件、网页插件）
#### 安装、卸载
- .inf 安装信息
#### 加密、版权
- .lic / .cert 许可证、证书
- .pub / .key 密钥
#### 脚本
- .lua
- .py / .js / .vbs
- .bat / .cmd 批处理


---

## 文件夹常见布局
#### bin
即binary，放exe、dll等，运行的核心
#### asset
即资源，放图片、图标、UI、音效、字体、模型、配置等，只存数据，不跑代码
#### data
放存档、数据库、地图包、配置、缓存，与asset相比偏向运行时数据
#### config / cfg
放配置文件.ini .json .xml .vdf，改画质、键位、路径等
#### plugins / addons / mods
放插件dll、script、模组
#### modules
模块化功能组件，比plugins更底层，自带功能组件
#### extensions
相当于plugins，浏览器、vscode等常用
#### ui
界面资源
#### web / huml / resources
内置网页界面，放html css js等
#### locale / lang / i18n
语言包
#### cache
缓存，删除后软件启动会重建
#### tmp / temp
临时文件
#### logs
日志文件
#### lib
即library，放静态库、链接库，是编译开发用的库文件
#### res / resource
资源文件，等同asset
#### engine
引擎核心，如虚幻、Unity、Source引擎的dll
#### platforms
Qt软件必备，负责在操作系统上显示窗口
#### drivers
驱动、虚拟设备
#### renderer
渲染相关：显卡接口dll、画质模块
#### audio
音效、音频解码库
#### installer
安装卸载脚本组件
#### update / downloads
更新包、下载缓存
#### scripts
放脚本 .lua .py .js .bat