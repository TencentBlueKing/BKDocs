 # Get signature API token 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/sign/ipa/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/getSignToken 

 ### Resource Description 

 #### Obtaining signature API token 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 
 | buildId | string |Yes| build ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return model IPA Package Signature Information](get-the-signature-interface-token.md)| 

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
    "buildId" : "String", 
    "projectId" : "String", 
    "pipelineId" : "String", 
    "token" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## IPA Package Signature Information of data Return Package model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[IPA package signature information](get-the-signature-interface-token.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## IPA Package Signature Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | buildId | string |Yes| build ID| 
 | projectId | string |Yes| Project ID| 
 | pipelineId | string |Yes| pipelineId| 
 | token | string |Yes| Authentication token| 