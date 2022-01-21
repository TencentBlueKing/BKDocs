### 功能描述

查询进程包列表

### 请求参数

| 字段 | 类型 | 必选 |  描述 |
|-----------|------------|--------|------------|
| bk_app_code  |  string    | 是 | 应用 ID     |
| bk_app_secret|  string    | 是 | 安全密钥(应用 TOKEN)，可以通过 蓝鲸智云开发者中心 -&gt; 点击应用 ID -&gt; 基本信息 获取 |
| bk_token     |  string    | 否 | 当前用户登录态，bk_token 与 bk_username 必须一个有效，bk_token 可以通过 Cookie 获取 |
| bk_username  |  string    | 否 | 当前用户用户名，应用免登录态验证白名单中的应用，用此字段指定当前用户 |

#### 接口参数

| 字段     | 类型       | 必选 |描述                  |
|----------|------------|----------|-----------------------------|
| name | list | 是 | 插件名称 |
| os | list | 是 | 系统类型 LINUX\WINDOWS\AIX|

### 请求参数示例
```plain
{
    "name": "basereport",
    "os": "LINUX"
}
```

### 返回结果示例
```plain
{
    "message": "",
    "code": 0,
    "data": [
        {
            "cpu_arch": "x86_64",
            "pkg_mtime": "2020-12-20 12:13:02.593875+00:00",
            "module": "gse_plugin",
            "project": "basereport",
            "pkg_size": 5142399,
            "version": "10.8.40",
            "pkg_name": "basereport-10.8.40.tgz",
            "location": "http://127.0.0.1/download/linux/x86_64",
            "pkg_ctime": "2020-12-20 12:13:02.593875+00:00",
            "pkg_path": "/data/bkee/public/bknodeman/download/linux/x86_64",
            "os": "linux",
            "id": 27,
            "md5": "c56c9eedaa81c36a5c5177eb14d9449e"
        }
    ],
    "result": true,
    "request_id": "185ab35db70441e39488156c0c17f938"
}
```
