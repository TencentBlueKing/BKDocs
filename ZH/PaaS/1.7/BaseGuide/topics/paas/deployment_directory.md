## 什么情况需要使用构建目录

如果您是把前后端代码都放在一个代码仓库中，目录结构如图所示：

```

├── docs
├── src
│   └── backend
│       └── bin
│           └── post-compile
│           └── pre-compile
│       └── requirements.txt
│   └── fronted
│       └── package.json
└── README.md
```

- `src/backend` 用来存放后端模块(backend)的代码
- `src/frontend` 用来存放前端模块(default)的代码

这时只需要在“创建应用\模块”的时候指定`构建目录`即可，创建完成后也可以在应用如下页面中修改：

- 云原生应用：『模块配置』-『构建配置』
- 普通应用：『模块管理』-『源码仓库管理』

## 设置部署目录

如上面的代码示例中，将前端模块(default)的部署目录设置为`src/frontend`，后端模块(backend)的部署目录设置为`src/backend`。

注意:

- 构建目录不填则默认为根目录
- 构建目录下必须包含所有需要的代码，比如[构建阶段钩子](./build_hooks.md)（pre-compile 和 post-compile）都只能操作构建目录下的文件
