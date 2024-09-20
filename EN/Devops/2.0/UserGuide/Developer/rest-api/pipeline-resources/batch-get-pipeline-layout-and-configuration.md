 # Batch acquisition Pipeline orchestration and setting 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/batchGet 

 ### Resource Description 

 #### Scheduling and setting of Batch Acquisition Pipeline 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | channelCode | string |No|  channel || 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body | array |Yes| pipelineId List|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model List Pipeline Model-List Info](batch-get-pipeline-layout-and-configuration.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]?  channelCode={channelCode}' \ 
 -H 'X-DEVOPS-UID:xxx' 
 ``` 

 #### HEADER Sample 

 ```javascript 
 accept: application/json 
 Content-Type: application/json 
 X-DEVOPS-UID:xxx 
 ``` 

 ### Return Sample-200 

```javascript
{
  "data" : [ {
    "latestBuildUserId" : "String",
    "creator" : "String",
    "latestBuildEndTime" : 0,
    "buildCount" : 0,
    "latestBuildTaskName" : "String",
    "groupLabel" : [ {
      "groupName" : "String",
      "labelName" : "string"
    } ],
    "updateTime" : 0,
    "pipelineDesc" : "String",
    "pipelineId" : "String",
    "latestBuildStartTime" : 0,
    "pipelineName" : "String",
    "canManualStartup" : true,
    "pipelineVersion" : 0,
    "taskCount" : 0,
    "latestBuildId" : "String",
    "createTime" : 0,
    "runningBuildCount" : 0,
    "latestBuildStatus" : "ENUM",
    "lock" : true,
    "model" : {
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
    "latestBuildNum" : 0,
    "projectId" : "String"
  } ],
  "message" : "String",
  "status" : 0
}
```

 ## Data Return Package model List Pipeline Model-List Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; [Pipeline model info](batch-get-pipeline-layout-and-configuration.md)&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Pipeline model-List Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | latestBuildUserId | string |No| Last executor ID| 
 | creator | string |No| Pipeline creator| 
 | latestBuildEndTime | integer |No| Last build End Time| 
 | buildCount | integer |Yes| Number of build| 
 | latestBuildTaskName | string |No| Last Task Name| 
 | groupLabel |List&lt; [PipelineGroupLabels](batch-get-pipeline-layout-and-configuration.md)&gt;|No| Pipeline group and label| 
 | updateTime | integer |Yes| Deploy time| 
 | pipelineDesc | string |No| Pipeline description| 
 | pipelineId | string |Yes| pipelineId| 
 | latestBuildStartTime | integer |No| Last build Start Time| 
 | pipelineName | string |Yes| pipelineName| 
 | canManualStartup | boolean |Yes| Can it be Start Up manually| 
 | pipelineVersion | integer |Yes| file versionNum| 
 | taskCount | integer |Yes| Quantity of Pipeline Task| 
 | latestBuildId | string |No| Last build Instance ID| 
 | createTime | integer |Yes| Pipeline creationTime| 
 | runningBuildCount | integer |Yes| Count of current Run build| 
 | latestBuildStatus | ENUM\(SUCCEED, FAILED, CANCELED, RUNNING, TERMINATE, REVIEWING, REVIEW\_ABORT, REVIEW\_PROCESSED, HEARTBEAT\_TIMEOUT, PREPARE\_ENV, UNEXEC, SKIP, QUALITY\_CHECK\_FAIL, QUEUE, LOOP\_WAITING, CALL\_WAITING, TRY\_FINALLY, QUEUE\_TIMEOUT, EXEC\_TIMEOUT, QUEUE\_CACHE, RETRY, PAUSE, STAGE\_SUCCESS, QUOTA\_FAILED, DEPENDENT\_WAITING, UNKNOWN, \) |No| Last build status| 
 | lock | boolean |No| Run lock| 
 | model |[Pipeline model-create Information](batch-get-pipeline-layout-and-configuration.md)| No| Arrangement detail| 
 | latestBuildNum | integer |No| Last build versionNum| 
 | projectId | string |Yes| Project ID| 

 ## PipelineGroupLabels 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | groupName | string |No|  groupName | 
 | labelName | List |No|  labelName | 

 ## Pipeline model-create Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | latestVersion | integer |No| The The latest versionNum of Pipeline when submit| 
 | pipelineCreator | string |No| creator| 
 | name | string |Yes| name| 
 | stages |List&lt; [Pipeline model](batch-get-pipeline-layout-and-configuration.md)&gt;|Yes| Stage Collection| 
 | templateId | string |No| Template ID| 
 | srcTemplateId | string |No| Source Template ID| 
 | tips | string |No| hint| 
 | desc | string |No| description| 
 | labels | List |No| label| 
 | instanceFromTemplate | boolean |No| Is it instantiate from the template| 

 ## Pipeline model-Stage 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | canRetry | boolean |No| Can the current Stage be retry| 
 | checkIn | [StagePauseCheck](batch-get-pipeline-layout-and-configuration.md) |No| Can the current Stage be retry| 
 | customBuildEnv | object |No| user customEnv| 
 | finally | boolean |No| Identifies whether FinallyStage, each Model can contain only One FinallyStage, and is the last| 
 | name | string |Yes| Stage name| 
 | containers |List&lt; [Pipeline base class](batch-get-pipeline-layout-and-configuration.md)&gt;|Yes| container Collection| 
 | id | string |No| Stage ID| 
 | stageControlOption | [StageControlOption](batch-get-pipeline-layout-and-configuration.md) |Yes| jobOption| 
 | checkOut | [StagePauseCheck](batch-get-pipeline-layout-and-configuration.md) |No| Can the current Stage be retry| 
 | fastKill | boolean |No| Enable container failed fast terminate Stage| 

 ## StagePauseCheck 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | ruleIds | List |No|  ruleIds | 
 | reviewParams |List&lt; [Manual toCheck-stageReviewParams](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  reviewParams | 
 | manualTrigger | boolean |No|  manualTrigger | 
 | checkTimes | integer |No|  checkTimes | 
 | reviewDesc | string |No|  reviewDesc | 
 | reviewGroups |List&lt; [Stage toCheck group information](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  reviewGroups | 
 | timeout | integer |No|  timeout | 
 | status | string |No|  status | 
 ## Manual toCheck-stageReviewParams 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | valueType | ENUM\(STRING, TEXTAREA, BOOLEAN, ENUM, MULTIPLE, \) |No| Type| 
 | options |List&lt; [Manual toCheck-stageReviewParams-Drop-down Box List](batch-get-pipeline-layout-and-configuration.md)&gt;|No| Drop-down box list| 
 | chineseName | string |No| chineseName| 
 | value | object |Yes| Parameter content| 
 | key | string |Yes| Name| 
 | required | boolean |Yes| required| 
 | desc | string |No| Description| 

 ## Manual toCheck-stageReviewParams-Drop-down Box List 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |Yes| Parameter content| 
 | key | string |Yes| Name| 

 ## Stage toCheck Group Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | name | string |Yes| toCheck Team name| 
 | id | string |No| toCheck Group ID\(Generate in background\)| 
 | suggest | string |No| toCheck recommendations| 
 | params |List&lt; [Manual toCheck-stageReviewParams](batch-get-pipeline-layout-and-configuration.md)&gt;|No| toCheck Incoming var| 
 | reviewers | List |Yes| toCheck| 
 | operator | string |No| toCheck operateUser| 
 | reviewTime | integer |No| toCheck operateTime| 
 | status | string |No| checkResult (Enumeration)| 

 ## Pipeline model-Polymorphic Base Class 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | canRetry | boolean |No|  canRetry | 
 | elementElapsed | integer |No|  elementElapsed | 
 | startEpoch | integer |No|  startEpoch | 
 | executeCount | integer |No|  executeCount | 
 | jobId | string |No|  jobId | 
 | containPostTaskFlag | boolean |No|  containPostTaskFlag | 
 | systemElapsed | integer |No|  systemElapsed | 
 | elements |List&lt; [Element](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  elements | 
 | name | string |No|  name | 
 | id | string |No|  id | 
 | startVMStatus | string |No|  startVMStatus | 
 | containerId | string |No|  containerId | 
 | classType | string |No|  classType | 
 | status | string |No|  status | 

 ## Element 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | canRetry | boolean |No|  canRetry | 
 | errorType | string |No|  errorType | 
 | errorCode | integer |No|  errorCode | 
 | canSkip | boolean |No|  canSkip | 
 | startEpoch | integer |No|  startEpoch | 
 | version | string |No|  version | 
 | executeCount | integer |No|  executeCount | 
 | templateModify | boolean |No|  templateModify | 
 | elementEnable | boolean |No|  elementEnable | 
 | errorMsg | string |No|  errorMsg | 
 | elapsed | integer |No|  elapsed | 
 | atomCode | string |No|  atomCode | 
 | additionalOptions | [ElementAdditionalOptions](batch-get-pipeline-layout-and-configuration.md) |No|  additionalOptions | 
 | taskAtom | string |No|  taskAtom | 
 | name | string |No|  name | 
 | id | string |No|  id | 
 | classType | string |No|  classType | 
 | status | string |No|  status | 
 ## ElementAdditionalOptions 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | enableCustomEnv | boolean |No|  enableCustomEnv | 
 | continueWhenFailed | boolean |No|  continueWhenFailed | 
 | manualRetry | boolean |No|  manualRetry | 
 | pauseBeforeExec | boolean |No|  pauseBeforeExec | 
 | retryCount | integer |No|  retryCount | 
 | manualSkip | boolean |No|  manualSkip | 
 | timeout | integer |No|  timeout | 
 | customVariables |List&lt; [NameAndValue](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  customVariables | 
 | otherTask | string |No|  otherTask | 
 | customEnv |List&lt; [NameAndValue](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  customEnv | 
 | retryWhenFailed | boolean |No|  retryWhenFailed | 
 | enable | boolean |No|  enable | 
 | subscriptionPauseUser | string |No|  subscriptionPauseUser | 
 | customCondition | string |No|  customCondition | 
 | runCondition | ENUM\(PRE\_TASK\_SUCCESS, PRE\_TASK\_FAILED\_BUT\_CANCEL, PRE\_TASK\_FAILED\_EVEN\_CANCEL, PRE\_TASK\_FAILED\_ONLY, OTHER\_TASK\_RUNNING, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, PARENT\_TASK\_CANCELED\_OR\_TIMEOUT, PARENT\_TASK\_FINISH, \) |No|  runCondition | 
 | elementPostInfo |[element post information](batch-get-pipeline-layout-and-configuration.md)| No|  elementPostInfo | 

 ## NameAndValue 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |No|  value | 
 | key | string |No|  key | 

 ##Element Post Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | parentElementId | string |No| Parent Element ID| 
 | postCondition | string |No| execute condition| 
 | parentElementJobIndex | integer |No| The position of the parent element in the job| 
 | parentElementName | string |No| Parent Element name| 
 | postEntryParam | string |No| entry Parameter| 

 ## StageControlOption 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | triggered | boolean |No|  triggered | 
 | reviewParams |List&lt; [Manual toCheck-stageReviewParams](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  reviewParams | 
 | manualTrigger | boolean |No|  manualTrigger | 
 | enable | boolean |No|  enable | 
 | customCondition | string |No|  customCondition | 
 | triggerUsers | List |No|  triggerUsers | 
 | reviewDesc | string |No|  reviewDesc | 
 | runCondition | ENUM\(AFTER\_LAST\_FINISHED, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, \) |No|  runCondition | 
 | timeout | integer |No|  timeout | 
 | customVariables |List&lt; [NameAndValue](batch-get-pipeline-layout-and-configuration.md)&gt;|No|  customVariables | 

