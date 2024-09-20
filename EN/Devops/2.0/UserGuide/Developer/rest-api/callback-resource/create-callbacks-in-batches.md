 # Batch create callback callbacks 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/callbacks/batch 

 ### Resource Description 

 #### Batch create of callback callbacks 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | url | string |Yes|  url || 
 | region | string |Yes|  region || 
 | event | string |Yes|  event || 
 | secretToken | string |No|  secretToken || 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return the Pipeline callback create result of the wrapper model project](create-callbacks-in-batches.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]?  url={url}&amp;region={region}&amp;event={event}&amp;secretToken={secretToken}' \ 
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
    "successEvents" : "string", 
    "failureEvents" : { 
      "string" : "string" 
    } 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Pipeline Callback create result of Data Return Package model project 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Pipeline callback create result for project](create-callbacks-in-batches.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Project Pipeline Callback create result 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | successEvents | List |No|  successEvents | 
 | failureEvents | object |No|  failureEvents | 