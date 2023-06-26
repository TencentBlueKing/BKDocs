# 安装目录介绍

## 1. 整体目录概览

```bash
bklog
├── api
│   ├── apps
│   ├── bin
│   ├── bkoauth
│   ├── blueapps
│   ├── blueking
│   ├── config
│   ├── flower_proxy
│   ├── home_application
│   ├── __init__.py
│   ├── locale
│   ├── manage.py
│   ├── README.md
│   ├── requirements_env.txt
│   ├── requirements.txt
│   ├── runtime.txt
│   ├── settings.py
│   ├── sites
│   ├── static
│   ├── templates
│   ├── urls.py
│   ├── VERSION
│   ├── version_log
│   ├── version_logs
│   ├── version_logs_html
│   └── wsgi.py
├── projects.yaml
├── support-files
│   └── templates
└── VERSION
```

- `api` - 子模块，此处与 SaaS 包的源码一致
- `projects.yaml` - 包信息
- `VERSION` - 版本号，与 SaaS 保持一致，便于版本维护

## 2. bin 目录

bin 目录主要提供后台命令操作的命令集

```bash
├── bin
│   ├── environ.sh
│   └── manage.sh
```

- `environ.sh` - 提供应用运行所必需的环境变量，如 `APP_ID`， `APP_TOKEN`， `DB_USERNAME`等
- `manage.sh` - `python manage.py` 命令的封装，执行时会先 `source environ.sh`，把环境变量加载进来。

例如，想要进入 django 控制台，可以执行以下命令

```bash
bin/manage.sh shell
```

## 3. support-files 目录

`templates` 目录用于存放模板文件，有些变量在部署时才能确定，例如域名、部署 IP、组件密码。可以把这些变量以占位符的形式写到模板中，于部署时渲染，并写入到指定目录中

```bash
support-files
└── templates
    ├── #etc#supervisor-bklog_search.conf
    └── log_search#bin#environ.sh
```

