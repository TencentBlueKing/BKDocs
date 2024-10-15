 # Get the code commit record 

 ### Request Method/Request Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/repositoryCommit 

 ### Resource Description 

 #### Obtaining Code Submission Record 

 ### Input Parameter Description 

 #### Path parameter 

 | Parameter Name| parameter type| Must| Parameter Description| default value| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId| string| Yes| Project ID|| 
 | pipelineId| string| Yes| Pipeline ID|| 
 | buildId| string| Yes| buildID|| 

 #### Response 

 | HTTP code| Description| parameter type| 
 | :--- | :--- | :--- | 
 | 200| successful operation| [Data return wrapper model ListCommitResponse](get-the-code-submission-record.md)| 

 #### Request Sample 

 ```javascript 
 curl-X GET '[replace with API address bar request address]'\ 
 -H 'X-DEVOPS-UID:xxx' 
 ``` 

 #### HEADER Example 

 ```javascript 
 accept: application/json 
 Content-Type: application/json 
 X-DEVOPS-UID:xxx 
 ``` 

 ### Return Sample-200 

 ```javascript 
 { 
  "data" : [ { 
    "elementId" : "String", 
    "records" : [ { 
      "elementId" : "String", 
      "repoId" : "String", 
      "committer" : "String", 
      "commitTime" : 0, 
      "repoName" : "String", 
      "commit" : "String", 
      "buildId" : "String", 
      "comment" : "String", 
      "type" : 0, 
      "url" : "String", 
      "pipelineId" : "String" 
    } ], 
    "name" : "String" 
  } ], 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Wrapping Model ListCommitResponse 

 | Parameter Name| parameter type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data| List [CommitResponse](get-the-code-submission-record.md)&lt; No&gt; data| 否 | 数据 | 
 | message| string| No| error message| 
 | status| integer| Yes| status code| 

 ## CommitResponse 

 | Parameter Name| parameter type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | elementId| string| No| elementId| 
 | records| List [CommitData](get-the-code-submission-record.md)&lt; No&gt; records| 否 | records | 
 | name| string| No| name| 

 ## CommitData 

 | Parameter Name| parameter type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | elementId| string| No| elementId| 
 | repoId| string| No| repoId| 
 | committer| string| No| committer| 
 | commitTime| integer| No| commitTime| 
 | repoName| string| No| repoName| 
 | commit| string| No| commit| 
 | buildId| string| No| buildId| 
 | comment| string| No| comment| 
 | type| integer| No| type| 
 | url| string| No| url| 
 | pipelineId| string| No| pipelineId| 