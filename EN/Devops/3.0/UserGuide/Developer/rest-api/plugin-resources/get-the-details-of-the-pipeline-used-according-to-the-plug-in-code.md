 # Get the detail of the Pipeline used according to the Plugin Code 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/atoms/{atomCode}/pipelines 

 ### Resource Description 

 #### Obtain detail of used Pipeline based on Plugin Code 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | page | integer |No| Page number|  1 | 
 | pageSize | integer |No| How many items per page|  20 | 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | atomCode | string |Yes| Plugin Code|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return wrapper model paging data wrapper Pipeline information| 

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
      "pipelineName" : "String", 
      "deptName" : "String", 
      "projectCode" : "String", 
      "bgName" : "String", 
      "projectName" : "String", 
      "pipelineId" : "String", 
      "atomVersion" : "String", 
      "centerName" : "String" 
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

 ## Data Return Package model Paging Data Package Pipeline Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |Paged data wrapper model Pipeline information| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Paged data Packaging model Pipeline Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; Pipeline Information&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

 ## Pipeline Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineName | string |Yes| pipelineName| 
 | deptName | string |No| Department| 
 | projectCode | string |Yes| project Identification| 
 | bgName | string |No| BG| 
 | projectName | string |No| Project| 
 | pipelineId | string |Yes| pipelineId| 
 | atomVersion | string |No| Plugin version used by Pipeline| 
 | centerName | string |No| centerInfo| 