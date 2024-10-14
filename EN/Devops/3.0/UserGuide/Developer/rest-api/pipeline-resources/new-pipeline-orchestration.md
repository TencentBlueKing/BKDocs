 # AddPipeline orchestration 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines 

 ### Resource Description 

 #### Creating a addPipeline layout 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | channelCode | string |No| Channel number, default to BS|| 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[Pipeline model-create Information](new-pipeline-orchestration.md)| Yes| Pipeline model|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Pipeline Model-ID](new-pipeline-orchestration.md)| 

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
  "data" : { 
    "id" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Pipeline model-create Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | latestVersion | integer |No| The The latest versionNum of Pipeline when submit| 
 | pipelineCreator | string |No| creator| 
 | name | string |Yes| name| 
 | stages |List&lt; [Pipeline model](new-pipeline-orchestration.md)&gt;|Yes| Stage Collection| 
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
 | checkIn | [StagePauseCheck](new-pipeline-orchestration.md) |No| Can the current Stage be retry| 
 | customBuildEnv | object |No| user customEnv| 
 | finally | boolean |No| Identifies whether FinallyStage, each Model can contain only One FinallyStage, and is the last| 
 | name | string |Yes| Stage name| 
 | containers |List&lt; [Pipeline model base class](new-pipeline-orchestration.md)&gt;|Yes| container Collection| 
 | id | string |No| Stage ID| 
 | stageControlOption | [StageControlOption](new-pipeline-orchestration.md) |Yes| jobOption| 
 | checkOut | [StagePauseCheck](new-pipeline-orchestration.md) |No| Can the current Stage be retry| 
 | fastKill | boolean |No| Enable container failed fast terminate Stage| 

 ## StagePauseCheck 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | ruleIds | List |No|  ruleIds | 
 | reviewParams |List&lt; [Manual toCheck-stageReviewParams](new-pipeline-orchestration.md)&gt;|No|  reviewParams | 
 | manualTrigger | boolean |No|  manualTrigger | 
 | checkTimes | integer |No|  checkTimes | 
 | reviewDesc | string |No|  reviewDesc | 
 | reviewGroups |List&lt; [Stage toCheck Group Information](new-pipeline-orchestration.md)&gt;|No|  reviewGroups | 
 | timeout | integer |No|  timeout | 
 | status | string |No|  status | 

 ## Manual toCheck-stageReviewParams 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | valueType | ENUM\(STRING, TEXTAREA, BOOLEAN, ENUM, MULTIPLE, \) |No| Type| 
 | options |List&lt; [Manual toCheck-stageReviewParams-Drop-down Box List](new-pipeline-orchestration.md)&gt;|No| Drop-down box list| 
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
 | params |List&lt; [Manual toCheck-stageReviewParams](new-pipeline-orchestration.md)&gt;|No| toCheck Incoming var| 
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
 | elements |List&lt; [Element](new-pipeline-orchestration.md)&gt;|No|  elements | 
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
 | additionalOptions | [ElementAdditionalOptions](new-pipeline-orchestration.md) |No|  additionalOptions | 
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
 | customVariables |List&lt; [NameAndValue](new-pipeline-orchestration.md)&gt;|No|  customVariables | 
 | otherTask | string |No|  otherTask | 
 | customEnv |List&lt; [NameAndValue](new-pipeline-orchestration.md)&gt;|No|  customEnv | 
 | retryWhenFailed | boolean |No|  retryWhenFailed | 
 | enable | boolean |No|  enable | 
 | subscriptionPauseUser | string |No|  subscriptionPauseUser | 
 | customCondition | string |No|  customCondition | 
 | runCondition | ENUM\(PRE\_TASK\_SUCCESS, PRE\_TASK\_FAILED\_BUT\_CANCEL, PRE\_TASK\_FAILED\_EVEN\_CANCEL, PRE\_TASK\_FAILED\_ONLY, OTHER\_TASK\_RUNNING, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, PARENT\_TASK\_CANCELED\_OR\_TIMEOUT, PARENT\_TASK\_FINISH, \) |No|  runCondition | 
 | elementPostInfo |[element post information](new-pipeline-orchestration.md)| No|  elementPostInfo | 

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
 | reviewParams |List&lt; [Manual toCheck-stageReviewParams](new-pipeline-orchestration.md)&gt;|No|  reviewParams | 
 | manualTrigger | boolean |No|  manualTrigger | 
 | enable | boolean |No|  enable | 
 | customCondition | string |No|  customCondition | 
 | triggerUsers | List |No|  triggerUsers | 
 | reviewDesc | string |No|  reviewDesc | 
 | runCondition | ENUM\(AFTER\_LAST\_FINISHED, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, \) |No|  runCondition | 
 | timeout | integer |No|  timeout | 
 | customVariables |List&lt; [NameAndValue](new-pipeline-orchestration.md)&gt;|No|  customVariables | 

 ## Data Return Package model Pipeline Model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Pipeline model](new-pipeline-orchestration.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Pipeline model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | id | string |Yes| pipelineId| 

