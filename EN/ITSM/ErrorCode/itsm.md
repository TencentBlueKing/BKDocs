# 流程服务错误码

## 服务错误

| 错误码 | 错误码名称         | 含义                               |
| ----- | ------------- | -------------------------------- |
|3900000 |FATAL_ERROR |错误|
|3900001 |Migrate_Data_Error |升级失败 |
|3900002 |NOT_ALLOWED_ERROR |方法不允许 |
|3900500 |SERVER_500_ERROR |系统异常 |


## 业务处理错误

| 错误码 | 错误码名称         | 含义                               |
| ----- | ------------- | -------------------------------- |
|3900003 |CREATE_TICKET_ERROR |提单失败 |
|3900004 |OPERATE_TICKET_ERROR |单据操作失败 |
|3900005 |FORM_VALIDATE_ERROR |参数验证失败 |
|3900006 |ANNEX_STORE_VALIDATE_ERROR |附件存储 |
|3900007 |ORGANIZATION_STRUCTURE_FUNCTION_SWITCH_VALIDATE_ERROR |组织架构功能开关 |
|3900008 |SERVICE_CATALOG_VALIDATE_ERROR |服务目录 |
|3900009 |DELETE_ERROR |删除失败 |
|3900010 |WORKFLOW_ERROR |创建流程失败 |
|3900011 |WORKFLOW_INVALID_ERROR |流程保存失败|
|3900016 |OBJECT__NOT_MATCH_ERROR |当前对象不匹配查询条件 |
|3900017 |STATE_NOT_FOUND_ERROR |没有找到对应的节点 |
|3900018 |REVOKE_PIPELINE_ERROR |流程终止失败 |
|3900019 |CALL_PIPELINE_ERROR |流程服务调用失败 |
|3900020 |TRANSITION_ERROR |添加连接线失败 |
|3900021 |VALIDATE_ERROR |参数错误 |
|3900022 |TICKET_NOT_FOUND_ERROR |没有找到对应的单据 |
|3900023 |SLA_TASK_ERROR |SLA 任务异常|
|3900025 |COMPONENT_NOT_EXIST |组件未找到 |
|3900026 |TRIGGER_VALIDATE_ERROR |触发器参数校验错误 |
|3900027 |COMPONENT_INVOKE_ERROR |组件调用错误 |
|3900028 |TASK_FLOW_INIT_ERROR |任务流程初始化失败 |
|3900029 |CALL_TASK_PIPELINE_ERROR |任务服务调用失败 |
|3900030 |FIELD_IS_REQUIRED |必填字段不存在 |
|3900404 |OBJECT_NOT_EXIST |查找对象不存在 |
|3900031 |CHILD_TICKET_FUNCTION_SWITCH_VALIDATE_ERROR |母子单功能开关 |
|3900032 |TASK_FUNCTION_SWITCH_VALIDATE_ERROR |任务功能开关 |
|3900033 |TRIGGER_FUNCTION_SWITCH_VALIDATE_ERROR |触发器功能开关 |

## 第三方接口

| 错误码 | 错误码名称         | 含义                               |
| ----- | ------------- | -------------------------------- |
|3900012 |REMOTE_CALL_ERROR |远程服务请求结果异常 |
|3900014 |COMPONENT_CALL_ERROR |组件调用异常 |
|3900024 |RPC_API_ERROR |RPC 的 API 返回错误 |

## 权限错误

| 错误码 | 错误码名称         | 含义                               |
| ----- | ------------- | -------------------------------- |
|3900015 |PERMISSION_ERROR |权限不足 |
|3900499 |IAM_PERMISSION_DENIED |用户没有对应模块的权限 |
|3900034 |IAM_GRANT_CREATOR_ACTION |关联创建权限失败 |
