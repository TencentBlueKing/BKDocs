 # Get the list of webhook build log for Pipeline 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/{projectId}/{pipelineId}/webhook/buildLog 

 ### Resource Description 

 #### Get the list of webhook build log of Pipeline 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | repoName | string |No| Warehouse Name|| 
 | commitId | string |No|  commitId || 
 | page | integer |No| Page|| 
 | pageSize | integer |No| size per page|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes||| 
 | pipelineId | string |Yes||| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Packaging model SQLPage Pipeline webhook-Trigger log Details](get-the-pipelines-webhook-build-log-list.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[please Replace with the Request Url the API Address bar above]?  repoName={repoName}&amp;commitId={commitId}&amp;page={page}&amp;pageSize={pageSize}' \ 
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
    "records" : [ { 
      "codeType" : "String", 
      "repoName" : "String", 
      "success" : true, 
      "triggerResult" : "String", 
      "createdTime" : 0, 
      "logId" : 0, 
      "taskName" : "String", 
      "id" : 0, 
      "commitId" : "String", 
      "projectId" : "String", 
      "taskId" : "String", 
      "pipelineId" : "String" 
    } ], 
    "count" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model SQLPage Pipeline Webhook-Trigger log Details 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[SQLPage Pipeline webhook-Trigger log Details](get-the-pipelines-webhook-build-log-list.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## SQLPage Pipeline Webhook-Trigger log Details 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; [Pipeline log details](get-the-pipelines-webhook-build-log-list.md)&gt;|No|  records | 
 | count | integer |No|  count | 

 ## Pipeline webhook-Trigger log Details 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | codeType | string |Yes| Code Repository type| 
 | repoName | string |Yes| Warehouse Name| 
 | success | boolean |Yes| Whether it is triggered Success| 
 | triggerResult | string |Yes| Trigger result. If the trigger is Success, it is buildId. If the trigger is unsuccessful, it is the reason for the failure| 
 | createdTime | integer |No|  createdTime | 
 | logId | integer |No|  logId | 
 | taskName | string |Yes| Plugin name| 
 | id | integer |No|  id | 
 | commitId | string |Yes|  commitId | 
 | projectId | string |Yes| Project ID| 
 | taskId | string |Yes| Plugin ID| 
 | pipelineId | string |Yes| pipelineId| 