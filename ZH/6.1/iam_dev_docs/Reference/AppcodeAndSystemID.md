# AppCode 和 SystemID

## app_code

`app_code`  代表 app 的唯一身份, `app_code+app_secret`进行的身份校验.

**唯一被使用的地方是放在 http 请求头里面做校验**(不应该出现在其他地方), 具体见 [接口协议前置说明](../Reference/API/01-Overview/02-APIBasicInfo.md)

-  `X-Bk-App-Code`  蓝鲸应用 app_code
-  `X-Bk-App-Secret`  蓝鲸应用 app_secret

注意, app_code 可能在不同环境不一样, 例如把`应用1`部署到测试环境, app_code 可以是`bk_test1`, 部署到另一套环境, app_code 可以是`bk_test1_prod`

## system_id

system_id 是接入系统注册到权限中心的唯一标识; 

**使用位置: 在拼接 url 地址 / http 请求 body 中**


## 区别

理论上, `system_id` 同 `app_code` 没有关系; **一定不要混用**

- `在蓝鲸, 限制了一个app_code只能创建一个system, 且该system的ID等于app_code`
- 上云版, 关闭了这个限制; 所以会出现 app_code 不等于 system_id
- 其他环境, 可以控制是否开启这个限制

建议: **在代码逻辑中, 请同时声明 app_code 和 system_id 两个变量, 即使这两个变量的值当前是一致的!**


## 多个 app 共用同一套 system 的权限数据

使用场景: 存在多个 app, 例如微服务体系下的多套系统, 共用的一套权限数据; 此时由一个主系统注册权限模型, 其他子系统共用权限数据; 

此时, 多个 app_code 需要调用同一个 system_id 的接口进行策略查询/鉴权等操作

解决方案: system 注册的时候, 声明了`clients=[app_code]`列表, 即允许哪些 app 可以调用这个系统的权限数据; 具体文档[系统(System) API](API/02-Model/10-System.md)