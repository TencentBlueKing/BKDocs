 # Create callback 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/callbacks 

 ### Resource Description 

 #### Create a callback 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | url | string |Yes|  url || 
 | region | string |Yes|  region || 
 | event | string |Yes|  event || 
 | secretToken | string |No|  secretToken || 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](create-callback-callback.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]?  url={url}&amp;region={region}&amp;event={event}&amp;secretToken={secretToken}' \ 
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