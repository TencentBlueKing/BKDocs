 # Get the intercept record 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/quality/intercepts/list 

 ### Resource Description 

 #### Obtaining Interception Records 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | pipelineId | string |No| pipelineId|| 
 | ruleHashId | string |No| Rule ID|| 
 | interceptResult | string |No| status|| 
 | startTime | integer |No| Starting Time|| 
 | endTime | integer |No| deadline|| 
 | page | integer |No| page number|  1 | 
 | pageSize | integer |No| Number of pages|  20 | 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Paging Data Wrapper Model Gate-Intercept Records](obtain-interception-records.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  pipelineId={pipelineId}&amp;ruleHashId={ruleHashId}&amp;interceptResult={interceptResult}&amp;startTime={startTime}&amp;endTime={endTime}&amp;page={page}&amp;pageSize={pageSize}' \ 
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
      "checkTimes" : 0, 
      "num" : 0, 
      "buildId" : "String", 
      "remark" : "String", 
      "buildNo" : "String", 
      "hashId" : "String", 
      "pipelineId" : "String", 
      "pipelineName" : "String", 
      "pipelineIsDelete" : true, 
      "interceptList" : [ { 
        "indicatorId" : "String", 
        "indicatorName" : "String", 
        "indicatorType" : "String", 
        "pass" : true, 
        "actualValue" : "String", 
        "logPrompt" : "String", 
        "detail" : "String", 
        "operation" : "ENUM", 
        "value" : "String", 
        "controlPoint" : "String" 
      } ], 
      "interceptResult" : "ENUM", 
      "ruleName" : "String", 
      "ruleHashId" : "String", 
      "timestamp" : 0 
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

 ## Data Return Wrapper model Paging Data Wrapper Model Gate-Intercept Record 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Paged data Wrapping model Gate-Intercepting Records](obtain-interception-records.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Paged data Wrapping model Gate-Intercepting Records 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; [Gate-Interception-Records.md](obtain-interception-records.md)&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

 ## Gate-Interception Record 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | checkTimes | integer |Yes| Number of inspections| 
 | num | integer |Yes| No. in the project| 
 | buildId | string |Yes| build ID| 
 | remark | string |Yes| description| 
 | buildNo | string |Yes| buildNo| 
 | hashId | string |Yes|  hashId | 
 | pipelineId | string |Yes| pipelineId| 
 | pipelineName | string |Yes| pipelineName| 
 | pipelineIsDelete | boolean |Yes| Has Pipeline deleted| 
 | interceptList |List&lt; [Gate-Intercepting Rules Intercepting Records](obtain-interception-records.md)&gt;|Yes| description List| 
 | interceptResult | ENUM\(PASS, FAIL, \) |Yes| intercept result| 
 | ruleName | string |Yes| Rule name| 
 | ruleHashId | string |Yes| Rule HashId| 
 | timestamp | integer |Yes| Timestamp\(Second\)| 

 ## Gate-Intercept Rules Intercept Records 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | indicatorId | string |Yes| Indicator ID| 
 | indicatorName | string |Yes| Indicator name| 
 | indicatorType | string |No| Indicator Plugin type| 
 | pass | boolean |Yes| approve| 
 | actualValue | string |Yes| actual value| 
 | logPrompt | string |No| Metric log Output detail| 
 | detail | string |Yes| Indicator detail| 
 | operation | ENUM\(GT, GE, LT, LE, EQ, \) |Yes| relationship| 
 | value | string |Yes| Threshold size| 
 | controlPoint | string |Yes| control point| 