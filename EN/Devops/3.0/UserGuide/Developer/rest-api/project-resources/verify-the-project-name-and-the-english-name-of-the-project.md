 # Check projectName and projectId 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{validateType}/names/validate 

 ### Resource Description 

 #### Check projectName and projectId 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | name | string |No| projectName or projectId|| 
 | english\_name | string |No| Project ID|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | validateType | string |Yes| The projectName or projectId is Check|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](verify-the-project-name-and-the-english-name-of-the-project.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  name={name}&amp;english_name={english_name}' \ 
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

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 