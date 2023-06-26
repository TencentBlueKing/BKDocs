# 安装包

- 文件

job_ee-x.x.x.tgz

- 文件目录结构和功能说明

```bash
|- job_ee-1.0.0.tgz      # 包根目录
  |- job_ee-1.0.0.tar
    |- job               # job程序根目录
      |- backend             # 后端程序存放目录
        |- job-manage
          |- bin
            |- job-manage.sh    # job-manage微服务启停脚本
          |- job-manage.jar  #job-manage微服务的SpringBoot.jar
        |- job-config
          |- bin
            |- job-config.sh        # job-config微服务启停脚本
          |- job-config.jar #job-config微服务的SpringBoot.jar
        ...
      |- frontend         # 前端程序存放目录
        |- static         # 前端静态文件目录
        |- index.html     # 前端页面入口
      |- support-files
        |- sql                  # db升级脚本
          |- 0001_job_ee_20200101-1000_mysql.sql
        |- iam                  # 权限接入升级脚本
          |- 0001_bk_job_20190624-0000_iam.json
        |- templates            # 需要部署渲染的模板
          |- #etc#job#application-config.yml
          |- #etc#job#application-gateway.yml
          |- #etc#job#application-manage.yml
          |- #etc#job#application-execute.yml
          |- #etc#job#application-crontab.yml
          |- #etc#job#application-logsvr.yml
          |- #etc#job-config#job-config.properties
          |- #etc#job-gateway#job-gateway.properties
          |- #etc#job-manage#job-manage.properties
          |- #etc#job-crontab#job-crontab.properties
          |- #etc#job-execute#job-execute.properties
          |- #etc#job-logsvr#job-logsvr.properties
      |- projects.yaml          # 工程描述文件
      |- README.md              # job概述
      |- release.md             # 变更历史（后台查看）
      |- VERSION                # 版本号
    ...
```
