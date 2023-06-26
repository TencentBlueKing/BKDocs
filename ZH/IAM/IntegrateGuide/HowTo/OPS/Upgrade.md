# 升级部署说明

## 背景

文档主要说明 IAM 某些版本做了较大的变更, 导致升级前需要执行的一些特殊步骤, 以便数据等可以平滑迁移

## 1. 权限中心 V3 SaaS 从 `<1.3.6` 升级到 `>= 1.4.x`

> 权限中心 `1.4.x` 相对于之前版本, 对用户组/权限模板做了较大修改
> 所以升级前, 需要升级到`1.3.6`使用这个版本提供的命令进行权限模板的数据同步

说明:
- 如果全新部署, 不需要关注本文档, 直接安装最新版本的 SaaS 及后台
- 当前环境 SaaS 版本`<1.3.6`的, 需要关注, 按步骤处理

### 1.1 升级步骤

1. 将权限中心后台版本升级到`1.6.1`, SaaS 版本升级到`1.3.6`

2. 全量同步所有的权限模板
```bash
ssh $BK_APPO_IP
docker exec -it $(docker ps | grep -w bk_iam | awk '{print $1}') bash
export BK_FILE_PATH="/data/app/code/conf/saas_priv.txt"
/cache/.bk/env/bin/python /data/app/code/manage.py sync_templates
# 脚本打印 Successful completion of template version synchronization 表示执行同步成功
```
3. 升级 IAM 后台到 `1.7.x`或最新版本
```bash
# 检查IAM后台版本 
curl http://{IAM_HOST}/version 确认版本号
```
注意, 这里的`{IAM_HOST}`是权限中心后台地址, 对应企业版社区版地址`curl http://bkiam.service.consul:5001/version`(如不确定, 具体咨询环境运维人员)
4. 升级 IAM SaaS 到 `1.4.x`或最新版本

### 1.2 异常处理
1. SaaS 升级到 1.4.x 报错 `you must sync all templates before run migrate`
   
   请先回退 SaaS 到 1.3.6 版本, 后台 1.6.1 版本, 重新执行升级步骤后再升级 SaaS 到 1.4.x
   
2. SaaS 执行 `python manage.py sync_templates` 报错 `ErrorCode 1902000:(code: None, message: request iam api error`
   
   请先回退 IAM 后台到 1.6.1 版本, 再执行以上命令

## 2. 权限中心 V3 后台 从 `<1.11.9` 升级到 `>=1.12.5`

> 权限中心 后台 `1.12.5` 相对与之前的版本, 增加了RBAC相关的接入功能, 对用户组鉴权数据做了较大的变更
> 所以升级前, 需要使用数据迁移脚本`migrate_subject_system_group.py`做变更前数据迁移

说明:
- 如果全新部署, 不需要关注本文档, 直接安装最新版本的 SaaS 及后台
- 当前环境 后台 版本`<1.12.5`的, 需要关注, 按步骤处理

### 2.1 升级步骤

1. 安装迁移脚本依赖

```bash
pip3 install PyMySQL
```

2. 下载数据迁移脚本

[migrate_subject_system_group.py](https://raw.githubusercontent.com/TencentBlueKing/bk-iam/master/build/support-files/migrate_subject_system_group.py)

3. 使用迁移脚本执行数据迁移

```bash
python3 migrate_subject_system_group.py -H {db_host} -P 3306 -u {db_user} -p {db_password} -D {db_name} migrate
```

参数说明:

- db_host: 权限中心后台数据库 host
- db_user: 权限中心后台数据库 用户名
- db_password: 权限中心后台数据库 密码
- db_name: 权限中心后台数据库 db库名

4. 检查数据迁移结果

```bash
python3 migrate_subject_system_group.py -H {db_host} -P 3306 -u {db_user} -p {db_password} -D {db_name} check
```

说明:
- 数据迁移过程中不要在权限中心SaaS做用户组授权相关的操作

5. 升级权限中心后台

### 2.2 异常处理

以上迁移与检查脚本都是可重入的, 如出现异常, 可尝试重试以上步骤


## 3. 权限中心后台二进制版本升级到蓝鲸社区版7.0容器化版本权限中心

由于容器化版本的权限中心后台的migrate sql逻辑执行的变化, 在二进制版本升级到容器化之时, 需要先执行ignore migrate sql, 以避免升级过程中migrate执行失败带来的问题.

> 以下步骤在全新部署容器化版本权限中心时不需要执行, 只针对二进制版本更新到容器化版本的使用场景

### 3.1 确认二进制权限中心后台版本号

查看当前二进制版本权限中心后台部署的版本, 获取对应的后台包, 比如权限中后台包: bkiam_ee-1.12.5.tgz

解压后台包后, 查看`support-files/sql`目录, 有以下文件:

```
0001_iam_20200327-1442_mysql.sql
0002_iam_20200512-1957_mysql.sql
0003_iam_20200525-1940_mysql.sql
0004_iam_20200624-1429_mysql.sql
0005_iam_20200702-1525_mysql.sql
0006_iam_20200803-1132_mysql.sql
0007_iam_20200904-1832_mysql.sql
0008_iam_20200915-1506_mysql.sql
0009_iam_20210304-1706_mysql.sql
0010_iam_20210330-1808_mysql.sql
0011_iam_20210421-1050_mysql.sql
0012_iam_20210618-1730_mysql.sql
0013_iam_20210624-1530_mysql.sql
0014_iam_20210823-1525_mysql.sql
0015_iam_20210909-1800_mysql.sql
0016_iam_20211209-1708_mysql.sql
0017_iam_20211116-1713_mysql.sql
0018_iam_20220111-1708_mysql.sql
0019_iam_20220217-1423_mysql.sql
0020_iam_20220424-1622_mysql.sql
0021_iam_20220425-1050_mysql.sql
0022_iam_20220517-1502_mysql.sql
0023_iam_20220518-1519_mysql.sql
0024_iam_20220523-0740_mysql.sql
0025_iam_20220601-1635_mysql.sql
0026_iam_20220718-1535_mysql.sql
0027_iam_20220914-1502_mysql.sql
0028_iam_20220921-1645_mysql.sql
```

### 3.2 生成ignore migrate sql

```sql
DROP TABLE IF EXISTS `gorp_migrations`;
CREATE TABLE `gorp_migrations` (
  `id` varchar(255) NOT NULL,
  `applied_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `gorp_migrations` VALUES 
('0001_iam_20200327-1442_mysql.sql',now()),
('0002_iam_20200512-1957_mysql.sql',now()),
('0003_iam_20200525-1940_mysql.sql',now()),
('0004_iam_20200624-1429_mysql.sql',now()),
('0005_iam_20200702-1525_mysql.sql',now()),
('0006_iam_20200803-1132_mysql.sql',now()),
('0007_iam_20200904-1832_mysql.sql',now()),
('0008_iam_20200915-1506_mysql.sql',now()),
('0009_iam_20210304-1706_mysql.sql',now()),
('0010_iam_20210330-1808_mysql.sql',now()),
('0011_iam_20210421-1050_mysql.sql',now()),
('0012_iam_20210618-1730_mysql.sql',now()),
('0013_iam_20210624-1530_mysql.sql',now()),
('0014_iam_20210823-1525_mysql.sql',now()),
('0015_iam_20210909-1800_mysql.sql',now()),
('0016_iam_20211209-1708_mysql.sql',now()),
('0017_iam_20211116-1713_mysql.sql',now()),
('0018_iam_20220111-1708_mysql.sql',now()),
('0019_iam_20220217-1423_mysql.sql',now()),
('0020_iam_20220424-1622_mysql.sql',now()),
('0021_iam_20220425-1050_mysql.sql',now()),
('0022_iam_20220517-1502_mysql.sql',now()),
('0023_iam_20220518-1519_mysql.sql',now()),
('0024_iam_20220523-0740_mysql.sql',now()),
('0025_iam_20220601-1635_mysql.sql',now()),
('0026_iam_20220718-1535_mysql.sql',now()),
('0027_iam_20220914-1502_mysql.sql',now()),
('0028_iam_20220921-1645_mysql.sql',now());
```

注意以上sql中的INSERT语句, 在3.1步骤中查询到多少sql文件, 这里就要插入多少行数据, 插入的行数必须与3.1步骤文件个数一致, 如您使用的二进制版本中的sql文件少于以上文件, 请删除多余的插入数据, 如您的二进制版本sql数量比以上文件多, 请在INSERT语句中补充缺失的sql文件

### 3.3 执行ignore migrate sql

在权限中心后台数据库中执行步骤3.2生成的sql语句

> **注意**: 只需要在二进制升级到容器化版本前执行, 后续容器化版本的升级不需要再次执行
