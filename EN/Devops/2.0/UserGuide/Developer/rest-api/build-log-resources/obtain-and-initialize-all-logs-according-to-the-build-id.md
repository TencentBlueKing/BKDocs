 # Get all log initialized according to build ID 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/logs/init 

 ### Resource Description 

 #### Acquire all log based on build ID 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | debug | boolean |No| Include Debug Log|| 
 | tag | string |No| Corresponding elementId|| 
 | jobId | string |No| Corresponding jobId|| 
 | executeCount | integer |No| Number of execute|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 
 | buildId | string |Yes| build ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model Logging Model](obtain-and-initialize-all-logs-according-to-the-build-id.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  debug={debug}&amp;tag={tag}&amp;jobId={jobId}&amp;executeCount={executeCount}' \ 
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
    "timeUsed" : 0, 
    "hasMore" : true, 
    "subTags" : "string", 
    "buildId" : "String", 
    "finished" : true, 
    "logs" : [ { 
      "subTag" : "String", 
      "jobId" : "String", 
      "lineNo" : 0, 
      "tag" : "String", 
      "message" : "String", 
      "priority" : "String", 
      "executeCount" : 0, 
      "timestamp" : 0 
    } ], 
    "status" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## data Return Package model Logging Model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Logging model](obtain-and-initialize-all-logs-according-to-the-build-id.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Logging model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | timeUsed | integer |No| time used| 
 | hasMore | boolean |No| Is there a follow-up log| 
 | subTags | List |Yes| log Subtag List| 
 | buildId | string |Yes| build ID| 
 | finished | boolean |Yes| Is it over| 
 | logs |List&lt; [log model](obtain-and-initialize-all-logs-according-to-the-build-id.md)&gt;|Yes| log List| 
 | status | integer |No| Logging status| 

 ## log model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | subTag | string |Yes| log Subtag| 
 | jobId | string |Yes| log jobId| 
 | lineNo | integer |Yes| log Line number| 
 | tag | string |Yes| log tag| 
 | message | string |Yes| log message body| 
 | priority | string |Yes| log Weight Level| 
 | executeCount | integer |Yes| Number of log execute| 
 | timestamp | integer |Yes| log Timestamp| 