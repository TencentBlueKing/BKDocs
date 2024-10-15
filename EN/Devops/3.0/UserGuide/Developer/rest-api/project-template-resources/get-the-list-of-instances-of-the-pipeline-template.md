 # Get the list of instances of Pipeline template 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/templates/{templateId}/templateInstances 

 ### Resource Description 

 #### Get the list of instances of the Pipeline template 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | page | integer |No| Page number|  1 | 
 | pageSize | integer |No| How many items per page|  30 | 
 | searchKey | string |No| Name search keywords|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | templateId | string |Yes| Template ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Packaging model TemplateInstancePage](get-the-list-of-instances-of-the-pipeline-template.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  page={page}&amp;pageSize={pageSize}&amp;searchKey={searchKey}' \ 
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
    "instances" : [ { 
      "pipelineName" : "String", 
      "hasPermission" : true, 
      "updateTime" : 0, 
      "templateId" : "String", 
      "versionName" : "String", 
      "version" : 0, 
      "pipelineId" : "String", 
      "status" : "ENUM" 
    } ], 
    "latestVersion" : { 
      "creator" : "String", 
      "updateTime" : 0, 
      "versionName" : "String", 
      "version" : 0 
    }, 
    "count" : 0, 
    "pageSize" : 0, 
    "page" : 0, 
    "templateId" : "String", 
    "projectId" : "String" 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model TemplateInstancePage 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | [TemplateInstancePage](get-the-list-of-instances-of-the-pipeline-template.md) |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## TemplateInstancePage 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | instances |List&lt; [TemplatePipeline](get-the-list-of-instances-of-the-pipeline-template.md)&gt;|No|  instances | 
 | latestVersion | [TemplateVersion](get-the-list-of-instances-of-the-pipeline-template.md) |No|  latestVersion | 
 | count | integer |No|  count | 
 | pageSize | integer |No|  pageSize | 
 | page | integer |No|  page | 
 | templateId | string |No|  templateId | 
 | projectId | string |No|  projectId | 

 ## TemplatePipeline 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineName | string |No|  pipelineName | 
 | hasPermission | boolean |No|  hasPermission | 
 | updateTime | integer |No|  updateTime | 
 | templateId | string |No|  templateId | 
 | versionName | string |No|  versionName | 
 | version | integer |No|  version | 
 | pipelineId | string |No|  pipelineId | 
 | status | ENUM\(PENDING\_UPDATE, UPDATING, UPDATED, \) |No|  status | 

 ## TemplateVersion 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | creator | string |No|  creator | 
 | updateTime | integer |No|  updateTime | 
 | versionName | string |No|  versionName | 
 | version | integer |No|  version | 