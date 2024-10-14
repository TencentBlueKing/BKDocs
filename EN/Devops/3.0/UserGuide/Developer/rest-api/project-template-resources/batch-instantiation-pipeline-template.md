 # Batch instantiate Pipeline Template 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects/{projectId}/templates/{templateId}/templateInstances 

 ### Resource Description 

 #### Batch instantiate Pipeline Template 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | version | integer |Yes| templateVersion|| 
 | useTemplateSettings | boolean |No| Apply template Set|| 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |array&lt; [TemplateInstanceCreate](batch-instantiation-pipeline-template.md)&gt;|Yes| create Instance|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | templateId | string |Yes| Template ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation | [TemplateOperationRet](batch-instantiation-pipeline-template.md) | 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]?  version={version}&amp;useTemplateSettings={useTemplateSettings}' \ 
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
    "failurePipelines" : "string",
    "failureMessages" : {
      "string" : "string"
    },
    "successPipelinesId" : "string",
    "successPipelines" : "string"
  },
  "message" : "String",
  "status" : 0
}
```

 ## TemplateInstanceCreate 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineName | string |No|  pipelineName | 
 | param |List&lt; [build model element properties](batch-instantiation-pipeline-template.md)&gt;|No|  param | 
 | buildNo | [BuildNo](batch-instantiation-pipeline-template.md) |No|  buildNo | 

 ## Build model-Form Element Attributes 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | defaultValue | object |Yes| defaultValue| 
 | containerType | [BuildContainerType](batch-instantiation-pipeline-template.md) |No| agent type drop-down| 
 | glob | string |No| customRepo Wildcards| 
 | replaceKey | string |No| Replace the search keywords in the search url| 
 | readOnly | boolean |No| Read Only| 
 | label | string |No| element label| 
 | type | ENUM\(STRING, TEXTAREA, ENUM, DATE, LONG, BOOLEAN, SVN\_TAG, GIT\_REF, MULTIPLE, CODE\_LIB, CONTAINER\_TYPE, ARTIFACTORY, SUB\_PIPELINE, CUSTOM\_FILE, PASSWORD, TEMPORARY, \) |Yes| element type| 
 | required | boolean |Yes| Must| 
 | repoHashId | string |No|  repoHashId | 
 | scmType | ENUM\(CODE\_SVN, CODE\_GIT, CODE\_GITLAB, GITHUB, CODE\_TGIT, \) |No| Code Repository type Drop-Down| 
 | relativePath | string |No|  relativePath | 
 | propertyType | string |No| element module| 
 | options |List&lt; [build model-drop-down box form element values](batch-instantiation-pipeline-template.md)&gt;|No| Drop-down box list| 
 | searchUrl | string |No| search url, when it is a drop-down box options, the list value is obtained from url no longer obtained from option| 
 | id | string |Yes| Element ID-Identifier| 
 | placeholder | string |No| The Placeholder| 
 | properties | object |No| file metaData| 
 | desc | string |No| description| 

 ## BuildContainerType 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | os | ENUM\(MACOS, WINDOWS, LINUX, \) |No|  os | 
 | buildType | ENUM\(ESXi, MACOS, DOCKER, IDC, PUBLIC\_DEVCLOUD, TSTACK, THIRD\_PARTY\_AGENT\_ID, THIRD\_PARTY\_AGENT\_ENV, THIRD\_PARTY\_PCG, THIRD\_PARTY\_DEVCLOUD, GIT\_CI, AGENT\_LESS, \) |No|  buildType | 

 ## Build model-Form Element Value of Drop-down Box 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |Yes| Element value name-for Display| 
 | key | string |Yes| Element Value ID-Identifier| 

 ## BuildNo 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | buildNoType | ENUM\(CONSISTENT, SUCCESS\_BUILD\_INCREMENT, EVERY\_BUILD\_INCREMENT, \) |No|  buildNoType | 
 | buildNo | integer |No|  buildNo | 
 | required | boolean |No|  required | 

 ## TemplateOperationRet 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | [TemplateOperationMessage](batch-instantiation-pipeline-template.md) |No|  data | 
 | message | string |No|  message | 
 | status | integer |No|  status | 

 ## TemplateOperationMessage 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | failurePipelines | List |No|  failurePipelines | 
 | failureMessages | object |No|  failureMessages | 
 | successPipelinesId | List |No|  successPipelinesId | 
 | successPipelines | List |No|  successPipelines | 

