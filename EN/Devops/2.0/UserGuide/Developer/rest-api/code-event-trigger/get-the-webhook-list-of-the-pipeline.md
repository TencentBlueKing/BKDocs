 # Get the list of webhooks for Pipeline 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/{projectId}/{pipelineId}/webhook 

 ### Resource Description 

 #### Get the list of webhooks of Pipeline 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | page | integer |No| Page|| 
 | pageSize | integer |No| size per page|| 

 | X-DEVOPS-UID | string |Yes|  userId || 
 | :--- | :--- | :--- | :--- | :--- | 


 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes||| 
 | pipelineId | string |Yes||| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Packaging model ListPipelineWebhook](get-the-webhook-list-of-the-pipeline.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  page={page}&amp;pageSize={pageSize}' \ 
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
    "repoType" : "ENUM", 
    "repoName" : "String", 
    "repositoryType" : "ENUM", 
    "id" : 0, 
    "projectName" : "String", 
    "projectId" : "String", 
    "repoHashId" : "String", 
    "taskId" : "String", 
    "pipelineId" : "String" 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model ListPipelineWebhook 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; [PipelineWebhook](get-the-webhook-list-of-the-pipeline.md)&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## PipelineWebhook 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | repoType | ENUM\(ID, NAME, \) |No|  repoType | 
 | repoName | string |No|  repoName | 
 | repositoryType | ENUM\(CODE\_SVN, CODE\_GIT, CODE\_GITLAB, GITHUB, CODE\_TGIT, \) |No|  repositoryType | 
 | id | integer |No|  id | 
 | projectName | string |No|  projectName | 
 | projectId | string |No|  projectId | 
 | repoHashId | string |No|  repoHashId | 
 | taskId | string |No|  taskId | 
 | pipelineId | string |No|  pipelineId | 