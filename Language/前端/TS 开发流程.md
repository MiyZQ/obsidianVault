
工作环境安装 TS 编译器：
```bash
npm install -D typescript
tsc -v
```

项目初始化会生成 package.json 文件
```bash
npm init -y
```
> type 改为 module，main 改为 dist/index.js，并加入新键值对："types": "dist/index.d.ts"

生成默认配置文件来定义编译选项和包含的文件
```bash
npx tsc --init
```

编译并用 Node.js 运行
```bash
tsc
node dist/index.js
```
> 在浏览器上运行，html 的 script 标签要加入 type="module"

调试则要配置 launch.json 文件，选择 Node.js 环境，建议的 launch.json
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}/dist/main.js", // 指向编译后的 JS 文件
      "preLaunchTask": "tsc: build - tsconfig.json", // 调试前自动执行编译
      "outFiles": [
        "${workspaceFolder}/dist/**/*.js" // 告诉调试器去哪里找编译后的 JS 文件
      ],
      "skipFiles": ["<node_internals>/**"]
    }
  ]
}
```

