 # Get signed IPA file download path 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/sign/ipa/{resignId}/downloadUrl 

 ### Resource Description 

 #### Obtain the signed IPA file download path 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | resignId | string |Yes| Signature Task ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model String](get-the-download-path-of-the-signed-ipa-file.md)| 

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
  "data" : "String", 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model String 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | string |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 