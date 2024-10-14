 # Modify the group 

 ### Method/Path 

 #### PUT  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelineGroups/groups 

 ### Resource Description 

 #### Modify group 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body | [PipelineGroupUpdate](change-group.md) |Yes| Pipeline Lable group Update Request|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](change-group.md)| 

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

 ## PipelineGroupUpdate 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | name | string |No|  name | 
 | id | string |No|  id | 
 | projectId | string |No|  projectId | 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 