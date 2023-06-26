
### 请求方法

POST


### 请求地址

/api/c/compapi/v2/itsm/operate_node/


### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -> 点击应用ID -> 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |


### 功能描述

单据节点操作接口

### 请求参数



#### 接口参数

| 字段        | 类型     | 必选  | 描述                         |
| --------- | ------ | --- | -------------------------- |
| sn        | string | 是   | 单号
| operator   | string | 是   | 单据节点处理人、单据节点认领人，必须在处理人范围内|
| state_id  | int | 是   | 节点ID，必须是当前可处理的节点 |
| action_type   | string | 是   | 操作类型： TRANSITION（审批）/CLAIM（认领）/DISTRIBUTE（派单）/DELIVER（转单） ）/TERMINATE（终止节点和单据） |
| fields    | array  | 否   | 审批表单字段列表（审批操作必填，其他操作类型不填）|
| processors_type    | string  | 否   | 被指定的处理人类型（派单和转单操作必填，其他操作类型不填）：GENERAL(通用角色表)，组织架构(ORGANIZATION)，PERSON(个人)，STARTER(提单人)|
| processors    | string  | 否   | 被指定的处理人（派单和转单操作必填，其他操作类型不填）： processors_type是GENERAL时为系统唯一标识，ORGANIZATION时为角色ID，是PERSON时为蓝鲸用户的username，是STARTER时为空|
| action_message    | string  | 否   | 操作备注信息（转单和终止操作必填，其他操作类型选填）|

### fields

| 字段                     | 类型    | 必选 | 描述       |
| ---------------------- | ------ | -------- |------|
| key     | string |是| 字段唯一标识|
| value | string |是   | 字段值 |

### 请求参数示例一：审批

```json
{  
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx",
    "sn": "NO2019110816441094",
    "operator": "zhangsan",
    "action_type": "TRANSITION",
    "action_message": "test",
    "state_id": 4,
    "fields": [
      {
        "key": "SHENPIJIEGUO",
        "value": "TONGYI"
      },
      {
        "key": "SHENPIBEIZHU",
        "value": "hello"
      }
    ]
}  
```

### 请求参数示例二：转单

```json
{
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx",
    "sn": "NO2019110710341888",
    "operator": "zhangsan",
    "action_type": "DELIVER",
    "action_message": "test",
    "processors": "zhangsan",
    "processors_type": "PERSON",
    "state_id": 4
} 
```


### 请求参数示例三：认领

```json
{
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx",
    "sn": "NO2019110816441094",
    "operator": "zhangsan",
    "action_type": "CLAIM",
    "action_message": "test",
    "state_id": 4
}
```


### 请求参数示例四：终止

```json
{
    "bk_app_secret": "xxxx", 
    "bk_app_code": "xxxx", 
    "bk_token": "xxxx",
    "sn": "NO2019110816441094",
    "operator": "zhangsan",
    "action_type": "TERMINATE",
    "action_message": "test",
    "state_id": 4
}
```


### 返回结果示例

```json
{
    "message": "success",
    "code": 0,
    "data": [],
    "result": true
}
```

### 返回结果参数说明

| 字段      | 类型        | 描述                      |
| ------- | --------- | ----------------------- |
| result  | bool      | 返回结果，true为成功，false为失败   |
| code    | int       | 返回码，0表示成功，其他值表示失败       |
| message | string    | 错误信息                    |
| data    | object | 返回数据，为空 |