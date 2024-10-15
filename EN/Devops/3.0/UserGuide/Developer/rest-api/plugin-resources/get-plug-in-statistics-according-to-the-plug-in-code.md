 # Get Plugin stat based on Plugin Code 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/atoms/{atomCode}/statistic 

 ### Resource Description 

 #### Obtain Plugin stat by Plugin Code 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | atomCode | string |Yes| Plugin Code|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Wrapper model Statistics| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]' \ 
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
    "score" : "parse error", 
    "downloads" : 0, 
    "successRate" : "parse error", 
    "recentExecuteNum" : 0, 
    "pipelineCnt" : 0, 
    "commentCnt" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model Statistics 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |statistical information| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Statistics 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | score | number |No| Star rating| 
 | downloads | integer |No| download| 
 | successRate | number |No| Success rate| 
 | recentExecuteNum | integer |No| latestExec| 
 | pipelineCnt | integer |No| Count of Pipeline| 
 | commentCnt | integer |No| comment quantity| 