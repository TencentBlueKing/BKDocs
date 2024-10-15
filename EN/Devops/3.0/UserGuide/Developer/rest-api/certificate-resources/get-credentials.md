 # Get the ticket 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/credentials/{credentialId} 

 ### Resource Description 

 #### Acquiring ticket 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | credentialId | string |Yes| ticket ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model ticket-Credential content and auth](get-credentials.md)| 

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
    "credentialType" : "ENUM", 
    "updatedTime" : 0, 
    "credentialRemark" : "String", 
    "permissions" : { 
      "view" : true, 
      "edit" : true, 
      "delete" : true 
    }, 
    "credentialId" : "String", 
    "updateUser" : "String", 
    "v1" : "String", 
    "credentialName" : "String", 
    "v2" : "String", 
    "v3" : "String", 
    "v4" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model ticket-Credential content and auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[ticket-Credential content and auth](get-credentials.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Ticket-Credential content and auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | credentialType | ENUM\(PASSWORD, ACCESSTOKEN, USERNAME\_PASSWORD, SECRETKEY, APPID\_SECRETKEY, SSH\_PRIVATEKEY, TOKEN\_SSH\_PRIVATEKEY, TOKEN\_USERNAME\_PASSWORD, COS\_APPID\_SECRETID\_SECRETKEY\_REGION, MULTI\_LINE\_PASSWORD, \) |Yes| ticket type| 
 | updatedTime | integer |Yes| Updated updateTime| 
 | credentialRemark | string |No| ticket description| 
 | permissions |[Credential-Credential auth](get-credentials.md)| Yes| auth| 
 | credentialId | string |Yes| ticket ID| 
 | updateUser | string |Yes| Updated Updated by| 
 | v1 | string |Yes| ticket content| 
 | credentialName | string |Yes| ticket name| 
 | v2 | string |Yes| ticket content| 
 | v3 | string |Yes| ticket content| 
 | v4 | string |Yes| ticket content| 

 ## Voucher-Voucher auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | view | boolean |Yes| view auth| 
 | edit | boolean |Yes| edit auth| 
 | delete | boolean |Yes| delete auth| 