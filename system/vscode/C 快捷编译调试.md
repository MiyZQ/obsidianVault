
主要是利用 VSCode 中的 Tasks，使用时通过 **Ctrl+Shift+B** 来运行 Tasks 文件，通常用于小型的单文件测试

在当前 Profile 中配置 tasks.json 文件：
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build one active file",
            "type": "shell",
            "command": "g++",
            "args": [
                "-g",
                "${file}", 
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}"
            ],
            "group": {
                "kind": "build",
                "isDefault": false
            },
            "problemMatcher": ["$gcc"]
        }
    ]
}
```