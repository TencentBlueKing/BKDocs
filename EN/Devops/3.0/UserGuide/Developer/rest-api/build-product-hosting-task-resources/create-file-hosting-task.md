 # Create a file hosting Task 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/artifactory/fileTask/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/create 

 ### Resource Description 

 #### Create a file hosting Task 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |create file Hosting Task Request| Yes|  taskId || 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 
 | pipelineId | string |Yes|  pipelineId || 
 | buildId | string |Yes|  buildId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Package model String| 

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
  "data" : "String", 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Create a file Hosting Task Request 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | path | string |Yes| file path| 
 | fileType | ENUM\(BK\_ARCHIVE, BK\_CUSTOM, BK\_REPORT, BK\_PLUGIN\_FE, \) |Yes| file type| 

 ## Data Return Package model String 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | string |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 