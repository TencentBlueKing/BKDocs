 # List of Code Repository 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/repositories/{projectId}/hasPermissionList 

 ### Resource Description 

 #### Code Repository List 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | repositoryType | string |No| repoType|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Paging Data Wrapper Code Repository Model-Basic Information](code-library-list.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  repositoryType={repositoryType}' \ 
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
      "aliasName" : "String", 
      "updatedTime" : 0, 
      "repositoryId" : 0, 
      "type" : "ENUM", 
      "repositoryHashId" : "String", 
      "url" : "String" 
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

 ## Data Return Wrapper model Paging Data Wrapper Code Repository Model-Basic Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Paged data Wrapper model Code Repository Model-Basic Information](code-library-list.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Paged data Wrapper model Code Repository Model-Basic Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; [Code Repository model-Basic Information](code-library-list.md)&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

 ## Code Repository model-Basic Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | aliasName | string |Yes| Warehouse aliasName| 
 | updatedTime | integer |Yes| Updated updateTime| 
 | repositoryId | integer |No| Warehouse ID| 
 | type | ENUM\(CODE\_SVN, CODE\_GIT, CODE\_GITLAB, GITHUB, CODE\_TGIT, \) |Yes| type| 
 | repositoryHashId | string |No| Warehouse Hash ID| 
 | url | string |Yes|  URL | 