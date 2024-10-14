 # Get a list of all kinds of Pipeline templates 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/templates/allTemplates 

 ### Resource Description 

 #### Get the list of all types of Pipeline templates 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes|  projectId || 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Package model OptionalTemplateList](get-a-list-of-all-kinds-of-pipeline-templates.md)| 

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
    "templates" : { 
      "string" : "string" 
    }, 
    "count" : 0, 
    "pageSize" : 0, 
    "page" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model OptionalTemplateList 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | [OptionalTemplateList](get-a-list-of-all-kinds-of-pipeline-templates.md) |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## OptionalTemplateList 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | templates | object |No|  templates | 
 | count | integer |No|  count | 
 | pageSize | integer |No|  pageSize | 
 | page | integer |No|  page | 