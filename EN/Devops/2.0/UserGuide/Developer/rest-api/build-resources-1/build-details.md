 # BuildDetail 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/detail 

 ### Resource Description 

 #### BuildDetail 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | channelCode | string |No| Channel number, default to BS|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 
 | buildId | string |Yes| build ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model buildDetail Info](build-details.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  channelCode={channelCode}' \ 
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
  "data" : {
    "buildNum" : 0,
    "cancelUserId" : "String",
    "trigger" : "String",
    "userId" : "String",
    "pipelineId" : "String",
    "pipelineName" : "String",
    "latestVersion" : 0,
    "currentTimestamp" : 0,
    "curVersion" : 0,
    "startTime" : 0,
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
    "id" : "String",
    "endTime" : 0,
    "latestBuildNum" : 0,
    "status" : "String",
    "executeTime" : 0
  },
  "message" : "String",
  "status" : 0
}
```

 ## Data Return Package model buildDetail-Construction Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[buildDetail-build information](build-details.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## BuildDetail-Construction Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | buildNum | integer |Yes| buildNo| 
 | cancelUserId | string |No| user cancelBuild| 
 | trigger | string |Yes| Trigger Conditions| 
 | userId | string |Yes| startUser| 
 | pipelineId | string |Yes| pipelineId| 
 | pipelineName | string |Yes| pipelineName| 
 | latestVersion | integer |Yes| current The latest versionNum of Pipeline| 
 | currentTimestamp | integer |Yes| service Current Timestamp| 
 | curVersion | integer |Yes| pipelineVersion of this execute| 
 | startTime | integer |Yes|  Start time | 
 | model |[Pipeline model-create Information](build-details.md)| Yes|  Build Model | 
 | id | string |Yes| build ID| 
 | endTime | integer |No|  End time | 
 | latestBuildNum | integer |Yes| One latest build buildNo| 
 | status | string |Yes|  Build status | 
 | executeTime | integer |Yes| executionTime (excluding systemTime)| 

 ## Pipeline model-create Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | latestVersion | integer |No| The The latest versionNum of Pipeline when submit| 
 | pipelineCreator | string |No| creator| 
 | name | string |Yes| name| 
 | stages |List&lt; [Pipeline model](build-details.md)&gt;|Yes| Stage Collection| 
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
 | checkIn | [StagePauseCheck](build-details.md) |No| Can the current Stage be retry| 
 | customBuildEnv | object |No| user customEnv| 
 | finally | boolean |No| Identifies whether FinallyStage, each Model can contain only One FinallyStage, and is the last| 
 | name | string |Yes| Stage name| 
 | containers |List&lt; [Pipeline model-polymorphic base class](build-details.md)&gt;|Yes| container Collection| 
 | id | string |No| Stage ID| 
 | stageControlOption | [StageControlOption](build-details.md) |Yes| jobOption| 
 | checkOut | [StagePauseCheck](build-details.md) |No| Can the current Stage be retry| 
 | fastKill | boolean |No| Enable container failed fast terminate Stage| 

 ## StagePauseCheck 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | ruleIds | List |No|  ruleIds | 
 | reviewParams |List&lt; [Manual toCheck-stageReviewParams](build-details.md)&gt;|No|  reviewParams | 
 | manualTrigger | boolean |No|  manualTrigger | 
 | checkTimes | integer |No|  checkTimes | 
 | reviewDesc | string |No|  reviewDesc | 
 | reviewGroups |List&lt; [Stage toCheck Group Information](build-details.md)&gt;|No|  reviewGroups | 
 | timeout | integer |No|  timeout | 
 | status | string |No|  status | 

 ## Manual toCheck-stageReviewParams 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | valueType | ENUM\(STRING, TEXTAREA, BOOLEAN, ENUM, MULTIPLE, \) |No| Type| 
 | options |List&lt; [Manual toCheck-stageReviewParams-Drop-down Box List](build-details.md)&gt;|No| Drop-down box list| 
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
 | params |List&lt; [Manual toCheck-stageReviewParams](build-details.md)&gt;|No| toCheck Incoming var| 
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
 | elements |List&lt; [Element](build-details.md)&gt;|No|  elements | 
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
 | additionalOptions | [ElementAdditionalOptions](build-details.md) |No|  additionalOptions | 
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
 | customVariables |List&lt; [NameAndValue](build-details.md)&gt;|No|  customVariables | 
 | otherTask | string |No|  otherTask | 
 | customEnv |List&lt; [NameAndValue](build-details.md)&gt;|No|  customEnv | 
 | retryWhenFailed | boolean |No|  retryWhenFailed | 
 | enable | boolean |No|  enable | 
 | subscriptionPauseUser | string |No|  subscriptionPauseUser | 
 | customCondition | string |No|  customCondition | 
 | runCondition | ENUM\(PRE\_TASK\_SUCCESS, PRE\_TASK\_FAILED\_BUT\_CANCEL, PRE\_TASK\_FAILED\_EVEN\_CANCEL, PRE\_TASK\_FAILED\_ONLY, OTHER\_TASK\_RUNNING, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, PARENT\_TASK\_CANCELED\_OR\_TIMEOUT, PARENT\_TASK\_FINISH, \) |No|  runCondition | 
 | elementPostInfo |[element post information](build-details.md)| No|  elementPostInfo | 

 ## NameAndValue 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |No|  value | 
 | key | string |No|  key | 

 ## Element Post Information 

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
 | reviewParams |List&lt; [Manual toCheck-stageReviewParams](build-details.md)&gt;|No|  reviewParams | 
 | manualTrigger | boolean |No|  manualTrigger | 
 | enable | boolean |No|  enable | 
 | customCondition | string |No|  customCondition | 
 | triggerUsers | List |No|  triggerUsers | 
 | reviewDesc | string |No|  reviewDesc | 
 | runCondition | ENUM\(AFTER\_LAST\_FINISHED, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, \) |No|  runCondition | 
 | timeout | integer |No|  timeout | 
 | customVariables |List&lt; [NameAndValue](build-details.md)&gt;|No|  customVariables | 