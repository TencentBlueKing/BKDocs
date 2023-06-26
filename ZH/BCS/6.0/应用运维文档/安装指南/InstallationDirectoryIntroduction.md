# 安装包

-   文件

bcs_web_console-ce-\*.tar.gz 容器服务 WebConsole 后台

bk_bcs_app_V\*.tar.gz        容器服务 SaaS 安装包

bk_bcs_monitor_V\*.tar.gz    监控中心 SaaS 安装包

bcs_monitor-ce-\*.tar.gz     监控中心后台包

bcs_cc-ce-\*.tar.gz          配置中心安装包

-   文件目录结构和功能说明

```bash
bk_bcs_app_V*.tar.gz
├── app.yml.               # App 配置文件
├── pkgs                   # 依赖包
└── src                    # 源码目录
       ├── backend         # API 源码
       ├── bin             # kubectl
       ├── bk_bcs_app.png  # app logo
       ├── etc
       ├── manage.py        # django 管理
       ├── requirements.txt # 依赖配置
       ├── runtime.txt      # python3 配置
       ├── settings.py      # Django 配置
       ├── staticfiles.     # 静态资源
       ├── wsgi.py          # wsgi 入口文件

bcs_web_console-ce-*.tar.gz
      ├── support-files
      │   ├── pkgs      # 依赖包
      │   └── templates # 配置模板
      └── web_console.  # web-console 源码
          ├── README.md
          ├── VERSION
          ├── backend
          ├── bcs_perm_model.json
          ├── manage.py
          ├── on_migrate
          ├── project.yml
          ├── release.md
          └── requirements.txt

bk_bcs_monitor_V*
├── app.yml. # App 配置文件
├── pkgs     # 依赖包文件
└── src      # 源码目录
    ├── backend             # 后台 API 目录
    ├── bk_bcs_monitor.png  # LOGO
    ├── manage.py           # Django 管理脚本
    ├── requirements.txt    # 依赖包管理文件
    ├── runtime.txt         # Python3 文件
    ├── settings.py         # Django settings 文件
    ├── staticfiles         # 静态文件目录
    ├── wsgi.py             # wsgi 文件

bcs_monitor-ce*
├── grafana       # grafana 工程目录
│   ├── README.md
│   ├── VERSION
│   ├── bin
│   ├── conf
│   ├── data
│   ├── project.yml
│   ├── public
│   └── release.md
├── monitor       # 容器监控工程目录
│   ├── README.md
│   ├── VERSION
│   ├── backend
│   ├── bkmonitor
│   ├── ce
│   ├── conf
│   ├── kernel
│   ├── manage.py
│   ├── monkey.py
│   ├── on_migrate
│   ├── patches
│   ├── project -> ce
│   ├── project.yml
│   ├── release.md
│   └── requirements.txt
└── support-files
    ├── pkgs      # 依赖包
    ├── sql       # sql 初始化文件
    └── templates # 模板文件

bcs_cc-ce-*.tar.gz
├── cc
│   ├── CHANGELOG.md
│   ├── README.md
│   ├── VERSION
│   ├── bin       服务启动目录
│   ├── on_migrate
│   └── project.yml
├── release.md
└── support-files
    └── templates 启动服务需要的配置模板
```
