 # Query file Hosting Task Total 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/artifactory/fileTask/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/tasks/{taskId}/status 

 ### Resource Description 

 #### Query the status of file hosting tasks 

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
 | 200 | successful operation |data Return Wrapper Model artifactory-file Hosting Task information| 

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
  "data" : { 
    "path" : "String", 
    "ip" : "String", 
    "id" : "String", 
    "status" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package Model artifactory-file Hosting Task information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |artifactory-file Hosting Task information| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Artifactory-file Hosting Task information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | path | string |Yes| file absolute path| 
 | ip | string |Yes| IP of the machine where the file resides| 
 | id | string |Yes| Task ID| 
 | status | integer |Yes| Task Total| 