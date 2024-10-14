 # Signature Details 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/sign/ipa/{resignId}/detail 

 ### Resource Description 

 #### Signature Details 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | resignId | string |Yes| Signature Task ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[Query result of Signature status of data Return Package model](signature-task-details.md)| 

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
    "resignId" : "String", 
    "message" : "String", 
    "status" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Query result of Signature status of data Return Packaging model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Signature status Query result](signature-task-details.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Signature status Query result 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | resignId | string |Yes| Signature ID| 
 | message | string |Yes| description information| 
 | status | string |Yes| complete| 