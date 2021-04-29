# 升级部署说明

## 背景
文档主要说明 IAM某些版本升级需要执行的一些特殊步骤

## 升级 SaaS版本 >= 1.4.x
### 升级步骤
1. 升级 IAM 后台版本到`1.6.1`, SaaS 版本到`1.3.6`

2. 全量同步所有的权限模板
```bash
ssh $BK_APPO_IP
docker exec -it $(docker ps | grep -w bk_iam | awk '{print $1}') bash 
/cache/.bk/env/bin/python /data/app/code/manage.py sync_templates
# 脚本打印 Successful completion of template version synchronization 表示执行同步成功
```

3. 升级 IAM 后台到 1.7.x
```bash
# 检查IAM后台版本 
curl http://{IAM_HOST}/version 确认版本号
```

4. 升级 IAM SaaS到 1.4.x

### 异常处理
1. SaaS 升级到 1.4.x 报错 `you must sync all templates before run migrate`
   - 请先回退 SaaS 到 1.3.6 版本, 后台 1.6.1 版本, 重新执行升级步骤后再升级 SaaS 到 1.4.x
   
2. SaaS 执行 `python manage.py sync_templates` 报错 `ErrorCode 1902000:(code: None, message: request iam api error`
   - 请先回退 IAM 后台到 1.6.1 版本, 再执行以上命令





