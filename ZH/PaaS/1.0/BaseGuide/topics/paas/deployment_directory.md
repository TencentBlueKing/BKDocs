## 什么情况需要使用部署目录


蓝鲸以 `Procfile` 文件来定义应用进程的文件入口，默认从根目录去读取该文件。


如果您是把前后端代码都放在一个代码仓库中，目录结构如图所示：

```

├── docs
├── src
│   └── backend
│       └── bin
│           └── post-compile
│           └── pre-compile
│       └── Procfile
│       └── requirements.txt
│   └── fronted
│       └── package.json
│       └── Procfile
└── README.md
```

- `src/backend` 用来存放后端模块(backend)的代码
- `src/fronted` 用来存放前端模块(default)的代码

这时只需要在“创建应用\模块”的时候指定“部署目录”即可，创建完成后也可以在 『模块管理』-『源码仓库管理』中设置或修改部署目录。

## 设置部署目录

如上面的代码示例中，将前端模块(default)的部署目录设置为`src/fronted`，后端模块(backend)的部署目录设置为`src/backend`。


注意:
- 部署目录不填则默认为根目录
- 部署目录下必须包含[Procfile](./process_procfile.md) 文件
- 部署目录下必须包含所有需要的代码，比如[构建阶段钩子](./build_hooks.md)（pre-compile 和 post-compile）都只能操作部署目录下的文件