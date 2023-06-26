# 安装包

- 文件

    - SaaS：`bk_nodeman_V${version}.tar.gz`
    - 后台： `bknodeman_ee-${version}.tgz`


- 文件目录结构和功能说明
```bash

-- bk_nodeman
├── app.yml             # App 配置文件
├── apps
│   ├── backend         # 节点管理后台
│   ├── component       # ESB组件
│   ├── exceptions.py   # 异常模块
│   ├── generic.py      # DRF 通用基类
│   ├── middlewares.py  # 通用中间件
│   ├── node_man        # 节点管理SaaS
│   └── utils           # 工具类
├── bin
│   ├── environ.sh      # 环境变量
│   ├── manage.sh       # 管理脚本
├── bkoauth             # 蓝鲸登录模块
├── blueapps            # 蓝鲸开发框架
├── blueking            # 蓝鲸组件
├── common              # 通用模块
├── config              # 配置模块
├── frontend            # 前端工程
├── iam                 # 权限中心模块
├── locale              # 国际化文件
├── manage.py           # Django 管理脚本
├── pipeline            # 流程引擎模块
├── release             # 版本日志
├── requests_tracker    # 请求追踪模块
├── requirements.txt    # 依赖说明
├── script_tools        # 安装脚本及工具
├── settings.py         # Django配置
├── sites
│   └── open            # 企业版相关配置
├── static              # 静态文件
├── support-files       # 依赖文件及配置文件模板
│   └── templates
├── urls.py
├── version_log
└── wsgi.py

```
