 # Operation PAUSE Plugin 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/execute/pause 

 ### Resource Description 

 #### Operation PAUSE Plugin 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[Pipeline PAUSE Operation entity class](operation-pause-plugin.md)| No||| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 
 | buildId | string |Yes| build ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return wrapper model Boolean](operation-pause-plugin.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]' \ 
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
  "data" : true, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Pipeline PAUSE Operation Entity Class 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | continue | boolean |No|  continue | 
 | containerId | string |No| current containerId| 
 | taskId | string |No| Task ID| 
 | element | [Element](operation-pause-plugin.md) |No| Element information, if there is a var change in the Plugin, you need to give the changed element| 
 | stageId | string |No| current stageId| 

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
 | additionalOptions | [ElementAdditionalOptions](operation-pause-plugin.md) |No|  additionalOptions | 
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
 | customVariables |List&lt; [NameAndValue](operation-pause-plugin.md)&gt;|No|  customVariables | 
 | otherTask | string |No|  otherTask | 
 | customEnv |List&lt; [NameAndValue](operation-pause-plugin.md)&gt;|No|  customEnv | 
 | retryWhenFailed | boolean |No|  retryWhenFailed | 
 | enable | boolean |No|  enable | 
 | subscriptionPauseUser | string |No|  subscriptionPauseUser | 
 | customCondition | string |No|  customCondition | 
 | runCondition | ENUM\(PRE\_TASK\_SUCCESS, PRE\_TASK\_FAILED\_BUT\_CANCEL, PRE\_TASK\_FAILED\_EVEN\_CANCEL, PRE\_TASK\_FAILED\_ONLY, OTHER\_TASK\_RUNNING, CUSTOM\_VARIABLE\_MATCH, CUSTOM\_VARIABLE\_MATCH\_NOT\_RUN, CUSTOM\_CONDITION\_MATCH, PARENT\_TASK\_CANCELED\_OR\_TIMEOUT, PARENT\_TASK\_FINISH, \) |No|  runCondition | 
 | elementPostInfo |[element post information](operation-pause-plugin.md)| No|  elementPostInfo | 

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

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 