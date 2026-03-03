## 背景

调用 ESB API 或者 ESB API 时，可能会出现响应提示无权限的情况

[如何确认错误的 response 是网关还是后端服务返回的？](../FAQ/gateway-error-or-backend-error.md) 文档中说明了如何确定是在哪个环节响应的。

根据响应，无权限分为两种情况：

1. 应用没有调用 **API 的权限**
2. 应用或用户没有业务系统的**数据权限**

## API 权限

> 由网关判断权限

注册 API 到网关时，如果勾选了`应用认证`+`校验访问权限`

![image.png](./media/api-permission-and-data-permission-01.png)

那么，此时调用方调用对应 API 时

1. 调用时需要提供`bk_app_code/bk_app_secret`会校验应用身份，具体可参考 [认证](./authorization.md)
2. 会校验应用是否有调用 API 的权限

![image.png](./media/api-permission-and-data-permission-02.png)

如果没有权限，将会返回 [网关错误响应说明：App has no permission to the resource](../FAQ/gateway-error-or-backend-error.md)

```json
{
  "code": 1640301,
  "data": null,
  "code_name": "APP_NO_PERMISSION",
  "message": "App has no permission to the resource",
  "result": false
}
```

**解决**: 到蓝鲸开发者中心找对应的应用，点进去，`云 API 管理 - 云 API 权限申请`对应接口权限或者进行权限续期

## 数据权限

> 由业务系统或权限中心判断

此时，情况已经**经过网关**, 到达了后端服务，**响应是后端服务返回的** (不是网关返回的)

![image.png](./media/api-permission-and-data-permission-03.png)

此时有两种情况：

### 如果业务系统接入了权限中心

那么会返回 `9900403`, 需要**对应的用户有相关的权限**

```json
{
  "code": 9900403,
  "permission": {
    "system_name": "配置平台",
    "system_id": "bk_cmdb",
    "actions": [
      {
        "related_resource_types": [
          {
            "system_name": "配置平台",
            "type": "biz",
            "type_name": "业务",
            "system_id": "bk_cmdb",
            "instances": [
              [
                {
                  "type_name": "业务",
                  "type": "biz",
                  "id": "36",
                  "name": "abc"
                }
              ]
            ]
          }
        ],
        "id": "find_business_resource",
        "name": "业务访问"
      }
    ]
  }
}
```

**解决**: 用户到权限中心申请相关权限，或者管理员在权限中心主动授权


### 如果业务系统没有接入权限中心

可能返回**任何自定义的响应体**

可能是

```json
{
  "result": false,
  "message": "you have no permission to call this api.",
  "code": 3540100,
  "trace_id": "5ddbc49db2554edbbdf26e6c15ca6884",
  "request_id": "c9d7fe1fcade42869f4ec6b4ac6434f1",
  "data": null
}
```

也可能是

```html
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.15.5</center>
</body>
</html>
```

**解决**: 资源业务系统开发者确定问题
