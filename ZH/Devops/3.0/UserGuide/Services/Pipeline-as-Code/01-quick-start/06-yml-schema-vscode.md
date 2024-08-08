# 语法检测/补全工具 - vscode

打开 VS Code 配置文件（setting.json）进行配置：

```json
"yaml.schemas": {
        // 编写ci文件的语法检查
       "http://<替换为你的域名>/bkdevops/ci-yaml-schema/latest/ci-v3.json": ".ci/*.yml"
}

```