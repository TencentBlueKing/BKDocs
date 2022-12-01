# 权限模型自动初始化及更新 migration

> 由于开发需求的不断迭代，系统的权限模型也会有一定修改，建议使用 Migration 的方式来执行权限模型变更

附件:

1. [do_migrate.py](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/contrib/iam_migration/utils/do_migrate.py) 是届时给运维用的工具, 每个接入系统的模型接入可以写好对应 migration 文件后, 用这个文件先进行测试
2. [example.json](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/contrib/iam_migration/utils/example.json) 是一个 migration 文件示例, 可以参考编辑自己系统的 migration 文件


注意:

- `do_migrate.py` 已交付 [do_migrate.py](https://github.com/TencentBlueKing/iam-python-sdk/blob/master/iam/contrib/iam_migration/utils/do_migrate.py)
- `do_validate.py` 暂未实现, coming soon


## 1. Migration 命令

```shell
# 校验json文件是否合法? 只有合法的文件才提交到代码库
python  do_validate.py 0001_bk_paas_20190619-1632_iam.json

# 执行migrate
python do_migrate.py -h

python do_migrate.py -t http://bkiam.service.consul -f 0001_bk_paas_20190619-1632_iam.json -a {app_code} -s {app_secret}

# 如果环境中存在 APIGateway, 使用统一的 APIGateway 上的bk-iam网关进行注册; env值 prod(生产)/stage(预发布)
python do_migrate.py -t http://bk-iam.{APIGATEWAY_DOMAIN}/{env} -f 0001_bk_paas_20190619-1632_iam.json -a {app_code} -s {app_secret} --apigateway
```
- `{app_code} / {app_secret}` 为应用在 IAM 接入系统对应环境的`{app_code}/{app_secret}`
- do_migrate.py 执行依赖 python 环境 `requests`包
- do_validate.py 执行依赖 python 环境`jsonschema`包
`

## 2. Migration 文件

### 存放目录

工程目录下 `support-files/bkiam/`

### 文件命名规则

`{序号}_{APP_CODE}_{时间戳}_iam.json`

具体：
- 序号: 由 4 位数字组成, 从 1 开始, 不足 4 位, 高位用 0 补全, 如: 0001
- APP_CODE: 应用或平台的唯一 ID
- 时间戳: 该文件的创建时间, 格式为: YYYYmmdd-HHMM

示例：

```bash
0001_bk_paas_20190619-1632_iam.json
0002_bk_paas_20190620-1000_iam.json
0001_bk_job_20190620-2040_iam.json
0001_bk_cmdb_20190619-1020_iam.json
```

## 3. Migration 内容规范

json 文件格式

```bash
{
    "system_id": "bk_paas",
    "operations": [
    {
            "operation": "[操作代码]",
            "data":{
                 # 数据
            }
    }
}
```

当前支持的操作代码

| 操作代码                          | data 类型(链接文档)                                                                            | 行为                 | 注意                      |
|:---|:---|:---|:---|
| upsert_system                  | Map,[格式](../../Reference/API/02-Model/10-System.md) | 新增或更新 system        | **推荐**                  |
| add_system                    |   同上                                                                                | 新增 system           | 当 system 已存在时将新增失败        |
| update_system                 |   同上                                                                             | 更新系统               | 不存在时将更新失败               |
| upsert_resource_type           |   Map, [格式](../../Reference/API/02-Model/11-ResourceType.md)                                                                              | 新增或更新 resource_type | **推荐**                  |
| add_resource_type             |   同上                                                                                 | 新增 resource_type    | 当 resource_type 已存在时将新增失败 |
| update_resource_type          |   同上                                                                               | 更新 resource_type    | 不存在时将更新失败               |
| delete_resource_type          |    `{"id": "theid"}`                                                                               | 删除 resource_type    |                         |
| upsert_instance_selection           |   Map, [格式](../../Reference/API/02-Model/12-InstanceSelection.md)                                                                              | 新增或更新 instance_selection | **推荐**                  |
| add_instance_selection             |   同上                                                                                 | 新增 instance_selection    | 当 instance_selection 已存在时将新增失败 |
| update_instance_selection          |   同上                                                                               | 更新 instance_selection    | 不存在时将更新失败               |
| delete_instance_selection          |    `{"id": "theid"}`                                                                               | 删除 instance_selection    |                         |
| upsert_action                  |   Map, [格式](../../Reference/API/02-Model/13-Action.md)                                                                                | 新增或更新 action        | **推荐**                  |
| add_action                    |   同上                                                                                | 新增 action           | 当 action 已存在时将新增失败        |
| update_action                 |   同上                                                                                | 更新 action           | 不存在时将更新失败               |
| delete_action                 |    `{"id": "theid"}`                                                                               | 删除 action           |                         |
| upsert_action_groups          |   `array[map]` [格式](../../Reference/API/02-Model/14-ActionGroup.md)  | 新增或更新操作组         |    **推荐** |
| upsert_resource_creator_actions |  `Map`, [格式](../../Reference/API/02-Model/19-ResourceCreatorAction.md)  | 新增或更新新建关联配置  |    **推荐**  |
| upsert_common_actions|  `array[map]`, [格式](../../Reference/API/02-Model/17-CommonActions.md)  | 新增或更新常用操作配置  |    **推荐**  |
| upsert_feature_shield_rules |  `array[map]`, [格式](../../Reference/API/02-Model/18-FeatureShieldRules.md)  | 新增或更新功能开关配置  |    **推荐**  |

**建议:**: 如果 migration 中存在多个操作, `新增`建议使用`upsert`来实现, 而不是`add_`来实现, `add_`将会导致, 同一个 migration 只能执行一次; 重复执行会报错(资源已存在)

**重要**: 注册 system 和更新 system 的时候, 其 client 务必包含自己的`app_code`; 否则一旦注册或更新成功, 这个系统的 clients 中不包含自己的 app_code, 此时无权限进行后续的所有操作!!!!
