 # callback callback list 

 ### Request Method/Request Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/callbacks 

 ### Resource Description 

 #### Callback List 

 ### Input Parameter Description 

 #### Query Parameters 

 | Parameter Name| parameter type| Must| Parameter Description| default value| 
 | :--- | :--- | :--- | :--- | :--- | 
 | page| integer| No| Page number| 1| 
 | pageSize| integer| No| How many items per page| 20| 

 #### Path parameter 

 | Parameter Name| parameter type| Must| Parameter Description| default value| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId| string| Yes| projectId|| 

 #### Response 

 | HTTP code| Description| parameter type| 
 | :--- | :--- | :--- | 
 | 200| successful operation| [Pipeline Callback Configuration of Data Return Wrapper Model Paging Data Wrapper Model Project](callback-list.md)| 

 #### Request Sample 

 ```javascript 
 curl-X GET '[replace with API address bar request address]?  page={page}&amp;pageSize={pageSize}' \ 
 -H 'X-DEVOPS-UID:xxx' 
 ``` 

 #### HEADER Example 

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
      "secretToken" : "String", 
      "id" : 0, 
      "projectId" : "String", 
      "events" : "String" 
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

 ## Pipeline Callback Configuration of Data Return Package Model Paged Data Package Model Project 

 | Parameter Name| parameter type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data| [Pipeline Callback Configuration of Paged Data Wrapper Model Project](callback-list.md)| No| data| 
 | message| string| No| error message| 
 | status| integer| Yes| status code| 

 ## Pipeline Callback Configuration for Paged Data Wrapping Model Project 

 | Parameter Name| parameter type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records| List [pipeline callback configuration for project](callback-list.md)&lt; Yes&gt; data| Yes | data | 
 | count| integer| Yes| Total number of record lines| 
 | totalPages| integer| Yes| How many pages are there| 
 | pageSize| integer| Yes| How many items per page| 
 | page| integer| Yes| Page number| 

 ## Project Pipeline Callback Configuration 

 | Parameter Name| parameter type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | callBackUrl| string| No| callBackUrl| 
 | secretToken| string| No| secretToken| 
 | id| integer| No| id| 
 | projectId| string| No| projectId| 
 | events| string| No| events| 