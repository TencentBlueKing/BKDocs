# NodeJS 插件执行环境

研发商店支持开发 NodeJS 插件，如果想在你的构建机上能正常运行 NodeJS 插件，需要进行如下设置：

- 安装 NodeJS
  > 建议安装[node LTS 版本](https://nodejs.org/en/download/)，支持更多 es 特性
- 若企业内部有专用的npm源，配置 npm 仓库为内网版本

  ```bash
    npm config set registry <内网npm仓库地址>
  ```
