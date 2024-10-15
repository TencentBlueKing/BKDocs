 # Get Pipeline manual Start Up Parameter 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/manualStartupInfo 

 ### Resource Description 

 #### Obtain Parameter for manual Pipeline Start Up 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | channelCode | string |No| Channel number, default to BS|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model build Model-Pipeline manual Start Up Information](obtain-the-manual-start-parameters-of-the-pipeline.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  channelCode={channelCode}' \ 
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
    "canManualStartup" : true, 
    "canElementSkip" : true, 
    "buildNo" : { 
      "buildNoType" : "ENUM", 
      "buildNo" : 0, 
      "required" : true 
    }, 
    "properties" : [ { 
      "defaultValue" : { 
        "string" : "string" 
      }, 
      "containerType" : { 
        "os" : "ENUM", 
        "buildType" : "ENUM" 
      }, 
      "glob" : "String", 
      "replaceKey" : "String", 
      "readOnly" : true, 
      "label" : "String", 
      "type" : "ENUM", 
      "required" : true, 
      "repoHashId" : "String", 
      "scmType" : "ENUM", 
      "relativePath" : "String", 
      "propertyType" : "String", 
      "options" : [ { 
        "value" : "String", 
        "key" : "String" 
      } ], 
      "searchUrl" : "String", 
      "id" : "String", 
      "placeholder" : "String", 
      "properties" : { 
        "string" : "string" 
      }, 
      "desc" : "String" 
    } ] 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Package model build Model-manual Start Up Information of Pipeline 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[build model-Pipeline manual Start Up Information](obtain-the-manual-start-parameters-of-the-pipeline.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Build model-manual Start Up of Pipeline 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | canManualStartup | boolean |Yes| Can it be Start Up manually| 
 | canElementSkip | boolean |Yes| Can Plugin be SKIP| 
 | buildNo | [BuildNo](obtain-the-manual-start-parameters-of-the-pipeline.md) |Yes| Assigned buildNo| 
 | properties |List&lt; [build model element properties](obtain-the-manual-start-parameters-of-the-pipeline.md)&gt;|Yes| Start Up Form Element List| 

 ## BuildNo 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | buildNoType | ENUM\(CONSISTENT, SUCCESS\_BUILD\_INCREMENT, EVERY\_BUILD\_INCREMENT, \) |No|  buildNoType | 
 | buildNo | integer |No|  buildNo | 
 | required | boolean |No|  required | 

 ## Build model-Form Element Attributes 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | defaultValue | object |Yes| defaultValue| 
 | containerType | [BuildContainerType](obtain-the-manual-start-parameters-of-the-pipeline.md) |No| agent type drop-down| 
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
 | options |List&lt; [build model-drop-down box form element values](obtain-the-manual-start-parameters-of-the-pipeline.md)&gt;|No| Drop-down box list| 
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