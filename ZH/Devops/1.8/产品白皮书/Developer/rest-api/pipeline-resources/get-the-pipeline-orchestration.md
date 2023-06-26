# 获取流水线编排

### 请求方法/请求路径

#### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}

### 资源描述

#### 获取流水线编排

### 输入参数说明

#### Query参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| channelCode | string | 否 | channel |  |

#### Path参数

| 参数名称 | 参数类型 | 必须 | 参数说明 | 默认值 |
| :--- | :--- | :--- | :--- | :--- |
| projectId | string | 是 | 项目ID |  |
| pipelineId | string | 是 | 流水线ID |  |

#### 响应

| HTTP代码 | 说明 | 参数类型 |
| :--- | :--- | :--- |
| 200 | successful operation | [数据返回包装模型流水线模型-创建信息](get-the-pipeline-orchestration.md) |

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
    "latestVersion" : 0,
    "pipelineCreator" : "String",
    "name" : "String",
    "stages" : [ {
      "canRetry" : true,
      "checkIn" : {
        "ruleIds" : "string",
        "reviewParams" : [ {
          "valueType" : "ENUM",
          "options" : [ {
            "value" : "String",
            "key" : "String"
          } ],
          "chineseName" : "String",
          "value" : {
            "string" : "string"
          },
          "key" : "String",
          "required" : true,
          "desc" : "String"
        } ],
        "manualTrigger" : true,
        "checkTimes" : 0,
        "reviewDesc" : "String",
        "reviewGroups" : [ {
          "name" : "String",
          "id" : "String",
          "suggest" : "String",
          "params" : [ {
            "valueType" : "ENUM",
            "options" : [ {
              "value" : "String",
              "key" : "String"
            } ],
            "chineseName" : "String",
            "value" : {
              "string" : "string"
            },
            "key" : "String",
            "required" : true,
            "desc" : "String"
          } ],
          "reviewers" : "string",
          "operator" : "String",
          "reviewTime" : 0,
          "status" : "String"
        } ],
        "timeout" : 0,
        "status" : "String"
      },
      "customBuildEnv" : {
        "string" : "string"
      },
      "finally" : true,
      "name" : "String",
      "containers" : [ {
        "canRetry" : true,
        "elementElapsed" : 0,
        "startEpoch" : 0,
        "executeCount" : 0,
        "jobId" : "String",
        "containPostTaskFlag" : true,
        "systemElapsed" : 0,
        "elements" : [ {
          "canRetry" : true,
          "errorType" : "String",
          "errorCode" : 0,
          "canSkip" : true,
          "startEpoch" : 0,
          "version" : "String",
          "executeCount" : 0,
          "templateModify" : true,
          "elementEnable" : true,
          "errorMsg" : "String",
          "elapsed" : 0,
          "atomCode" : "String",
          "additionalOptions" : {
            "enableCustomEnv" : true,
            "continueWhenFailed" : true,
            "manualRetry" : true,
            "pauseBeforeExec" : true,
            "retryCount" : 0,
            "manualSkip" : true,
            "timeout" : 0,
            "customVariables" : [ {
              "value" : "String",
              "key" : "String"
            } ],
            "otherTask" : "String",
            "customEnv" : [ {
              "value" : "String",
              "key" : "String"
            } ],
            "retryWhenFailed" : true,
            "enable" : true,
            "subscriptionPauseUser" : "String",
            "customCondition" : "String",
            "runCondition" : "ENUM",
            "elementPostInfo" : {
              "parentElementId" : "String",
              "postCondition" : "String",
              "parentElementJobIndex" : 0,
              "parentElementName" : "String",
              "postEntryParam" : "String"
            }
          },
          "taskAtom" : "String",
          "name" : "String",
          "id" : "String",
          "classType" : "String",
          "status" : "String"
        } ],
        "name" : "String",
        "id" : "String",
        "startVMStatus" : "String",
        "containerId" : "String",
        "classType" : "String",
        "status" : "String"
      } ],
      "id" : "String",
      "stageControlOption" : {
        "triggered" : true,
        "reviewParams" : [ {
          "valueType" : "ENUM",
          "options" : [ {
            "value" : "String",
            "key" : "String"
          } ],
          "chineseName" : "String",
          "value" : {
            "string" : "string"
          },
          "key" : "String",
          "required" : true,
          "desc" : "String"
        } ],
        "manualTrigger" : true,
        "enable" : true,
        "customCondition" : "String",
        "triggerUsers" : "string",
        "reviewDesc" : "String",
        "runCondition" : "ENUM",
        "timeout" : 0,
        "customVariables" : [ {
          "value" : "String",
          "key" : "String"
        } ]
      },
      "checkOut" : {
        "ruleIds" : "string",
        "reviewParams" : [ {
          "valueType" : "ENUM",
          "options" : [ {
            "value" : "String",
            "key" : "String"
          } ],
          "chineseName" : "String",
          "value" : {
            "string" : "string"
          },
          "key" : "String",
          "required" : true,
          "desc" : "String"
        } ],
        "manualTrigger" : true,
        "checkTimes" : 0,
        "reviewDesc" : "String",
        "reviewGroups" : [ {
          "name" : "String",
          "id" : "String",
          "suggest" : "String",
          "params" : [ {
            "valueType" : "ENUM",
            "options" : [ {
              "value" : "String",
              "key" : "String"
            } ],
            "chineseName" : "String",
            "value" : {
              "string" : "string"
            },
            "key" : "String",
            "required" : true,
            "desc" : "String"
          } ],
          "reviewers" : "string",
          "operator" : "String",
          "reviewTime" : 0,
          "status" : "String"
        } ],
        "timeout" : 0,
        "status" : "String"
      },
      "fastKill" : true
    } ],
    "templateId" : "String",
    "srcTemplateId" : "String",
    "tips" : "String",
    "desc" : "String",
    "labels" : "string",
    "instanceFromTemplate" : true
  },
  "message" : "String",
  "status" : 0
}
```

## 数据返回包装模型流水线模型-创建信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| data | [流水线模型-创建信息](get-the-pipeline-orchestration.md) | 否 | 数据 |
| message | string | 否 | 错误信息 |
| status | integer | 是 | 状态码 |

## 流水线模型-创建信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| latestVersion | integer | 否 | 提交时流水线最新版本号 |
| pipelineCreator | string | 否 | 创建人 |
| name | string | 是 | 名称 |
| stages | List&lt;[流水线模型-阶段](get-the-pipeline-orchestration.md)&gt; | 是 | 阶段集合 |
| templateId | string | 否 | 模板ID |
| srcTemplateId | string | 否 | 源模版ID |
| tips | string | 否 | 提示 |
| desc | string | 否 | 描述 |
| labels | List | 否 | 标签 |
| instanceFromTemplate | boolean | 否 | 是否从模板中实例化出来的 |

## 流水线模型-阶段

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| canRetry | boolean | 否 | 当前Stage是否能重试 |
| checkIn | [StagePauseCheck](get-the-pipeline-orchestration.md) | 否 | 当前Stage是否能重试 |
| customBuildEnv | object | 否 | 用户自定义环境变量 |
| finally | boolean | 否 | 标识是否为FinallyStage，每个Model只能包含一个FinallyStage，并且处于最后位置 |
| name | string | 是 | 阶段名称 |
| containers | List&lt;[流水线模型-多态基类](get-the-pipeline-orchestration.md)&gt; | 是 | 容器集合 |
| id | string | 否 | 阶段ID |
| stageControlOption | [StageControlOption](get-the-pipeline-orchestration.md) | 是 | 流程控制选项 |
| checkOut | [StagePauseCheck](get-the-pipeline-orchestration.md) | 否 | 当前Stage是否能重试 |
| fastKill | boolean | 否 | 是否启用容器失败快速终止阶段 |

## StagePauseCheck

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| ruleIds | List | 否 | ruleIds |
| reviewParams | List&lt;[人工审核-自定义参数](get-the-pipeline-orchestration.md)&gt; | 否 | reviewParams |
| manualTrigger | boolean | 否 | manualTrigger |
| checkTimes | integer | 否 | checkTimes |
| reviewDesc | string | 否 | reviewDesc |
| reviewGroups | List&lt;[Stage审核组信息](get-the-pipeline-orchestration.md)&gt; | 否 | reviewGroups |
| timeout | integer | 否 | timeout |
| status | string | 否 | status |

## 人工审核-自定义参数

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| valueType | ENUM\(STRING, TEXTAREA, BOOLEAN, ENUM, MULTIPLE, \) | 否 | 参数类型 |
| options | List&lt;[人工审核-自定义参数-下拉框列表剑](get-the-pipeline-orchestration.md)&gt; | 否 | 下拉框列表 |
| chineseName | string | 否 | 中文名称 |
| value | object | 是 | 参数内容 |
| key | string | 是 | 参数名 |
| required | boolean | 是 | 是否必填 |
| desc | string | 否 | 参数描述 |

## 人工审核-自定义参数-下拉框列表剑

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| value | string | 是 | 参数内容 |
| key | string | 是 | 参数名 |

## Stage审核组信息

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 审核组名称 |
| id | string | 否 | 审核组ID\(后台生成\) |
| suggest | string | 否 | 审核建议 |
| params | List&lt;[人工审核-自定义参数](get-the-pipeline-orchestration.md)&gt; | 否 | 审核传入变量 |
| reviewers | List | 是 | 审核人员 |
| operator | string | 否 | 审核操作人 |
| reviewTime | integer | 否 | 审核操作时间 |
| status | string | 否 | 审核结果（枚举） |

## 流水线模型-多态基类

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| canRetry | boolean | 否 | canRetry |
| elementElapsed | integer | 否 | elementElapsed |
| startEpoch | integer | 否 | startEpoch |
| executeCount | integer | 否 | executeCount |
| jobId | string | 否 | jobId |
| containPostTaskFlag | boolean | 否 | containPostTaskFlag |
| systemElapsed | integer | 否 | systemElapsed |
| elements | List&lt;[Element](get-the-pipeline-orchestration.md)&gt; | 否 | elements |
| name | string | 否 | name |
| id | string | 否 | id |
| startVMStatus | string | 否 | startVMStatus |
| containerId | string | 否 | containerId |
| classType | string | 否 | classType |
| status | string | 否 | status |

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
| additionalOptions | [ElementAdditionalOptions](get-the-pipeline-orchestration.md) | 否 | additionalOptions |
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
| customVariables | List&lt;[NameAndValue](get-the-pipeline-orchestration.md)&gt; | 否 | customVariables |
| otherTask | string | 否 | otherTask |
| customEnv | List&lt;[NameAndValue](get-the-pipeline-orchestration.md)&gt; | 否 | customEnv |
| retryWhenFailed | boolean | 否 | retryWhenFailed |
| enable | boolean | 否 | enable |
| subscriptionPauseUser | string | 否 | subscriptionPauseUser |
| customCondition | string | 否 | customCondition |
| runCondition | ENUM\(PRE\_TASK\_SUCCESS, PRE\_TASK\_FAILED\_BUT\_CANCEL, PRE\_TASK\_FAILED\_EVEN\_CANCEL, PRE\_TASK\_FAILED\_ONLY, OTHER\_TASK\_RUNNING, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, PARENT\_TASK\_CANCELED\_OR\_TIMEOUT, PARENT\_TASK\_FINISH, \) | 否 | runCondition |
| elementPostInfo | [元素post信息](get-the-pipeline-orchestration.md) | 否 | elementPostInfo |

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

## StageControlOption

| 参数名称 | 参数类型 | 必须 | 参数说明 |
| :--- | :--- | :--- | :--- |
| triggered | boolean | 否 | triggered |
| reviewParams | List&lt;[人工审核-自定义参数](get-the-pipeline-orchestration.md)&gt; | 否 | reviewParams |
| manualTrigger | boolean | 否 | manualTrigger |
| enable | boolean | 否 | enable |
| customCondition | string | 否 | customCondition |
| triggerUsers | List | 否 | triggerUsers |
| reviewDesc | string | 否 | reviewDesc |
| runCondition | ENUM\(AFTER\_LAST\_FINISHED, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, \) | 否 | runCondition |
| timeout | integer | 否 | timeout |
| customVariables | List&lt;[NameAndValue](get-the-pipeline-orchestration.md)&gt; | 否 | customVariables |

