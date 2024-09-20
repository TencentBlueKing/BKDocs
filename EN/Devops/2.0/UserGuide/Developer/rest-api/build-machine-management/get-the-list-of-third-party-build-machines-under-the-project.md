 # Get the list of Self hosted agent under the project 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/environment/thirdPartAgent/nodeList 

 ### Resource Description 

 #### Get the list of Self hosted agent under the project 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Package model List Node information\(auth\)| 

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
    "pipelineRefCount" : 0, 
    "nodeHashId" : "String", 
    "displayName" : "String", 
    "ip" : "String", 
    "canEdit" : true, 
    "nodeStatus" : "String", 
    "nodeType" : "String", 
    "osName" : "String", 
    "agentStatus" : true, 
    "operator" : "String", 
    "canUse" : true, 
    "bakOperator" : "String", 
    "lastBuildTime" : "String", 
    "lastModifyUser" : "String", 
    "createTime" : "String", 
    "lastModifyTime" : "String", 
    "name" : "String", 
    "bizId" : 0, 
    "canDelete" : true, 
    "nodeId" : "String", 
    "createdUser" : "String", 
    "gateway" : "String", 
    "agentHashId" : "String" 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model List Node information\(auth\) 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; Node information\(auth\)&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Node information\(auth\) 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineRefCount | integer |No| Number of Pipeline Job references| 
 | nodeHashId | string |Yes| environment HashId| 
 | displayName | string |No| Display name| 
 | ip | string |Yes|  IP | 
 | canEdit | boolean |No| Can I edit| 
 | nodeStatus | string |Yes| nodeStatus| 
 | nodeType | string |Yes| nodeType| 
 | osName | string |No| The operating system| 
 | agentStatus | boolean |Yes| Agent status| 
 | operator | string |No| operator| 
 | canUse | boolean |No| Can I use| 
 | bakOperator | string |No| bkOperator| 
 | lastBuildTime | string |No| Number of Pipeline Job references| 
 | lastModifyUser | string |No| lastUpdater| 
 | createTime | string |No| create/importTime| 
 | lastModifyTime | string |No| lastModifyTime| 
 | name | string |Yes| Node Name| 
 | bizId | integer |No| Biz. Default: -1 means no business is Binding.| 
 | canDelete | boolean |No| Can it be delete| 
 | nodeId | string |Yes| node Id| 
 | createdUser | string |Yes| creator| 
 | gateway | string |No| Gateway region| 
 | agentHashId | string |No|  agent hash id | 