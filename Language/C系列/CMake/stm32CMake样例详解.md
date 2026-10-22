
用标准库开发 STM32CubeMX 插件生成的空白工程，重要的一步就是修改并配置 CMakeLists 文件

## 主要使用函数

```cmake
set()
file()
link_directories()
add_executable()
list()
target_sources()
target_include_directories()
```

## 主代码

```cmake
cmake_minimum_required(VERSION 3.20)

# Core project settings
project("SPLdemo")
enable_language(C CXX ASM)
message("Build type: " ${CMAKE_BUILD_TYPE})

# Setup compiler settings
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# Core MCU flags, CPU type, instruction set and FPU setup
set(cpu_PARAMS
    # Other parameters
    # -mthumb
    # -mcpu, -mfloat, -mfloat-abi, ...
)

# Sources
set(sources_SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/main.c
)

# Include directories for all compilers
set(include_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/Inc
)

# Include directories for each compiler
set(include_c_DIRS)
set(include_cxx_DIRS)
set(include_asm_DIRS)

# Symbols definition for all compilers
set(symbols_SYMB)

# Symbols definition for each compiler
set(symbols_c_SYMB)
set(symbols_cxx_SYMB)
set(symbols_asm_SYMB)

# Link directories and names of libraries
set(link_DIRS)
set(link_LIBS)

# Linker script
set(linker_script_SRC)

# Compiler options
set(compiler_OPTS)

# Linker options
set(linker_OPTS)

# Now call generated cmake
# This will add script generated
# information to the project
include("cmake/vscode_generated.cmake")

# Link directories setup
# Must be before executable is added
link_directories(${CMAKE_PROJECT_NAME} ${link_DIRS})

# Create an executable object type
add_executable(${CMAKE_PROJECT_NAME})

# Add sources to executable
file(GLOB_RECURSE SPL_SOURCE
    Library/*.c
    Hardware/*.c
    System/*.c
)

# Add to project build list
list(APPEND SOURCES ${SPL_SOURCE})
target_sources(${CMAKE_PROJECT_NAME} PUBLIC ${sources_SRCS} ${SPL_SOURCE})

# Add include paths
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
    ${include_DIRS}
    $<$<COMPILE_LANGUAGE:C>: ${include_c_DIRS}>
    $<$<COMPILE_LANGUAGE:CXX>: ${include_cxx_DIRS}>
    $<$<COMPILE_LANGUAGE:ASM>: ${include_asm_DIRS}>
    Library
    Start
    Hardware
    System
)

# Add project symbols (macros)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
    ${symbols_SYMB}
    $<$<COMPILE_LANGUAGE:C>: ${symbols_c_SYMB}>
    $<$<COMPILE_LANGUAGE:CXX>: ${symbols_cxx_SYMB}>
    $<$<COMPILE_LANGUAGE:ASM>: ${symbols_asm_SYMB}>
    
    # Configuration specific
    $<$<CONFIG:Debug>:DEBUG>
    $<$<CONFIG:Release>: >

    STM32F10X_MD
    USE_STDPERIPH_DRIVER
)

# Add linked libraries
target_link_libraries(${CMAKE_PROJECT_NAME} ${link_LIBS})

# Compiler options
target_compile_options(${CMAKE_PROJECT_NAME} PRIVATE
    ${cpu_PARAMS}
    ${compiler_OPTS}
    -fstack-usage

    # -fcyclomatic-complexity
    -Wall
    -Wextra
    -Wpedantic
    -Wno-unused-parameter
    $<$<COMPILE_LANGUAGE:C>: >
    $<$<COMPILE_LANGUAGE:CXX>:

    # -Wno-volatile
    # -Wold-style-cast
    # -Wuseless-cast
    # -Wsuggest-override
    >
    $<$<COMPILE_LANGUAGE:ASM>:-x assembler-with-cpp -MMD -MP>
    $<$<CONFIG:Debug>:-O0 -g3 -ggdb>
    $<$<CONFIG:Release>:-Os>
)

# Linker options
target_link_options(${CMAKE_PROJECT_NAME} PRIVATE
    -T${linker_script_SRC}
    ${cpu_PARAMS}
    ${linker_OPTS}
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    -u _printf_float # STDIO float formatting support (remove if not used)
    --specs=nosys.specs
    -Wl,--start-group
    -lc
    -lm
    -lstdc++
    -lsupc++
    -Wl,--end-group
    -Wl,-z,max-page-size=8 # Allow good software remapping across address space (with proper GCC section making)
    -Wl,--print-memory-usage
)

# Conditionally add CMSE linker options
if(CMSIS_Dsecure STREQUAL "Secure")
    target_link_options(${CMAKE_PROJECT_NAME} PRIVATE
        -Wl,--cmse-implib
        -Wl,--out-implib=secure_nsclib.o
    )
endif()

# Set linker script as a dependency to force re-link if it changes
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES LINK_DEPENDS ${linker_script_SRC})

# Execute post-build to print size, generate hex and bin
add_custom_command(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${CMAKE_PROJECT_NAME}> ${CMAKE_PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${CMAKE_PROJECT_NAME}> ${CMAKE_PROJECT_NAME}.bin
)
```


---

### 项目声明与语言支持

```cmake
project("SPLdemo")
enable_language(C CXX ASM)
message("Build type: " ${CMAKE_BUILD_TYPE})
```

> `enable_language()` 中启用了 C、C++、汇编支持，STM32 启动文件和部分库需要汇编
> `message()` 在配置阶段打印构建类型：Debug/Release

### 编译器标准设置

```cmake
set(CMAKE_C_STANDARD 11)            # C11 标准
set(CMAKE_C_STANDARD_REQUIRED ON)   # 必须支持 C11，不允许降级
set(CMAKE_C_EXTENSIONS ON)          # 允许 GNU 扩展（如 __attribute__）

set(CMAKE_CXX_STANDARD 20)          # C++20 标准
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)        # CMSIS、SPL库大量使用GNU扩展语法
```

### CPU 参数占位

```cmake
set(cpu_PARAMS 
    # Other parameters
    # -mthumb
    # -mcpu, -mfloat, -mfloat-abi, ...
)
```

> STM32CubeMX 在生成 STM32CubeIDE 项目时通常会在这里填充类似下面的内容：
> - `-mthumb`：Thumb 指令集
> - `-mcpu=cortex-m3`：CPU 核心
> - `-mfloat-abi=soft`：浮点 ABI
> - `-mfloat-abi=hard`：硬浮点 ABI

> [!KEY]
> 对于 ARM GCC 工具链，CPU 和 FPU 参数通常**通过工具链文件传递**，这里留空是因为 VS Code 扩展可能用 `arm-none-eabi-gcc` 默认配置（cortex-m3 + soft-float）

### 源文件、头文件路径与占位变量

```cmake
# Sources
set(sources_SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/main.c
)

# Include directories for all compilers
set(include_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/Inc
)

set(include_c_DIRS)        # 仅 C 编译器使用的头文件路径
set(include_cxx_DIRS)      # 仅 C++ 编译器使用的头文件路径
set(include_asm_DIRS)      # 仅汇编使用的头文件路径

set(symbols_SYMB)          # 全局宏定义
set(symbols_c_SYMB)        # 仅 C 使用的宏
set(symbols_cxx_SYMB)      #仅 C++ 使用的宏
set(symbols_asm_SYMB)      # 仅汇编使用的宏

set(link_DIRS)             # 链接库搜索目录
set(link_LIBS)             # 要链接的库
set(linker_script_SRC)     # 链接脚本（.ld 文件）
set(compiler_OPTS)         # 编译选项
set(linker_OPTS)           # 链接选项

# Now call generated cmake
# This will add script generated
# information to the project
include("cmake/vscode_generated.cmake")
```

> `include()` 把 STM32CubeIDE 工具链配置（编译器路径、CPU 参数、链接脚本等）加载进来。这里所有 `set()` 占位变量会被实际值填充

> [!NOTE]
> `set()` 用于定义 CMake 变量，如果有多个值会形成列表

### 链接目录与可执行文件

```cmake
# Link directories setup
# Must be before executable is added
link_directories(${CMAKE_PROJECT_NAME} ${link_DIRS})

# Create an executable object type
add_executable(${CMAKE_PROJECT_NAME})
```

> [!INFO]
> 链接库有 `link_directories()` 和 `target_link_libraries` 两种写法，前者作用域为全局，后者作用域为当前 target，*若避免全局污染，只用后者即可*
> ```cmake
> # 指定全局库搜索路径后，匹配方式：libuart.a -> uart
> link_directories(${CMAKE_SOURCE_DIR}/lib)
> target_link_libraries(${PROJECT_NAME} PRIVATE
> 	uart
> 	m
> )
> 
> # 避免污染用后者写全路径
> target_link_libraries(${PROJECT_NAME} PRIVATE
> 	${CMAKE_SOURCE_DIR}/lib/libuart.a
> 	m
> )
> ```

有关链接库可见[构建库](构建库.md)
### 源文件收集（用户修改）

```cmake
# Add sources to executable 
file(GLOB_RECURSE SPL_SOURCE
    Library/*.c
    Hardware/*.c
    System/*.c 
) 
# Add to project build list 
list(APPEND SOURCES ${SPL_SOURCE}) 

target_sources(${CMAKE_PROJECT_NAME} PUBLIC ${sources_SRCS} ${SPL_SOURCE})
```

> `file()` 递归搜索自定义目录下的所有 .c 文件存储路径到 SPL_SOURCE 变量
> `list()` 将收集到的源文件追加到 SOURCES 变量
> `target_sources()` 将源文件添加到可执行目标

> [!ATTENTION]
> *GLOB 只当前目录搜索，GLOB_RECURSE 递归搜索*，其结果会在第一次运行 CMake 时缓存下来，之后新增文件可能不会重新扫描导致新文件不参与编译需要手动删除 Build 文件夹重新运行 CMake
> CMake 3.20+支持 **CONFIGURE_DEPENDS** 参数使得 CMake 构建时自动检查文件变化触发重配置，如：
> ```cmake
> file(GLOB_RECURSE SPL_SOURCE
> CONFIGURE_DEPENDS
> 	Library/*.c
> 	Hardware/*.c
> 	System/*.c
> )
> ```

### 头文件搜索路径（用户修改）

```cmake
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
    ${include_DIRS}
    $<$<COMPILE_LANGUAGE:C>: ${include_c_DIRS}>
    $<$<COMPILE_LANGUAGE:CXX>: ${include_cxx_DIRS}>
    $<$<COMPILE_LANGUAGE:ASM>: ${include_asm_DIRS}>
    Library
    Start
    Hardware
    System
)
```

> - `PRIVATE` ：这些头文件路径只对当前 target 生效，不传递给依赖者。
> - Generator Expressions：
    - `$<$<COMPILE_LANGUAGE:C>: ...>`：当编译语言为 C 时才生效
    - `$<$<COMPILE_LANGUAGE:CXX>: ...>`：当编译语言为 C++ 时才生效
    - `$<$<COMPILE_LANGUAGE:ASM>: ...>`：当编译语言为汇编时生效
> - 直接列出目录：`Library`、`Start`、`Hardware`、`System` 都是相对路径，自动扩展为 `${CMAKE_CURRENT_SOURCE_DIR}/Library` 等

### 宏定义（用户修改）

```cmake
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
    ${symbols_SYMB}
    $<$<COMPILE_LANGUAGE:C>: ${symbols_c_SYMB}>
    $<$<COMPILE_LANGUAGE:CXX>: ${symbols_cxx_SYMB}>
    $<$<COMPILE_LANGUAGE:ASM>: ${symbols_asm_SYMB}>

    # Configuration specific
    $<$<CONFIG:Debug>:DEBUG>
    $<$<CONFIG:Release>: >

    STM32F10X_MD
    USE_STDPERIPH_DRIVER
)
```

|宏|作用|
|---|---|
|`DEBUG`|在 Debug 构建时定义，可用于 `#ifdef DEBUG` 启用调试代码|
|`STM32F10X_MD`|告诉标准库这是 **STM32F1 中容量（Medium Density）** 芯片。可选值：`LD`/`MD`/`HD`/`XL`/`CL`|
|`USE_STDPERIPH_DRIVER`|启用 STM32 标准外设库（不使用 HAL/LL）|

### 编译后处理

```cmake
# Execute post-build to print size, generate hex and bin
add_custom_command(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${CMAKE_PROJECT_NAME}> ${CMAKE_PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${CMAKE_PROJECT_NAME}> ${CMAKE_PROJECT_NAME}.bin
)
```

> 在 ELF 文件生成后执行 3 个命令：
> 
>1.  `${CMAKE_SIZE}` ：打印内存占用（`.text` / `.data` / `.bss`）
>2. `objcopy -O ihex` ：生成 Intel HEX 格式（用于大多数下载器）
> 	- 输出：`SPLdemo.hex`
>3.  `objcopy -O binary` ：生成原始二进制（用于 OTA、bootloader）
> 	- 输出：`SPLdemo.bin`

> [!NOTE]
> `$<TARGET_FILE:...>` 是 generator expression，会在生成阶段解析为目标文件的完整路径