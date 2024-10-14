 # Clean up file hosting Task 

 ### Method/Path 

 #### PUT  /ms/openapi/api/apigw/v3/artifactory/fileTask/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/tasks/{taskId}/clear 

 ### Resource Description 

 #### Clearing file hosting Task 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 
 | pipelineId | string |Yes|  pipelineId || 
 | buildId | string |Yes|  buildId || 
 | taskId | string |Yes|  taskId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return wrapper model Boolean| 

 #### Request Sample 

 ```javascript 
 curl -X PUT '[Replace with the Request Url the API Address bar above]' \ 
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

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 