 # Template Manage-Get templateList 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/templates 

 ### Resource Description 

 #### Template Manage-Get templateList 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | templateType | string |No| Template type|| 
 | storeFlag | boolean |No| Is it link with the store|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model TemplateListModel](get-a-list-of-templates.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  templateType={templateType}&amp;storeFlag={storeFlag}' \ 
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
    "models" : [ { 
      "templateType" : "String", 
      "associatePipelines" : [ { 
        "id" : "String" 
      } ], 
      "hasPermission" : true, 
      "name" : "String", 
      "templateTypeDesc" : "String", 
      "templateId" : "String", 
      "versionName" : "String", 
      "version" : 0, 
      "hasInstance2Upgrade" : true, 
      "logoUrl" : "String", 
      "storeFlag" : true, 
      "associateCodes" : "string" 
    } ], 
    "hasPermission" : true, 
    "count" : 0, 
    "projectId" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model TemplateListModel 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | [TemplateListModel](get-a-list-of-templates.md) |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## TemplateListModel 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | models |List&lt; [TemplateModel](get-a-list-of-templates.md)&gt;|No|  models | 
 | hasPermission | boolean |No|  hasPermission | 
 | count | integer |No|  count | 
 | projectId | string |No|  projectId | 

 ## TemplateModel 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | templateType | string |Yes| Template type| 
 | associatePipelines |List&lt; [Pipeline model](get-a-list-of-templates.md)&gt;|Yes| link Pipeline| 
 | hasPermission | boolean |Yes| auth to Operation template| 
 | name | string |Yes| Template name| 
 | templateTypeDesc | string |Yes| Template type description| 
 | templateId | string |Yes| Template ID| 
 | versionName | string |Yes| The latest versionNum| 
 | version | integer |Yes| version ID| 
 | hasInstance2Upgrade | boolean |Yes| Is there an Update instance| 
 | logoUrl | string |Yes| Template logo| 
 | storeFlag | boolean |Yes| link to Market| 
 | associateCodes | List |Yes| link Code Repository| 

 ## Pipeline model-ID 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | id | string |Yes| pipelineId| 