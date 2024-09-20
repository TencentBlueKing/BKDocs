 # Get all group information 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelineGroups/groups 

 ### Resource Description 

 #### Get all group information 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model ListPipelineGroup](get-all-group-information.md)| 

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
    "createTime" : 0, 
    "name" : "String", 
    "updateUser" : "String", 
    "updateTime" : 0, 
    "createUser" : "String", 
    "id" : "String", 
    "projectId" : "String", 
    "labels" : [ { 
      "createTime" : 0, 
      "groupId" : "String", 
      "name" : "String", 
      "updateUser" : "String", 
      "uptimeTime" : 0, 
      "createUser" : "String", 
      "id" : "String" 
    } ] 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model ListPipelineGroup 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; [PipelineGroup](get-all-group-information.md)&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## PipelineGroup 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | createTime | integer |No|  createTime | 
 | name | string |No|  name | 
 | updateUser | string |No|  updateUser | 
 | updateTime | integer |No|  updateTime | 
 | createUser | string |No|  createUser | 
 | id | string |No|  id | 
 | projectId | string |No|  projectId | 
 | labels |List&lt; [PipelineLabel](get-all-group-information.md)&gt;|No|  labels | 

 ## PipelineLabel 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | createTime | integer |No|  createTime | 
 | groupId | string |No|  groupId | 
 | name | string |No|  name | 
 | updateUser | string |No|  updateUser | 
 | uptimeTime | integer |No|  uptimeTime | 
 | createUser | string |No|  createUser | 
 | id | string |No|  id | 