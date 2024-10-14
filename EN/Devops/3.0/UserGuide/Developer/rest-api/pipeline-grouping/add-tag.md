 # Append label 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelineGroups/labels 

 ### Resource Description 

 #### Append label 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body | [PipelineLabelCreate](add-tag.md) |Yes| Pipeline Lable create Request|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](add-tag.md)| 

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

 ## PipelineLabelCreate 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | groupId | string |No|  groupId | 
 | name | string |No|  name | 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 