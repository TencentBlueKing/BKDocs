 # linkCodelib 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/repositories/{projectId} 

 ### Resource Description 

 #### linkCodelib 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[Code Repository model-polymorphic base class](associated-code-base.md)| Yes| Code Repository model|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Code Repository Model-ID](associated-code-base.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]' \ 
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
    "hashId" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Code Repository model-Polymorphic Base Class 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | startPrefix | string |No|  startPrefix | 
 | aliasName | string |No|  aliasName | 
 | formatURL | string |No|  formatURL | 
 | legal | boolean |No|  legal | 
 | credentialId | string |No|  credentialId | 
 | userName | string |No|  userName | 
 | projectName | string |No|  projectName | 
 | projectId | string |No|  projectId | 
 | url | string |No|  url | 
 | repoHashId | string |No|  repoHashId | 

 ## Data Return Package model Code Repository Model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Code Repository model](associated-code-base.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Code Repository model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | hashId | string |Yes| Code Repository Hash ID| 