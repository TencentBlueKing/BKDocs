 #append specified user to specified project userGroup 

 ###Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/createUser 

 ### Resource Description 

 #### append specified user to specified project userGroup 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body | [ProjectCreateUserInfo](add-the-specified-user-to-the-specified-project-user-group.md) |Yes| append information|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](add-the-specified-user-to-the-specified-project-user-group.md)| 

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

 ## ProjectCreateUserInfo 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | createUserId | string |No| Operation user| 
 | roleId | integer |No| Role Id| 
 | userIds | List |No| target user id| 
 | roleName | string |No| Role name| 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 