
## 创建 CMakeLists.txt 文件

在项目根目录下创建，包含三行必须代码

```cmake
cmake_minimum_required(VERSION 3.10)

project(Example)

add_executable(Example
	main.cpp
)
```

第一行指定构建项目所需最低 CMake 版本
第二行指定项目名
第三行指定包含构建的源文件

## 复杂项目的 CMakeLists 文件

当工程包含多个源文件、图片资源、第三方库等时，需要为 CMakeLists.txt 文件添加更多信息

```cmake
cmake_minimum_required(VERSION 2.7)

project(Example)

find_package(imgui REQUIRED)
find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)
find_package(glm REQUIRED)

file(GLOB SRC_FILES
	"${PROJECT_SOURCE_DIR}/src/*.h"
	"${PROJECT_SOURCE_DIR}/src/*.cpp"
	"${PROJECT_SOURCE_DIR}/src/*.c"
	"${PROJECT_SOURCE_DIR}/src/*.cc")
	
add_executable(${CMAKE_PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE imgui::imgui)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glfw)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE GLEW::GLEW)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glm)

target_compile_features(${CMAKE_PROJECT_NAME} PRIVATE cxx_std_17)

add_custom_command(
	TARGET ${CMAKE_PROJECT_NAME}
	POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy_directory
		"${PROJECT_SOURCE_DIR}/assets"
		"$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>/assets")
		
add_custom_command(
	TARGET ${CMAKE_PROJECT_NAME}
	POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy_directory
		"${PROJECT_SOURCE_DIR}/shader"
		"$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>/shader")
```


---

### 导入第三方库

```cmake
find_package(imgui REQUIRED)
find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)
find_package(glm REQUIRED)
```

find_package 从计算机中查询已安装的第三方库，库需要支持用 CMake 进行构建
REQUIRED 命令表示库是必须的，如果没有直接报错

### 源文件管理

```cmake
file(GLOB SRC_FILES
	"${PROJECT_SOURCE_DIR}/src/*.h"
	"${PROJECT_SOURCE_DIR}/src/*.cpp"
	"${PROJECT_SOURCE_DIR}/src/*.c"
	"${PROJECT_SOURCE_DIR}/src/*.cc")
```

源文件很多时，定义变量 SRC_FILES 来储存这些源文件路径信息，方便后面的命令调用，如后面的 add_executable 命令

```cmake
add_executable(${CMAKE_PROJECT_NAME} ${SRC_FILES})
```

> [!NOTE]
> `${CMAKE_PROJECT_NAME}` 是一个宏，即为工程文件名

### 链接库

```cmake
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE imgui::imgui)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glfw)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE GLEW::GLEW)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE glm)
```

> [!NOTE]
> 若不执行链接库的命令，则可能遇到经典的符号无法解析的错误

### C++版本控制

```cmake
target_compile_features(${CMAKE_PROJECT_NAME} PRIVATE
cxx_std_17)
```

此命令表示打开 C++17 的支持

### 管理 assets 文件

```cmake
add_custom_command(
	TARGET ${CMAKE_PROJECT_NAME}
	POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy_directory
		"${PROJECT_SOURCE_DIR}/assets"
		"$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>/ass
```

`POST_BUILD` 表示编译之后要执行的操作，后面调用的命令将根目录的 assets 文件夹拷贝到输出路径下

> <项目根目录>/assets    ->    <项目根目录>/build/Debug/assets

## 导入第三方库方法

在项目根目录下放入第三方库文件，或在根目录终端命令下载

手动构建 CMake 库的路径：

```bash
cd glfw
cmake -S . -B build
```

### 自动管理库：Vcpkg

安装 Vcpkg 后，用其安装第三方库 `vcpkg install imgui`，再在 CMake 构建时指定 Vcpkg 工具链即可

```bash
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=
<vcpkg根目录>/scripts/buildsystems/vcpkg.cmake
```

如果使用的是 VS Code 插件，在 .vscode/settings.json 中添加

```json
"cmake.configureSettings": {
	"CMAKE_TOOLCHAIN_FILE":"<...>/scripts/buildsystems/vcpkg.cmake"
}
```