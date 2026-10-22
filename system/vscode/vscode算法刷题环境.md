
因为是各个独立的源文件，不需要 CMake 等构建工具，可以只通过 tasks.json、launch.json 进行运行或调试

tasks.json 可以直接自己创建，使用用户 tasks：

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "type": "shell",
            "label": "Clang 编译活动文件",
            "command": "clang++.exe",
            "args": [
                "-g",
                "-O0", // 不调试改成"-O2"，删去"-g"
                "-std=c++17",
                "-fdiagnostics-color",
                "${file}",
                "-o",
                "${fileDirname}\\${fileBasenameNoExtension}.exe"
            ],
            "options": {
                "cwd": "${fileDirname}"
            },
            "problemMatcher": "$clang",
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "detail": "LLVM Clang 编译任务，clangd配套使用"
        }
    ]
}
```

> Ctrl+Shift+B 进行 tasks 构建，
> F5 运行或调试

最基础能用的 launch.json

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "lldb",
            "request": "launch",
            "program": "${workspaceRoot}/${fileBasenameNoExtension}",
            "args": [],
            "cwd": "${workspaceRoot}"
        }
    ]
}
```