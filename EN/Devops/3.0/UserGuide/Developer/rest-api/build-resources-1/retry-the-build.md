 # Retry build-Retry or skipFail Plugin 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/retry 

 ### Resource Description 

 #### Retry build-Retry or skipFail Plugin 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | taskId | string |No| Plugin ID to retry or SKIP, or StageId|| 
 | failedContainer | boolean |No| retry all failed jobs only|| 
 | skip | boolean |No| skipFail Plugin. If it is true, the taskId value needs to be passed (if the value is stageId, all failed plug-ins under Stage are skipped)|| 
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
 | 200 | successful operation |[data Return Wrapper model build Model-ID](retry-the-build.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]?  taskId={taskId}&amp;failedContainer={failedContainer}&amp;skip={skip}&amp;channelCode={channelCode}' \ 
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

 ## Data Return Package model build Model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[build model](retry-the-build.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Build model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | id | string |Yes| build ID| 