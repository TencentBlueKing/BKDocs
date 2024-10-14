 # Get Pipeline build history 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/history 

 ### Resource Description 

 #### Obtaining Pipeline build History 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | page | integer |No| Page number|  1 | 
 | pageSize | integer |No| How many items per page|  20 | 
 | channelCode | string |No| Channel number, default to BS|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 
 | pipelineId | string |Yes| pipelineId|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model build History-Paged Data Wrapper Model History Construction Model](get-pipeline-construction-history.md)| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  page={page}&amp;pageSize={pageSize}&amp;channelCode={channelCode}' \ 
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
    "pipelineVersion" : 0,
    "records" : [ {
      "buildNum" : 0,
      "buildNumAlias" : "String",
      "stageStatus" : [ {
        "name" : "String",
        "stageId" : "String"
      } ],
      "remark" : "String",
      "buildMsg" : "String",
      "startTime" : 0,
      "id" : "String",
      "recommendVersion" : "String",
      "retry" : true,
      "totalTime" : 0,
      "webHookType" : "String",
      "mobileStart" : true,
      "startType" : "String",
      "trigger" : "String",
      "userId" : "String",
      "deleteReason" : "String",
      "queueTime" : 0,
      "pipelineVersion" : 0,
      "buildParameters" : [ {
        "valueType" : "ENUM",
        "readOnly" : true,
        "value" : {
          "string" : "string"
        },
        "key" : "String"
      } ],
      "material" : [ {
        "newCommitId" : "String",
        "aliasName" : "String",
        "commitTimes" : 0,
        "branchName" : "String",
        "url" : "String",
        "newCommitComment" : "String"
      } ],
      "currentTimestamp" : 0,
      "artifactList" : [ {
        "fullPath" : "String",
        "modifiedTime" : 0,
        "appVersion" : "String",
        "shortUrl" : "String",
        "downloadUrl" : "String",
        "fullName" : "String",
        "path" : "String",
        "folder" : true,
        "size" : 0,
        "name" : "String",
        "artifactoryType" : "ENUM",
        "properties" : [ {
          "value" : "String",
          "key" : "String"
        } ],
        "md5" : "String"
      } ],
      "endTime" : 0,
      "webhookInfo" : {
        "webhookBranch" : "String",
        "webhookEventType" : "String",
        "webhookMessage" : "String",
        "webhookMergeCommitSha" : "String",
        "webhookRepoUrl" : "String",
        "webhookCommitId" : "String",
        "webhookType" : "String"
      },
      "errorInfoList" : [ {
        "atomCode" : "String",
        "errorType" : 0,
        "errorCode" : 0,
        "taskName" : "String",
        "taskId" : "String",
        "errorMsg" : "String"
      } ],
      "status" : "String",
      "executeTime" : 0
    } ],
    "count" : 0,
    "totalPages" : 0,
    "pageSize" : 0,
    "page" : 0,
    "hasDownloadPermission" : true
  },
  "message" : "String",
  "status" : 0
}
```

 ## Data Return Wrapper model build History-Paged Data Wrapper Model History Construction Model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[build History-Paginated data Wrapper model History Build Model](get-pipeline-construction-history.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Build History-Paged data Wrapping model History Construction Model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | pipelineVersion | integer |Yes| The latest pipelineVersion| 
 | records |List&lt; [historical build model](get-pipeline-construction-history.md)&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 
 | hasDownloadPermission | boolean |Yes| Do you have auth to download build| 

 ## Historical build model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | buildNum | integer |Yes| buildNo| 
 | buildNumAlias | string |No| customize build versionNum| 
 | stageStatus |List&lt; [historical Build Phase status](get-pipeline-construction-history.md)&gt;|Yes| status of each Stage| 
 | remark | string |No| remark| 
 | buildMsg | string |No| build Information| 
 | startTime | integer |Yes| Starting Time| 
 | id | string |Yes| build ID| 
 | recommendVersion | string |No| recommendVersion| 
 | retry | boolean |No| retry or not| 
 | totalTime | integer |No| Total time\(Second\)| 
 | webHookType | string |No|  WebHookType | 
 | mobileStart | boolean |No|  mobileStart | 
 | startType | string |No| Start Up type\(New\)| 
 | trigger | string |Yes| Trigger Conditions| 
 | userId | string |Yes| startUser| 
 | deleteReason | string |Yes| Reason for termination| 
 | queueTime | integer |No| queueTime| 
 | pipelineVersion | integer |Yes| file versionNum| 
 | buildParameters |List&lt; [build model-build Parameter](get-pipeline-construction-history.md)&gt;|No| Start Up Parameter| 
 | material |List&lt; [PipelineBuildMaterial](get-pipeline-construction-history.md)&gt;|No| raw material| 
 | currentTimestamp | integer |Yes| service Current Timestamp| 
 | artifactList |List&lt; [artifactory information](get-pipeline-construction-history.md)&gt;|No| artifactList| 
 | endTime | integer |Yes| End Time| 
 | webhookInfo | [WebhookInfo](get-pipeline-construction-history.md) |No|  webhookInfo | 
 | errorInfoList |List&lt; [Plugin Error Message](get-pipeline-construction-history.md)&gt;|No| Pipeline Task execute Error| 
 | status | string |Yes| status| 
 | executeTime | integer |No| Run totalTime\(Second, excluding manual approvalTime\)| 

 ## Historical Build Phase status 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | name | string |Yes| Stage name| 
 | stageId | string |Yes| Stage ID| 

 ## Build model-Building Parameter 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | valueType | ENUM\(STRING, TEXTAREA, ENUM, DATE, LONG, BOOLEAN, SVN\_TAG, GIT\_REF, MULTIPLE, CODE\_LIB, CONTAINER\_TYPE, ARTIFACTORY, SUB\_PIPELINE, CUSTOM\_FILE, PASSWORD, TEMPORARY, \) |No| Element value type| 
 | readOnly | boolean |No| Read Only| 
 | value | object |Yes| Element value name-for Display| 
 | key | string |Yes| Element Value ID-Identifier| 

 ## PipelineBuildMaterial 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | newCommitId | string |No|  newCommitId | 
 | aliasName | string |No|  aliasName | 
 | commitTimes | integer |No|  commitTimes | 
 | branchName | string |No|  branchName | 
 | url | string |No|  url | 
 | newCommitComment | string |No|  newCommitComment | 

 ## Artifactory-file Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | fullPath | string |Yes| full file path| 
 | modifiedTime | integer |Yes| updateTime| 
 | appVersion | string |Yes| appVersions| 
 | shortUrl | string |Yes| download Short link| 
 | downloadUrl | string |No| downloadLink| 
 | fullName | string |Yes| Full Name of file| 
 | path | string |Yes| file path| 
 | folder | boolean |Yes| file| 
 | size | integer |Yes| filesize\(byte\)| 
 | name | string |Yes| fileName| 
 | artifactoryType | ENUM\(PIPELINE, CUSTOM\_DIR, \) |Yes| repoType| 
 | properties |List&lt; [artifactory](get-pipeline-construction-history.md)&gt;|Yes| metaData| 
 | md5 | string |No|  MD5 | 

 ## Artifactory-metaData 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |Yes| metaData value| 
 | key | string |Yes| metaData key| 

 ## WebhookInfo 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | webhookBranch | string |No|  webhookBranch | 
 | webhookEventType | string |No|  webhookEventType | 
 | webhookMessage | string |No|  webhookMessage | 
 | webhookMergeCommitSha | string |No|  webhookMergeCommitSha | 
 | webhookRepoUrl | string |No|  webhookRepoUrl | 
 | webhookCommitId | string |No|  webhookCommitId | 
 | webhookType | string |No|  webhookType | 

 ## Plugin Error Message 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | atomCode | string |No| Plugin Number| 
 | errorType | integer |No| Error Type| 
 | errorCode | integer |Yes| Error Code| 
 | taskName | string |No| Plugin name| 
 | taskId | string |No| Plugin ID| 
 | errorMsg | string |No| Error Message| 

