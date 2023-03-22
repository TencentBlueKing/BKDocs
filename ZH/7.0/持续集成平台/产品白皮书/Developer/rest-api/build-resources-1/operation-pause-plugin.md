# 操作暂停插件

### 请求方法/请求路径

#### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/execute/pause

### 资源描述

#### 操作暂停插件

### 输入参数说明

#### Body参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| body | [流水线暂停操作实体类](operation-pause-plugin.md) | 否 |  |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型Boolean](operation-pause-plugin.md) |

#### 请求样例

```javascript
curl -X POST '[请替换为API地址栏请求地址]' \
-H 'X-DEVOPS-UID:xxx'
```

#### HEADER样例

```javascript
accept: application/json
Content-Type: application/json
X-DEVOPS-UID:xxx
```

### 返回样例-200

```javascript
{
  "data" : true,
  "message" : "String",
  "status" : 0
}
```

## 流水线暂停操作实体类

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| continue | boolean | 否 | continue |
| containerId | string | 否 | 当前containerId |
| taskId | string | 否 | 任务ID |
| element | [Element](operation-pause-plugin.md) | 否 | element信息,若插件内有变量变更需给出变更后的element |
| stageId | string | 否 | 当前stageId |

## Element

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| canRetry | boolean | 否 | canRetry |
| errorType | string | 否 | errorType |
| errorCode | integer | 否 | errorCode |
| canSkip | boolean | 否 | canSkip |
| startEpoch | integer | 否 | startEpoch |
| version | string | 否 | version |
| executeCount | integer | 否 | executeCount |
| templateModify | boolean | 否 | templateModify |
| elementEnable | boolean | 否 | elementEnable |
| errorMsg | string | 否 | errorMsg |
| elapsed | integer | 否 | elapsed |
| atomCode | string | 否 | atomCode |
| additionalOptions | [ElementAdditionalOptions](operation-pause-plugin.md) | 否 | additionalOptions |
| taskAtom | string | 否 | taskAtom |
| name | string | 否 | name |
| id | string | 否 | id |
| classType | string | 否 | classType |
| status | string | 否 | status |

## ElementAdditionalOptions

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| enableCustomEnv | boolean | 否 | enableCustomEnv |
| continueWhenFailed | boolean | 否 | continueWhenFailed |
| manualRetry | boolean | 否 | manualRetry |
| pauseBeforeExec | boolean | 否 | pauseBeforeExec |
| retryCount | integer | 否 | retryCount |
| manualSkip | boolean | 否 | manualSkip |
| timeout | integer | 否 | timeout |
| customVariables | List&lt;[NameAndValue](operation-pause-plugin.md)&gt; | 否 | customVariables |
| otherTask | string | 否 | otherTask |
| customEnv | List&lt;[NameAndValue](operation-pause-plugin.md)&gt; | 否 | customEnv |
| retryWhenFailed | boolean | 否 | retryWhenFailed |
| enable | boolean | 否 | enable |
| subscriptionPauseUser | string | 否 | subscriptionPauseUser |
| customCondition | string | 否 | customCondition |
| runCondition | ENUM\(PRE\_TASK\_SUCCESS, PRE\_TASK\_FAILED\_BUT\_CANCEL, PRE\_TASK\_FAILED\_EVEN\_CANCEL, PRE\_TASK\_FAILED\_ONLY, OTHER\_TASK\_RUNNING, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, PARENT\_TASK\_CANCELED\_OR\_TIMEOUT, PARENT\_TASK\_FINISH, \) | 否 | runCondition |
| elementPostInfo | [元素post信息](operation-pause-plugin.md) | 否 | elementPostInfo |

## NameAndValue

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| value | string | 否 | value |
| key | string | 否 | key |

## 元素post信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| parentElementId | string | 否 | 父元素ID |
| postCondition | string | 否 | 执行条件 |
| parentElementJobIndex | integer | 否 | 父元素在job中的位置 |
| parentElementName | string | 否 | 父元素名称 |
| postEntryParam | string | 否 | 入口参数 |

## 数据返回包装模型Boolean

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | boolean | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

