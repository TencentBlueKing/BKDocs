 # Get the list of interception rules 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/quality/rules/list 

 ### Resource Description 

 #### Obtaining the list of interception rules 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | page | integer |No| page entry|  1 | 
 | pageSize | integer |No| Number of pages|  20 | 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Paging Data Wrapper Model Gate-Rule Summary v2](get-the-list-of-blocking-rules.md)| 

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
  "data" : { 
    "records" : [ { 
      "pipelineCount" : 0, 
      "pipelineExecuteCount" : 0, 
      "indicatorList" : [ { 
        "cnName" : "String", 
        "name" : "String", 
        "threshold" : "String", 
        "hashId" : "String", 
        "operation" : "String" 
      } ], 
      "enable" : true, 
      "permissions" : { 
        "canEnable" : true, 
        "canEdit" : true, 
        "canDelete" : true 
      }, 
      "name" : "String", 
      "range" : "ENUM", 
      "rangeSummary" : [ { 
        "lackElements" : "string", 
        "name" : "String", 
        "id" : "String", 
        "type" : "String" 
      } ], 
      "interceptTimes" : 0, 
      "ruleHashId" : "String", 
      "controlPoint" : { 
        "cnName" : "String", 
        "name" : "String", 
        "hashId" : "String" 
      }, 
      "gatewayId" : "String" 
    } ], 
    "count" : 0, 
    "totalPages" : 0, 
    "pageSize" : 0, 
    "page" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Wrapper model Paging Data Wrapper Model Gate-Rule Summary v2 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Paged data Wrapping model Gate-Rule Summary v2](get-the-list-of-blocking-rules.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ##Paged data Packaging model Gate-Rule Summary v2 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; [Gate-Rule Summary v2](get-the-list-of-blocking-rules.md)&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

 ## Gate-Rule Summary v2 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineCount | integer |Yes| Count of Pipeline| 
 | pipelineExecuteCount | integer |Yes| Take Effect Pipeline execution times| 
 | indicatorList |List&lt; [RuleSummaryIndicator](get-the-list-of-blocking-rules.md)&gt;|Yes| Index List| 
 | enable | boolean |Yes| Enable| 
 | permissions |[Gate-Rule auth](get-the-list-of-blocking-rules.md)| Yes| rule auth| 
 | name | string |Yes| Rule name| 
 | range | ENUM\(ANY, PART\_BY\_TAG, PART\_BY\_NAME, \) |Yes| Effective Range| 
 | rangeSummary |List&lt; [RuleRangeSummary](get-the-list-of-blocking-rules.md)&gt;|Yes| Effective Range with template and Pipeline (new)| 
 | interceptTimes | integer |Yes| Intercepted| 
 | ruleHashId | string |Yes| Rule HashId| 
 | controlPoint | [RuleSummaryControlPoint](get-the-list-of-blocking-rules.md) |Yes| control point| 
 | gatewayId | string |Yes| Redline ID| 

 ## RuleSummaryIndicator 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | cnName | string |No|  cnName | 
 | name | string |No|  name | 
 | threshold | string |No|  threshold | 
 | hashId | string |No|  hashId | 
 | operation | string |No|  operation | 

 ## Gate-Rule auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | canEnable | boolean |Yes| Can be Disable/Enable| 
 | canEdit | boolean |Yes| edit| 
 | canDelete | boolean |Yes| Can it be delete| 

 ## RuleRangeSummary 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | lackElements | List |No|  lackElements | 
 | name | string |No|  name | 
 | id | string |No|  id | 
 | type | string |No|  type | 

 ## RuleSummaryControlPoint 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | cnName | string |No|  cnName | 
 | name | string |No|  name | 
 | hashId | string |No|  hashId | 