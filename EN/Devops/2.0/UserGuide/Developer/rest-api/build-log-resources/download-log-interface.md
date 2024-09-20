 # downloadLog API 

 ## Method/Path 

 ### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/logs/download 

 ## Resource Description 

 ### API for downloadLog 

 ## Input Parameters Description 

 ### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | tag | string |No| Corresponding element ID|| 
 | jobId | string |No| Corresponding jobId|| 
 | executeCount | integer |No| Number of execute|| 

 ### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes, sir.| Project ID|| 
 | pipelineId | string |Yes, sir.| pipelineId|| 
 | buildId | string |Yes, sir.| build ID|| 

 ### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | default | successful operation | parse error | 

 ### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  tag={tag}&amp;jobId={jobId}&amp;executeCount={executeCount}' \ 
 -H 'X-DEVOPS-UID:xxx' 
 ``` 

 ### HEADER Sample 

 ```javascript 
 accept: application/json 
 Content-Type: application/json 
 X-DEVOPS-UID:xxx 
 ``` 