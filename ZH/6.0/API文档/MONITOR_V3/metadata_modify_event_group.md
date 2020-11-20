
### 请求地址

/api/c/compapi/v2/monitor_v3/metadata_modify_event_group/



### 请求方法

POST


### 功能描述

修改一个事件分组 ID
给定一个事件分组 ID，修改某些具体的信息



#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段           | 类型   | 必选 | 描述        |
| -------------- | ------ | ---- | ----------- |
| event_group_id  | int | 是   | 事件组 ID |
| event_group_name | string | 是 | 事件分组名 | 
| label | string | 否 | 事件分组标签，用于表示事件监控对象，应该复用【result_table_label】类型下的标签 |
| operator | string | 否 | 操作者 |
| event_info_list | bool | 否 | 事件列表 |
| is_enable | bool | 否 | 是否停用事件组 |

#### 请求示例

```json
{
	"bk_group_id": 123,
	"label": "application",
	"operator": "system",
	"description": "what the group use for.",
	"is_enable": true,
	"event_info_list": [{
	  "event_name": "usage for update",
	  "dimension_list": ["dimension_name"]
    },{
	  "event_name": "usage for create",
	  "dimension_list": ["dimension_name"]
	}]
}
```

### 返回结果

#### 字段说明

| 字段                | 类型   | 描述     |
| ------------------- | ------ | -------- |
| bk\_group_id | int | 新建的事件分组 ID  |


#### 结果示例

```json
{
    "message":"OK",
    "code":"0",
    "data": {
    	"event_group_id": 1001,
    	"bk_data_id": 123,
    	"bk_biz_id": 123,
    	"label": "application",
    	"description": "use for what?",
    	"is_enable": true,
    	"creator": "admin",
    	"create_time": "2019-10-10 10:10:10",
    	"last_modify_user": "admin",
    	"last_modify_time": "2020-10-10 10:10:10"
    },
    "result":true,
    "request_id":"408233306947415bb1772a86b9536867"
}
```