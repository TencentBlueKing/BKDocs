 # Manual toCheck Start Up Stage 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/stages/{stageId}/manualStart 

 ### Resource Description 

 #### Manual toCheck Start Up Stage 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | cancel | boolean |No| cancel execute|| 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[Manual toCheck-stageReviewParams](manual-review-of-the-start-up-phase.md)| No| toCheck Request Body|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 
 | buildId | string |Yes| build ID|| 
 | stageId | string |Yes| Stage ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](manual-review-of-the-start-up-phase.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]?  cancel={cancel}' \ 
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

 ## Manual toCheck-stageReviewParams 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | valueType | ENUM\(STRING, TEXTAREA, BOOLEAN, ENUM, MULTIPLE, \) |No| Type| 
 | options |List&lt; [Manual toCheck-stageReviewParams-Drop-down Box List](manual-review-of-the-start-up-phase.md)&gt;|No| Drop-down box list| 
 | chineseName | string |No| chineseName| 
 | value | object |Yes| Parameter content| 
 | key | string |Yes| Name| 
 | required | boolean |Yes| required| 
 | desc | string |No| Description| 

 ## Manual toCheck-stageReviewParams-Drop-down Box List 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |Yes| Parameter content| 
 | key | string |Yes| Name| 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 