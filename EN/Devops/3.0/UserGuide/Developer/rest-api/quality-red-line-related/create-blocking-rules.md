 # Create Intercept Rules 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/quality/rules/create 

 ### Resource Description 

 #### Create an interception rule 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[Rule create Request](create-blocking-rules.md)| Yes| rule content|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model String](create-blocking-rules.md)| 

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

 ###Return Sample-200 

 ```javascript 
 { 
  "data" : "String", 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Rule create Request 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | templateRange | List |Yes| Take Effect Pipeline template id Collection| 
 | auditUserList | List |No| stageReviewInputNotice Person| 
 | range | List |Yes| Take Effect pipelineId Collection| 
 | auditTimeoutMinutes | integer |No| toCheck Timeout| 
 | notifyTypeList | List |No| type of notification| 
 | notifyUserList | List |No| List of notified personnel| 
 | controlPointPosition | string |Yes| control point position| 
 | name | string |Yes| Rule name| 
 | notifyGroupList | List |No| noticeGroup List| 
 | operation | ENUM\(END, AUDIT, \) |Yes| Type| 
 | indicatorIds |List&lt; [CreateRequestIndicator](create-blocking-rules.md)&gt;|Yes| Indicator type| 
 | controlPoint | string |Yes| control point| 
 | gatewayId | string |No| Red line match id| 
 | desc | string |Yes| rule description| 

 ## CreateRequestIndicator 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | threshold | string |No|  threshold | 
 | hashId | string |No|  hashId | 
 | operation | string |No|  operation | 

 ## Data Return Package model String 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | string |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 