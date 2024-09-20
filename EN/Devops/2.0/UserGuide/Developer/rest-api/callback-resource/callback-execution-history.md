 # callback callback Last 10 history records 

 ###Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/callbacks/history 

 ### Resource Description 

 #### Callback Last 10 history records 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | url | string |Yes| Callback url|| 
 | event | string |Yes| Event type|| 
 | startTime | string |No| Starting Time\(yyyy-MM-dd HH:mm:ss Format\)|| 
 | endTime | string |No| End Time\(yyyy-MM-dd HH:mm:ss Format\)|| 
 | page | integer |No| Page number|  1 | 
 | pageSize | integer |No| How many items per page|  20 | 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[Pipeline callback history of data Return wrapper model paging data wrapper model project](callback-execution-history.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  url={url}&amp;event={event}&amp;startTime={startTime}&amp;endTime={endTime}&amp;page={page}&amp;pageSize={pageSize}' \ 
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
      "callBackUrl" : "String", 
      "responseBody" : "String", 
      "responseCode" : 0, 
      "errorMsg" : "String", 
      "requestHeaders" : [ { 
        "name" : "String", 
        "value" : "String" 
      } ], 
      "requestBody" : "String", 
      "createdTime" : 0, 
      "startTime" : 0, 
      "id" : 0, 
      "endTime" : 0, 
      "projectId" : "String", 
      "events" : "String", 
      "status" : "String" 
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

 ## Pipeline Callback History of Data Return Package model Paged Data Package Model project 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Pipeline Callback History of Paged data Wrapper model project](callback-execution-history.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Pipeline Callback History of Paged data Packaging model project 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; [Pipeline callback history for project](callback-execution-history.md)&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

 ## Project Pipeline Callback History 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | callBackUrl | string |No|  callBackUrl | 
 | responseBody | string |No|  responseBody | 
 | responseCode | integer |No|  responseCode | 
 | errorMsg | string |No|  errorMsg | 
 | requestHeaders |List&lt; [CallBackHeader](callback-execution-history.md)&gt;|No|  requestHeaders | 
 | requestBody | string |No|  requestBody | 
 | createdTime | integer |No|  createdTime | 
 | startTime | integer |No|  startTime | 
 | id | integer |No|  id | 
 | endTime | integer |No|  endTime | 
 | projectId | string |No|  projectId | 
 | events | string |No|  events | 
 | status | string |No|  status | 

 ## CallBackHeader 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | name | string |No|  name | 
 | value | string |No|  value | 