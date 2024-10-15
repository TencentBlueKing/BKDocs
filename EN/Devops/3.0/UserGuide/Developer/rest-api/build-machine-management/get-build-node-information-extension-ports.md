 # Get build Node information (API extension) 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/environment/projects/{projectId}/nodes/{nodeHashId}/listPipelineRef 

 ### Resource Description 

 #### Get the information of the build node (API for extension) 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | sortBy | string |Yes| order Field, pipelineName|  lastBuildTime | 
 | sortDirection | string |Yes| order Direction, ASC|  DESC | 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | nodeHashId | string |Yes| node hashId|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Wrapper model List Self hosted agent Pipeline Reference Information| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Please Replace the API Address bar Request Url]?  sortBy={sortBy}&amp;sortDirection={sortDirection}' \ 
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
  "data" : [ { 
    "pipelineName" : "String", 
    "jobName" : "String", 
    "jobId" : "String", 
    "agentId" : 0, 
    "vmSeqId" : "String", 
    "nodeHashId" : "String", 
    "nodeId" : 0, 
    "projectId" : "String", 
    "agentHashId" : "String", 
    "pipelineId" : "String", 
    "lastBuildTime" : "String" 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## data Return Package model List Self hosted agent Pipeline Reference Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |List&lt; Self hosted agent Pipeline reference information&gt;|No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Reference Information of Self hosted agent Pipeline 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineName | string |Yes| pipelineName| 
 | jobName | string |Yes|  Job Name | 
 | jobId | string |Yes|  Job ID | 
 | agentId | integer |Yes|  Agent ID | 
 | vmSeqId | string |Yes|  Vm Seq ID | 
 | nodeHashId | string |Yes|  Node Hash ID | 
 | nodeId | integer |Yes|  Node ID | 
 | projectId | string |Yes| Project ID| 
 | agentHashId | string |Yes|  Agent Hash ID | 
 | pipelineId | string |Yes| pipelineId| 
 | lastBuildTime | string |No| Last build time| 