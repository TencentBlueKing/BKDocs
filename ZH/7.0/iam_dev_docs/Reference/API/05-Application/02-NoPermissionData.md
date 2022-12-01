## 第三方鉴权失败返回权限申请数据协议

#### 背景

标准运维调用作业平台执行作业, 如果是因为鉴权失败导致执行失败, 作业平台需要返回以下错误信息到标准运维, 标准运维使用以下数据展示需要申请的权限信息, 然后再调用以上 API 到权限中心申请权限

#### 建议：接口 HTTP 状态码
http status_code = `200`

### 返回接口 response body 协议
> `字段code = 9900403 , 且需要有 permission字段返回需要对应申请的权限数据`

```json
{
  "code": 9900403,
  "message": "",
  "data": null,
  "permission": {
    "system": "bk_job",
    "system_name": "作业平台",
    "actions": [
      {
        "id": "execute_job",
        "name": "执行作业",
        "related_resource_types": [
          {
            "system": "bk_job",
            "system_name": "作业平台",
            "type": "job",
            "type_name": "作业",
            "instances": [
              [
                {
                  "type": "job",
                  "type_name": "作业",
                  "id": "job1",
                  "name": "作业1"
                }
              ]
            ]
          },
          {
            "system": "bk_cmdb",
            "system_name": "配置平台",
            "type": "host",
            "type_name": "主机",
            "instances": [
              [
                {
                  "type": "biz",
                  "type_name": "业务",
                  "id": "biz1",
                  "name": "业务1"
                },
                {
                  "type": "set",
                  "type_name": "集群",
                  "id": "set1",
                  "name": "集群1"
                },
                {
                  "type": "module",
                  "type_name": "模块",
                  "id": "module1",
                  "name": "模块1"
                },
                {
                  "type": "host",
                  "type_name": "主机",
                  "id": "host1",
                  "name": "主机1"
                }
              ]
            ]
          }
        ]
      }
    ]
  }
}
```