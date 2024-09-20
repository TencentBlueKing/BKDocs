 # View build status information 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/pipelines/{pipelineId}/builds/{buildId}/status 

 ### Resource Description 

 #### View build status 

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
 | buildId | string |Yes| build ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper Model Historical Build Model with build var](view-build-status-information.md)| 

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
    "variables" : {
      "string" : "string"
    },
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
  },
  "message" : "String",
  "status" : 0
}
```

 ## Historical Construction Model with build var in data Return Wrapper Model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |[historical build model with build var](view-build-status-information.md)| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Historical Construction model with build var 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | buildNum | integer |Yes| buildNo| 
 | buildNumAlias | string |No| customize build versionNum| 
 | stageStatus |List&lt; [historical Build Phase status](view-build-status-information.md)&gt;|Yes| status of each Stage| 
 | remark | string |No| remark| 
 | buildMsg | string |No| build Information| 
 | startTime | integer |Yes| Starting Time| 
 | id | string |Yes| build ID| 
 | recommendVersion | string |No| recommendVersion| 
 | retry | boolean |No| retry or not| 
 | variables | object |Yes| build var Collection| 
 | totalTime | integer |No| Total time\(Second\)| 
 | webHookType | string |No|  WebHookType | 
 | mobileStart | boolean |No|  mobileStart | 
 | startType | string |No| Start Up type\(New\)| 
 | trigger | string |Yes| Trigger Conditions| 
 | userId | string |Yes| startUser| 
 | deleteReason | string |Yes| Reason for termination| 
 | queueTime | integer |No| queueTime| 
 | pipelineVersion | integer |Yes| file versionNum| 
 | buildParameters |List&lt; [build model-build Parameter](view-build-status-information.md)&gt;|No| Start Up Parameter| 
 | material |List&lt; [PipelineBuildMaterial](view-build-status-information.md)&gt;|No| raw material| 
 | currentTimestamp | integer |Yes| service Current Timestamp| 
 | artifactList |List&lt; [artifactory information](view-build-status-information.md)&gt;|No| artifactList| 
 | endTime | integer |Yes| End Time| 
 | webhookInfo | [WebhookInfo](view-build-status-information.md) |No|  webhookInfo | 
 | errorInfoList |List&lt; [Plugin Error Message](view-build-status-information.md)&gt;|No| Pipeline Task execute Error| 
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
 | properties |List&lt; [artifactory](view-build-status-information.md)&gt;|Yes| metaData| 
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