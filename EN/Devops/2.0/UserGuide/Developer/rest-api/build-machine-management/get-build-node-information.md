 # Get build node information (API extension) 

 ### Method/Path 

 #### GET /ms/openapi/api/apigw/v3/environment/projects/{projectId}/nodes/extListNodes 

 ### Resource description 

 #### Get build node information (extension API) 

 ### Input Parameter Description 

 #### Path Parameter 

 | VariableName Type Required Parameter Description Default Value 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation | data return Package model list Node information\(auth\)| 

 #### Request Example 

 ```Javascript 
 curl -X GET '[Replace API address bar request URL]' \ 
 -H 'X-DEVOPS-UID:xxx' 
 ``` 

 #### HEADER Example 

 ```Javascript 
 Accept: application/json 
 Content-Type: application/json 
 X-DEVOPS-UID:xxx 
 ``` 

 ### Return Example-200 

 ```Javascript 
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
    "operator" : "String 
    "canUse" : true, 
    "bakOperator" : "String", 
    "lastBuildTime" : "String 
    "lastModifyUser" : "String 
    "createTime" : "String", 
    "lastModifyTime" : "String 
    "name" : "String 
    "bizId" : 0, 
    "canDelete" : true, 
    "nodeId" : "String", 
    "createdUser" : "String", 
    "gateway" : "String 
    "agentHashId" : "String 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package Model List Node Information\(auth\) 

 | VariableName Type Required Parameter Description 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; Node information\(auth\)&gt;|No| data| 
 | message | string |no| error message| 
 | status | integer |Yes| status code| 

 ## Node Information\(auth\) 

 | VariableName Type Required Parameter Description 
 | :--- | :--- | :--- | :--- | 
 | pipelineRefCount | integer |No| Number of pipeline job references| 
 | nodeHashId | string |Yes| environment HashId| 
 | displayName | string |No| Display name| 
 | ip | string |Yes| IP | 
 | canEdit | boolean |No| Can I edit| 
 | nodeStatus | string |Yes| nodeStatus 
 | nodeType | string |Yes| nodeType| 
 | osName | string |No| The operating system| 
 | agentStatus | boolean |Yes| agent status 
 | operator | string |No| operator 
 | canUse | boolean |No| Can I use| 
 | bakOperator | string |No| bkOperator| 
 | lastBuildTime | string |No| Number of pipeline job references| 
 | lastModifyUser | string |No| lastUpdater| 
 | createTime | string |No| create/importTime| 
 | lastModifyTime | string |no| lastModifyTime| 
 | name | string |Yes| node name| 
 | bizId | integer |No| Biz. Default: -1 means no business is binding. 
 | canDelete | boolean |No| Can it be deleted? 
 | nodeId | string |Yes| node Id