 # Get the list of environments that the user has auth to use 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/environment/projects/{projectId}/envs/listUsableServerEnvs 

 ### Resource Description 

 #### Get the list of environments that the user has auth to use 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Wrapper model List Stage\(auth\)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace API Address bar Request Url]' \ 
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
    "updatedTime" : 0, 
    "canEdit" : true, 
    "envVars" : [ { 
      "name" : "String", 
      "secure" : true, 
      "value" : "String" 
    } ], 
    "updatedUser" : "String", 
    "canUse" : true, 
    "envType" : "String", 
    "name" : "String", 
    "createdTime" : 0, 
    "nodeCount" : 0, 
    "canDelete" : true, 
    "envHashId" : "String", 
    "createdUser" : "String", 
    "desc" : "String" 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## data Return Package model List Stage\(auth\) 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; Stage\(auth\)&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Stage \(auth\) 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | updatedTime | integer |Yes| updateTime| 
 | canEdit | boolean |No| Can I edit| 
 | envVars |List&lt; Env Variables&gt;|Yes| Env Variables| 
 | updatedUser | string |Yes| Updater| 
 | canUse | boolean |No| Can I use| 
 | envType | string |Yes| envType (Develop Environment {DEV}| 
 | name | string |Yes| poolName| 
 | createdTime | integer |Yes| creationTime| 
 | nodeCount | integer |No| Number of nodes| 
 | canDelete | boolean |No| Can it be delete| 
 | envHashId | string |Yes| environment HashId| 
 | createdUser | string |Yes| creator| 
 | desc | string |Yes| envRemark| 

 ## Env Variables 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | name | string |Yes| Name| 
 | secure | boolean |Yes| Is it a Safety var| 
 | value | string |Yes| value| 