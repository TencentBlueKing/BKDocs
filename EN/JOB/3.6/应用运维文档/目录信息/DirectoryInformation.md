# 部署目录说明
## 总体目录
```bash
|- /data/bkee  # 蓝鲸根目录
  |- job      # job部署程序目录
  |- etc       # 蓝鲸配置文件总目录
    |- job    # job配置文件目录
```

## 程序目录
```bash
|- /data/bkee/job       # 程序主目录
  |- frontend            # 存放的前端发布的静态资源目录
  |- backend             # 后端服务存放目录
    |- job-manage
      |- job-manage.sh        # job-manage微服务启停脚本
      |- boot-job-manage.jar  # job-manage微服务的SpringBoot.jar
    |- job-config
      |- job-config.sh        # job-config微服务启停脚本
      |- boot-job-config.jar  # job-config微服务的SpringBoot.jar
    ...
```
## 配置文件目录
```bash
|- /data/bkee/etc   # 蓝鲸配置文件总目录
  |- job 				  # job配置文件目录
    |- job-manage   # job-manage服务配置目录
      |- job-manage.properties
...
```

# 日志

- 基本目录：`${BK_HOME}/logs/job/${SERVICE_NAME}`

   - ${SERVICE_NAME}.log：后台程序日志. 命名为: 微服务名称.log, 比如 manage.log,execute.log,logsvr.log

   - esb_job.log：ESB API 请求日志
   
   - esb_client.log: Job 通过 ESB 调用第三方系统请求日志

   - error.log：错误日志