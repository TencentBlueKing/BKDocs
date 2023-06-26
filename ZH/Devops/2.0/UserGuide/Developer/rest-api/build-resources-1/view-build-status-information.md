# 查看构建状态信息

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/status

### 资源描述

#### 查看构建状态信息

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| channelCode | string | 否 | 渠道号，默认为BS |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |
| buildId | string | 是 | 构建ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型带构建变量的历史构建模型](view-build-status-information.md) |

#### 请求样例

```javascript
curl -X GET '[请替换为API地址栏请求地址]?channelCode={channelCode}' \
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
  "data" : {
    "buildNum" : 0,
    "buildNumAlias" : "String",
    "stageStatus" : [ {
      "name" : "String",
      "stageId" : "String"
    } ],
    "remark" : "String",
    "buildMsg" : "String",
    "startTime" : 0,
    "id" : "String",
    "recommendVersion" : "String",
    "retry" : true,
    "variables" : {
      "string" : "string"
    },
    "totalTime" : 0,
    "webHookType" : "String",
    "mobileStart" : true,
    "startType" : "String",
    "trigger" : "String",
    "userId" : "String",
    "deleteReason" : "String",
    "queueTime" : 0,
    "pipelineVersion" : 0,
    "buildParameters" : [ {
      "valueType" : "ENUM",
      "readOnly" : true,
      "value" : {
        "string" : "string"
      },
      "key" : "String"
    } ],
    "material" : [ {
      "newCommitId" : "String",
      "aliasName" : "String",
      "commitTimes" : 0,
      "branchName" : "String",
      "url" : "String",
      "newCommitComment" : "String"
    } ],
    "currentTimestamp" : 0,
    "artifactList" : [ {
      "fullPath" : "String",
      "modifiedTime" : 0,
      "appVersion" : "String",
      "shortUrl" : "String",
      "downloadUrl" : "String",
      "fullName" : "String",
      "path" : "String",
      "folder" : true,
      "size" : 0,
      "name" : "String",
      "artifactoryType" : "ENUM",
      "properties" : [ {
        "value" : "String",
        "key" : "String"
      } ],
      "md5" : "String"
    } ],
    "endTime" : 0,
    "webhookInfo" : {
      "webhookBranch" : "String",
      "webhookEventType" : "String",
      "webhookMessage" : "String",
      "webhookMergeCommitSha" : "String",
      "webhookRepoUrl" : "String",
      "webhookCommitId" : "String",
      "webhookType" : "String"
    },
    "errorInfoList" : [ {
      "atomCode" : "String",
      "errorType" : 0,
      "errorCode" : 0,
      "taskName" : "String",
      "taskId" : "String",
      "errorMsg" : "String"
    } ],
    "status" : "String",
    "executeTime" : 0
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型带构建变量的历史构建模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [带构建变量的历史构建模型](view-build-status-information.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 带构建变量的历史构建模型

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| buildNum | integer | 是 | 构建号 |
| buildNumAlias | string | 否 | 自定义构建版本号 |
| stageStatus | List&lt;[历史构建阶段状态](view-build-status-information.md)&gt; | 是 | 各阶段状态 |
| remark | string | 否 | 备注 |
| buildMsg | string | 否 | 构建信息 |
| startTime | integer | 是 | 开始时间 |
| id | string | 是 | 构建ID |
| recommendVersion | string | 否 | 推荐版本号 |
| retry | boolean | 否 | 是否重试 |
| variables | object | 是 | 构建变量集合 |
| totalTime | integer | 否 | 总耗时\(秒\) |
| webHookType | string | 否 | WebHookType |
| mobileStart | boolean | 否 | mobileStart |
| startType | string | 否 | 启动类型\(新\) |
| trigger | string | 是 | 触发条件 |
| userId | string | 是 | 启动用户 |
| deleteReason | string | 是 | 结束原因 |
| queueTime | integer | 否 | 排队于 |
| pipelineVersion | integer | 是 | 编排文件版本号 |
| buildParameters | List&lt;[构建模型-构建参数](view-build-status-information.md)&gt; | 否 | 启动参数 |
| material | List&lt;[PipelineBuildMaterial](view-build-status-information.md)&gt; | 否 | 原材料 |
| currentTimestamp | integer | 是 | 服务器当前时间戳 |
| artifactList | List&lt;[版本仓库-文件信息](view-build-status-information.md)&gt; | 否 | 构件列表 |
| endTime | integer | 是 | 结束时间 |
| webhookInfo | [WebhookInfo](view-build-status-information.md) | 否 | webhookInfo |
| errorInfoList | List&lt;[插件错误信息](view-build-status-information.md)&gt; | 否 | 流水线任务执行错误 |
| status | string | 是 | 状态 |
| executeTime | integer | 否 | 运行耗时\(秒，不包括人工审核时间\) |

## 历史构建阶段状态

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 阶段名称 |
| stageId | string | 是 | 阶段ID |

## 构建模型-构建参数

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| valueType | ENUM\(STRING, TEXTAREA, ENUM, DATE, LONG, BOOLEAN, SVN\_TAG, GIT\_REF, MULTIPLE, CODE\_LIB, CONTAINER\_TYPE, ARTIFACTORY, SUB\_PIPELINE, CUSTOM\_FILE, PASSWORD, TEMPORARY, \) | 否 | 元素值类型 |
| readOnly | boolean | 否 | 是否只读 |
| value | object | 是 | 元素值名称-显示用 |
| key | string | 是 | 元素值ID-标识符 |

## PipelineBuildMaterial

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| newCommitId | string | 否 | newCommitId |
| aliasName | string | 否 | aliasName |
| commitTimes | integer | 否 | commitTimes |
| branchName | string | 否 | branchName |
| url | string | 否 | url |
| newCommitComment | string | 否 | newCommitComment |

## 版本仓库-文件信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| fullPath | string | 是 | 文件全路径 |
| modifiedTime | integer | 是 | 更新时间 |
| appVersion | string | 是 | app版本 |
| shortUrl | string | 是 | 下载短链接 |
| downloadUrl | string | 否 | 下载链接 |
| fullName | string | 是 | 文件全名 |
| path | string | 是 | 文件路径 |
| folder | boolean | 是 | 是否文件夹 |
| size | integer | 是 | 文件大小\(byte\) |
| name | string | 是 | 文件名 |
| artifactoryType | ENUM\(PIPELINE, CUSTOM\_DIR, \) | 是 | 仓库类型 |
| properties | List&lt;[版本仓库-元数据](view-build-status-information.md)&gt; | 是 | 元数据 |
| md5 | string | 否 | MD5 |

## 版本仓库-元数据

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| value | string | 是 | 元数据值 |
| key | string | 是 | 元数据键 |

## WebhookInfo

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| webhookBranch | string | 否 | webhookBranch |
| webhookEventType | string | 否 | webhookEventType |
| webhookMessage | string | 否 | webhookMessage |
| webhookMergeCommitSha | string | 否 | webhookMergeCommitSha |
| webhookRepoUrl | string | 否 | webhookRepoUrl |
| webhookCommitId | string | 否 | webhookCommitId |
| webhookType | string | 否 | webhookType |

## 插件错误信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| atomCode | string | 否 | 插件编号 |
| errorType | integer | 否 | 错误类型 |
| errorCode | integer | 是 | 错误码 |
| taskName | string | 否 | 插件名称 |
| taskId | string | 否 | 插件ID |
| errorMsg | string | 否 | 错误信息 |

