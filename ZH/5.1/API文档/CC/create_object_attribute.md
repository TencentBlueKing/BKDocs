
### 请求地址

/api/c/compapi/v2/cc/create_object_attribute/



### 请求方法

POST


### 功能描述

创建模型属性

### 请求参数


#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                  |  类型      | 必选   |  描述                                                    |
|-----------------------|------------|--------|----------------------------------------------------------|
| creator               | string     | 否     | 数据的创建者                                             |
| description           | string     | 否     | 数据的描述信息                                           |
| editable              | bool       | 否     | 表明数据是否可编辑                                       |
| isonly                | bool       | 否     | 表明唯一性                                               |
| ispre                 | bool       | 否     | true:预置字段,false:非内置字段                           |
| isreadonly            | bool       | 否     | true:只读，false:非只读                                  |
| isrequired            | bool       | 否     | true:必填，false:可选                                    |
| option                | string     | 否     |用户自定义内容，存储的内容及格式由调用方决定，以数字类型为例（{"min":"1","max":"2"}）|
| unit                  | string     | 否     | 单位                                                     |
| placeholder           | string     | 否     | 占位符                                                   |
| bk_property_group     | string     | 否     | 字段分栏的名字                                           |
| bk_obj_id             | string     | 是     | 模型ID                                                   |
| bk_supplier_account   | string     | 是     | 开发商账号                                               |
| bk_property_id        | string     | 是     | 模型的属性ID                                             |
| bk_property_name      | string     | 是     | 模型属性名，用于展示                                     |
| bk_property_type      | string     | 是     | 定义的属性字段用于存储数据的数据类型,可取值范围（singlechar,longchar,int,enum,date,time,objuser,singleasst,multiasst,timezone,bool）|
| bk_asst_obj_id        | string     | 否     | 如果有关联其它的模型，那么就必需设置此字段，否则就不需要设置                                                                        |

#### bk_property_type

| 标识       | 名字     |
|------------|----------|
| singlechar | 短字符   |
| longchar   | 长字符   |
| int        | 整形     |
| enum       | 枚举类型 |
| date       | 日期     |
| time       | 时间     |
| objuser    | 用户     |
| singleasst | 单关联   |
| multiasst  | 多关联   |
| timezone   | 时区     |
| bool       | 布尔     |

### 请求参数示例

```python
{
	"creator": "user",
	"description": "test",
	"editable": "true",
	"isonly": "false",
	"ispre": "false",
	"isreadonly": "false",
	"isrequired": "false",
	"option": {"min":"1","max":"2"},
	"unit": "1",
	"placeholder": "test",
	"bk_property_group": "default",
	"bk_obj_id": "cc_test_inst",
	"bk_supplier_account": "0",
	"bk_property_id": "cc_test",
	"bk_property_name": "cc_test",
	"bk_property_type": "singlechar",
	"bk_asst_obj_id": "test"
}
```


### 返回结果示例

```python

{
    "result": true,
    "code": 0,
    "message": "",
	"data": {
		"id": 11142
	}
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      | 描述               |
|-----------|-----------|--------------------|
| id        | int       | 新增的数据记录的ID |