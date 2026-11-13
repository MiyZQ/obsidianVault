
新建一个 EIDE 工程后进入工作区，进入插件界面->OPERATIONS->Setup Utility Tools 下载：
1. CppCheck
2. OpenOCD Programmer
3. GNU Arm Embedded Toolchain(若前面没下载 arm-none-eabi-gcc 编译器)

> 这里下载的 tools 在用户/.eide/tools 文件夹中

> [!NOTE]
> 也可使用外部编译器，在 Armcc v5/v6 toolchain install directory 设置中粘贴编译器路径

在 Projects ->Chip Support Package 选择芯片类型，并为此选择 Select Device

在 Builder Configurations->Builder Options 中可更改构建相关配置

在 Flasher Configurations 中切换 Flasher 为 OpenOCD，子栏中可选择芯片类型和接口类型

> [!Important]
> 1. 如果要导入 HAL 工程，需要选择 Eclipse 方案，选择工程文件夹中的 .cproject 文件，导入后只需设置烧录器即可
> 2. 如果要导入 SPL 工程编译失败，还需要在 C/C++ Attributes 下的 Preprocessor Definitions 添加 STM32F10X_MD