 # EditCredential 

 ### Method/Path 

 #### PUT  /ms/openapi/api/apigw/v3/projects/{projectId}/credentials/{credentialId} 

 ### Resource Description 

 #### EditCredential 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[ticket-content on Update](edit-credentials.md)| Yes| ticket|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | credentialId | string |Yes| ticket ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](edit-credentials.md)| 

 #### Request Sample 

 ```javascript 
 curl -X PUT '[Replace with API Address bar Request Url]' \ 
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

 ## Ticket-Update content 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | credentialType | ENUM\(PASSWORD, ACCESSTOKEN, USERNAME\_PASSWORD, SECRETKEY, APPID\_SECRETKEY, SSH\_PRIVATEKEY, TOKEN\_SSH\_PRIVATEKEY, TOKEN\_USERNAME\_PASSWORD, COS\_APPID\_SECRETID\_SECRETKEY\_REGION, MULTI\_LINE\_PASSWORD, \) |Yes| ticket type| 
 | credentialRemark | string |No| ticket description| 
 | v1 | string |Yes| ticket content| 
 | credentialName | string |Yes| ticket name| 
 | v2 | string |Yes| ticket content| 
 | v3 | string |Yes| ticket content| 
 | v4 | string |Yes| ticket content| 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 