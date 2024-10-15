 # CopyPipeline orchestration 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/copy 

 ### Resource Description 

 #### CopyPipeline orchestration 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[Pipeline create Information](copy-pipeline-orchestration.md)| Yes| Pipeline COPY|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| Pipeline model|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Pipeline Model-ID](copy-pipeline-orchestration.md)| 

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
  "data" : { 
    "id" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Pipeline-COPY create Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | name | string |Yes| name| 
 | hasCollect | boolean |No| toCollect| 
 | desc | string |No| description| 
 | group | string |No| groupName| 

 ## Data Return Package model Pipeline Model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Pipeline model](copy-pipeline-orchestration.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Pipeline model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | id | string |Yes| pipelineId| 