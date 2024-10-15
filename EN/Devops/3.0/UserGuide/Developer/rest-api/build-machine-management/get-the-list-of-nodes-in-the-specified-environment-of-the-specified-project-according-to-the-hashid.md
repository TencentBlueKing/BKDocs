 # Get the nodeList in the specified project and environment according to the hashId of the environment\(do not Check auth\) 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/environment/projects/{projectId}/nodes/listRawByEnvHashIds 

 ### Resource Description 

 #### Obtain the nodeList in the specified project and environment according to the hashId of the environment\(auth is not Check\) 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body | array |Yes| node hashIds|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return wrapper model MapStringList Node information\(auth\)| 

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
    "string" : "string" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 # Data Return MapStringList Node information of Wrapper model\(auth\) 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | object |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 