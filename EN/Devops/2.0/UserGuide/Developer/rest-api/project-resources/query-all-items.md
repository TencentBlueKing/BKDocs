 # Query all project 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects 

 ### Resource Description 

 #### Query all project 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 


 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model List project-Display Model](query-all-items.md)| 

 #### equest Sample 

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
  "result" : true,
  "code" : 0,
  "data" : [ {
    "deptName" : "String",
    "englishName" : "String",
    "projectType" : 0,
    "description" : "String",
    "remark" : "String",
    "project_name" : "String",
    "deployType" : "String",
    "enabled" : true,
    "createdAt" : "String",
    "helmChartEnabled" : true,
    "gray" : true,
    "dataId" : 0,
    "secrecy" : true,
    "projectCode" : "String",
    "project_id" : "String",
    "useBk" : true,
    "enableExternal" : true,
    "extra" : "String",
    "routerTag" : "String",
    "id" : 0,
    "ccAppId" : 0,
    "updatedAt" : "String",
    "approvalStatus" : 0,
    "approver" : "String",
    "pipelineLimit" : 0,
    "centerId" : "String",
    "ccAppName" : "String",
    "creator" : "String",
    "kind" : 0,
    "cc_app_id" : 0,
    "deptId" : "String",
    "approvalTime" : "String",
    "project_code" : "String",
    "relationId" : "String",
    "logoAddr" : "String",
    "bgId" : "String",
    "offlined" : true,
    "hybridCcAppId" : 0,
    "bgName" : "String",
    "projectName" : "String",
    "enableIdc" : true,
    "projectId" : "String",
    "cc_app_name" : "String",
    "hybrid_cc_app_id" : 0,
    "centerName" : "String"
  } ],
  "requestId" : "String",
  "message" : "String"
}
```

 ## Data Return Package model List project-Display Model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | result | boolean |No| Request result| 
 | code | integer |Yes| Status Code| 
 | data |List&lt; [project-Display model](query-all-items.md)&gt;|No| data| 
 | requestId | string |No| Request ID| 
 | message | string |No| Error Message| 

 ## Project-Display model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | deptName | string |No| Department name| 
 | englishName | string |No| englishName| 
 | projectType | integer |No| Project type| 
 | description | string |No| description| 
 | remark | string |No| Commentary| 
 | project\_name | string |No| Old Version projectName\(will be obsolete soon, the old Field name referenced in compatible Plugin, please use projectName instead of\)| 
 | deployType | string |No| Deploy type| 
 | enabled | boolean |No| Enable| 
 | createdAt | string |No| creationTime| 
 | helmChartEnabled | boolean |No| Enable Chart Activation| 
 | gray | boolean |No| Gray or not| 
 | dataId | integer |No| Data ID| 
 | secrecy | boolean |No| Confidentiality| 
 | projectCode | string |No| project Code| 
 | project\_id | string |No| Project ID\(will be obsolete soon, the old Field name referenced in compatible Plugin, please use projectId instead of\)| 
 | useBk | boolean |No|  useBK | 
 | enableExternal | boolean |No| Support the agent to access the external network| 
 | extra | string |No|  extra | 
 | routerTag | string |No| project route point to| 
 | id | integer |No| Primary Key ID| 
 | ccAppId | integer |No| CC serviceId| 
 | updatedAt | string |No| Change the time| 
 | approvalStatus | integer |No| Approve Status| 
 | approver | string |No| Approver| 
 | pipelineLimit | integer |No| Upper limit of Pipeline| 
 | centerId | string |No| Site ID| 
 | ccAppName | string |No| CC Business Name| 
 | creator | string |No| creator| 
 | kind | integer |No|  kind | 
 | cc\_app\_id | integer |No| Old Version serviceId\(will be obsolete soon, the old Field name referenced in compatible Plugin, please use ccAppId instead of\)| 
 | deptId | string |No| Department ID| 
 | approvalTime | string |No| Approve Time| 
 | project\_code | string |No| Old Version of project Code\(will be obsolete soon, the old Field name referenced in compatible Plugin, please use projectCode instead of\)| 
 | relationId | string |No| link system Id| 
 | logoAddr | string |No| Logo address| 
 | bgId | string |No| Business Group ID| 
 | offlined | boolean |No| Batch| 
 | hybridCcAppId | integer |No| Hybrid Cloud CC serviceId| 
 | bgName | string |No| Business Group Name| 
 | projectName | string |No| projectName| 
 | enableIdc | boolean |No| Support for IDC agent| 
 | projectId | string |No| Project ID| 
 | cc\_app\_name | string |No| Old Version CC Business Name\(will be obsolete soon, the old Field name referenced in compatible Plugin, please use ccAppName instead of\)| 
 | hybrid\_cc\_app\_id | integer |No| Hybrid Cloud CC serviceId\(will be obsolete soon. The old Field name referenced in the compatible Plugin, please use hybridCcAppId instead of\)| 
 | centerName | string |No| name of Center| 

