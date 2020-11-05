### 请求地址

/api/c/compapi/v2/bk_docs_center/get_doc_link_by_path/

### 请求方法

POST

### 功能描述

根据md文档名查询文档链接

### 请求参数

#### 通用参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token与bk_username必须一个有效，bk_token可以通过Cookie获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段      |  类型      | 必选   |  描述      |
|-----------|------------|--------|------------|
| version         |  string    | 是     | 查询版本 |
| md_path         |  string    | 是     | md文档所在结构路径（如：流程服务/产品白皮书/FAQ/FAQ.md）|

### 请求参数示例

```json
{
	"version":"6.0",
	"md_path": "流程服务/产品白皮书/FAQ/FAQ.md"
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": "document/6.0/2/1"
}
```