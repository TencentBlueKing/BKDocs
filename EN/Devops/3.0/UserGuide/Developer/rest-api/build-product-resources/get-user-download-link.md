 # Get user downloadLink 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/artifactories/userDownloadUrl 

 ### Resource Description 

 #### Obtaining a user 'downloadLink 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | artifactoryType | string |Yes| repoType|| 
 | path | string |Yes| path|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Package Model artifactory-download Information| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[please Replace with the Request Url the API Address bar above]?  artifactoryType={artifactoryType}&amp;path={path}' \ 
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
    "url2" : "String", 
    "url" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package Model artifactory-download Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |artifactory-download Information| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Artifactory-download Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | url2 | string |No| downloadLink 2| 
 | url | string |Yes| downloadLink| 