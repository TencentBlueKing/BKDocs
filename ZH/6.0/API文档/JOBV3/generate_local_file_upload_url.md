### 功能描述

生成本地文件上传 URL。

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段                        |  类型      | 必选   |  描述       |
|----------------------------|------------|--------|------------|
| bk_biz_id                  |  long      | 是     | 业务 ID     |
| file_name_list             |  string[]  | 是     | 要上传的文件名列表 |


### 请求参数示例

```json
{
    "bk_app_code": "esb_test",
    "bk_app_secret": "xxx",
    "bk_token": "xxx",
    "bk_biz_id": 1,
    "file_name_list": [
        "file1.txt",
        "file2.txt"
    ]
}
```

### 返回结果示例

```json
{
    "result": true,
    "code": 0,
    "message": "success",
    "data": {
        "url_map": {
            "file1.txt": {
                "upload_url": "http://bkrepo.com/generic/temporary/upload/bkjob/localupload/1/008f821f-259b-4f62-bd84-1e89d6f05f0d/admin/file1.txt?token=30adf862fdce4b02b909e6a1a1c762c6",
                "path": "1/008f821f-259b-4f62-bd84-1e89d6f05f0d/admin/file1.txt"
            },
            "file2.txt": {
                "upload_url": "http://bkrepo.com/generic/temporary/upload/bkjob/localupload/1/008f821f-259b-4f62-bd84-1e89d6f05f0d/admin/file2.txt?token=30adf862fdce4b02b909e6a1a1c762c6",
                "path": "1/008f821f-259b-4f62-bd84-1e89d6f05f0d/admin/file2.txt"
            }
        }
    }
}
```

### 返回结果参数说明

#### data

| 字段      | 类型      |字段是否一定存在  | 描述      |
|-----------|----------|---------------|---------|
| url_map   | map      |  是           | key:传入的文件名，value:upload_url 为带凭据的文件上传地址，path 为分发该文件时要传给文件分发接口的路径 |
