 # Get pipelineId+ auto-increment id under the project 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/permission/move/projects/{projectCode}/pipelineIds/list 

 ### Resource Description 

 #### Obtain pipelineId+ auto-increment ID under the project 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectCode | string |Yes| project Code|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Packaging model ListPipelineIdInfo](get-the-pipelineid-and-auto-increment-id-under-the-project.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]' \ 
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
    "id" : 0, 
    "pipelineId" : "String" 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model ListPipelineIdInfo 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; [PipelineIdInfo](get-the-pipelineid-and-auto-increment-id-under-the-project.md)&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## PipelineIdInfo 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | id | integer |No|  id | 
 | pipelineId | string |No|  pipelineId | 