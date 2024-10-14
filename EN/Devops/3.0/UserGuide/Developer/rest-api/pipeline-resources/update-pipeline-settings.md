 # updatePipelineJson Set 

 ### Method/Path 

 #### PUT  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/setting\_update 

 ### Resource Description 

 #### updatePipelineJson Set 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body | [PipelineSetting](update-pipeline-settings.md) |Yes| Pipeline Set|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return wrapper model Boolean](update-pipeline-settings.md)| 

 #### Request Sample 

 ```javascript 
 curl -X PUT '[Replace with API Address bar Request Url]' \ 
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

 ## PipelineSetting 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | successSubscription |[Set-Subscribe to Messages](update-pipeline-settings.md)| No|  successSubscription | 
 | runLockType | ENUM\(MULTIPLE, SINGLE, SINGLE\_LOCK, LOCK, \) |No|  runLockType | 
 | maxPipelineResNum | integer |No|  maxPipelineResNum | 
 | version | integer |No|  version | 
 | pipelineId | string |No|  pipelineId | 
 | labels | List |No|  labels | 
 | pipelineName | string |No|  pipelineName | 
 | maxConRunningQueueSize | integer |No|  maxConRunningQueueSize | 
 | maxQueueSize | integer |No|  maxQueueSize | 
 | hasPermission | boolean |No|  hasPermission | 
 | waitQueueTimeMinute | integer |No|  waitQueueTimeMinute | 
 | failSubscription |[Set-Subscribe to Messages](update-pipeline-settings.md)| No|  failSubscription | 
 | buildNumRule | string |No|  buildNumRule | 
 | projectId | string |No|  projectId | 
 | desc | string |No|  desc | 

 ## Set-Subscribe to Messages 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | types | List |Yes| noticeType\(email, rtx\)| 
 | wechatGroupMarkdownFlag | boolean |No| WeCom group notification to Markdown format switch| 
 | groups | List |No| group| 
 | detailFlag | boolean |No| Notification of Pipeline detail connection switch| 
 | users | string |No| Notify personnel| 
 | wechatGroupFlag | boolean |No| WeCom group notification switch| 
 | content | string |No| customize noticeContent| 
 | wechatGroup | string |No| WeCom group notification group ID| 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 