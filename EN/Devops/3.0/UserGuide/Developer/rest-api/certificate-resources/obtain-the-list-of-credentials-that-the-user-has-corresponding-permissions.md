 # Get the credentialList that the user has corresponding auth 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/credentials 

 ### Resource Description 

 #### Obtain the credentialList for corresponding auth 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | credentialTypes | string |No| Comma separated list of credentialType|| 
 | page | integer |No| Page number|  1 | 
 | pageSize | integer |No| How many items per page|  20 | 
 | keyword | string |No| keywords|| 

 | X-DEVOPS-UID | string |Yes| user ID|  admin | 
 | :--- | :--- | :--- | :--- | :--- | 


 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Paging Data Wrapper Model ticket-Credential content and auth](obtain-the-list-of-credentials-that-the-user-has-corresponding-permissions.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  credentialTypes={credentialTypes}&amp;page={page}&amp;pageSize={pageSize}&amp;keyword={keyword}' \ 
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

 ## Data Return Packaging model Paging Data Packaging Model ticket-Credential content and auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[Paged data Wrapper model ticket-Credential content and auth](obtain-the-list-of-credentials-that-the-user-has-corresponding-permissions.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Paged data Wrapping model ticket-Credentials content and auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; [ticket content and auth](obtain-the-list-of-credentials-that-the-user-has-corresponding-permissions.md)&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

 ## Ticket-Credential content and auth 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | credentialType | ENUM\(PASSWORD, ACCESSTOKEN, USERNAME\_PASSWORD, SECRETKEY, APPID\_SECRETKEY, SSH\_PRIVATEKEY, TOKEN\_SSH\_PRIVATEKEY, TOKEN\_USERNAME\_PASSWORD, COS\_APPID\_SECRETID\_SECRETKEY\_REGION, MULTI\_LINE\_PASSWORD, \) |Yes| ticket type| 
 | updatedTime | integer |Yes| Updated updateTime| 
 | credentialRemark | string |No| ticket description| 
 | permissions |[Credential-Credential auth](obtain-the-list-of-credentials-that-the-user-has-corresponding-permissions.md)| Yes| auth| 
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