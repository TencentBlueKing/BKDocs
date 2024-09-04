# BlueKing SaaS framework migration tools
蓝鲸 SaaS 开发框架迁移工具

## 使用指南
###  patch
`patch` 指令是用于协助修改蓝鲸开发框架代码, 使其能在 PaaS3.0 中正常运行。

Usage: bkapp-migrate patch [OPTIONS] SRC

Options:
  --version [django1.11|django1.8|django2.2]
                                  [required]
  --use-celery / --no-use-celery
  --use-celery-beat / --no-use-celery-beat
  --help                          Show this message and exit.
  
例如, 如果需要 patch django1.11 版本的开发框架, 只需要执行以下指令: 
```bash
# 当安装该工具后, 会自动在当前的 python 环境下增加 `bkapp-migrate` 指令。

# patch django1.11 版本的框架, 且不使用 celery 和 celery beat
bkapp-migrate patch --version=django1.11 ${YOUR_CODE_PATH}
# patch django1.11 版本的框架, 使用 celery 但不使用 celery beat
bkapp-migrate patch --version=django1.11 ${YOUR_CODE_PATH} --use-celery
# patch django1.11 版本的框架, 使用 celery 和  celery beat
bkapp-migrate patch --version=django1.11 ${YOUR_CODE_PATH} --use-celery --use-celery-beat
```

## 注意事项
### 1. 开发框架代码结构
要使用 `patch` 指令协助修改蓝鲸开发框架代码, 需要保证未随意修改开发框架原始的项目结构。

- 对于 **django1.8** 版本的开发框架, 需要保证项目具有以下的目录结构:
```bash
.
├── config
│   ├── __init__.py
│   └── ...
└──  settings.py
```

- 对于 **django1.11** 版本的开发框架, 需要保证项目具有以下的目录结构:
```bash
.
├── blueapps
│   ├── __init__.py
│   ├── conf
│   │   ├── __init__.py
│   │   └── ...
│   ├── patch
│   │   ├── __init__.py
│   │   └── ...
│   └── ...
├── config
│   ├── __init__.py
│   └── ...
└──  settings.py
```


- 对于 **django2.2** 版本的开发框架, 需要保证项目具有以下的目录结构:
```bash
.
├── blueapps
│   ├── __init__.py
│   ├── conf
│   │   ├── __init__.py
│   │   └── ...
│   ├── patch
│   │   ├── __init__.py
│   │   └── ...
│   └── ...
├── config
│   ├── __init__.py
│   └── ...
└──  settings.py
```