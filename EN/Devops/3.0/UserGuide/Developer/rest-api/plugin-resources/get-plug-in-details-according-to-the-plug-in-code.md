# Get plugin details based on Plugin Code 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/atoms/{atomCode} 

 ### Resource Description 

 #### Get Plug-in Details by Plugin Code 

 ### Input Parameters Description 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | atomCode | string |Yes| Plugin Code|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Wrapper model AtomVersion| 

 #### Request Sample 

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

### 返回样例-200

```javascript
{
  "data" : {
    "versionContent" : "String",
    "flag" : true,
    "modifier" : "String",
    "description" : "String",
    "language" : "String",
    "yamlFlag" : true,
    "atomId" : "String",
    "atomStatus" : "String",
    "initProjectCode" : "String",
    "codeSrc" : "String",
    "htmlTemplateVersion" : "String",
    "projectCode" : "String",
    "releaseType" : "String",
    "pkgName" : "String",
    "jobType" : "String",
    "atomType" : "String",
    "classifyName" : "String",
    "userCommentInfo" : {
      "commentFlag" : true,
      "commentId" : "String"
    },
    "summary" : "String",
    "recommendFlag" : true,
    "editFlag" : true,
    "creator" : "String",
    "defaultFlag" : true,
    "docsLink" : "String",
    "os" : "string",
    "updateTime" : "String",
    "privateReason" : "String",
    "version" : "String",
    "logoUrl" : "String",
    "atomCode" : "String",
    "labelList" : [ {
      "createTime" : 0,
      "labelType" : "String",
      "updateTime" : 0,
      "id" : "String",
      "labelName" : "String",
      "labelCode" : "String"
    } ],
    "createTime" : "String",
    "visibilityLevel" : "String",
    "frontendType" : "ENUM",
    "name" : "String",
    "repositoryAuthorizer" : "String",
    "publisher" : "String",
    "classifyCode" : "String",
    "category" : "String",
    "dailyStatisticList" : [ {
      "dailySuccessNum" : 0,
      "statisticsTime" : "String",
      "dailyFailNum" : 0,
      "dailyFailRate" : "parse error",
      "dailyDownloads" : 0,
      "totalDownloads" : 0,
      "dailySuccessRate" : "parse error",
      "dailyFailDetail" : {
        "string" : "string"
      }
    } ]
  },
  "message" : "String",
  "status" : 0
}
```

 ## Data Return Package model AtomVersion 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | AtomVersion |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## AtomVersion 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | versionContent | string |No| ChangeLog| 
 | flag | boolean |No| Can the logo be install| 
 | modifier | string |No| Revise by| 
 | description | string |No| Plugin description| 
 | language | string |No| Development language| 
 | yamlFlag | boolean |No| yaml can identify true: Yes, false: No| 
 | atomId | string |No| Plugin ID| 
 | atomStatus | string |Yes| Plugin status| 
 | initProjectCode | string |No| Plugin initialization project| 
 | codeSrc | string |No| Code Repository link| 
 | htmlTemplateVersion | string |No| Front-end rendering templateVersion (1.0 represents the historical inventory Plugin rendering template version)| 
 | projectCode | string |No| Plugin Debug project| 
 | releaseType | string |No| Release Type| 
 | pkgName | string |No| Plugin package| 
 | jobType | string |No| Applicable Job type| 
 | atomType | string |No| Plugin type| 
 | classifyName | string |No| Plugin Doc Category Name| 
 | userCommentInfo |user review information| No| user review information| 
 | summary | string |No| summary to Plugin| 
 | recommendFlag | boolean |No| Is it Recommended to identify true: Recommended, false: not recommended| 
 | editFlag | boolean |No| edit| 
 | creator | string |No| creator| 
 | defaultFlag | boolean |No| Whether it is the default Plugin (default plug-in all projectVis) true: Default Plugin false: Normal plug-in| 
 | docsLink | string |No| link to Plugin documentation| 
 | os | List |No| The operating system| 
 | updateTime | string |No| Change the time| 
 | privateReason | string |No| Plugin Code Repository is not open source| 
 | version | string |No| versionNum| 
 | logoUrl | string |No| Logo address| 
 | atomCode | string |No| Plugin identification| 
 | labelList |List&lt; label Information&gt;|No| label List| 
 | createTime | string |No| creationTime| 
 | visibilityLevel | string |No| project visibility,PRIVATE: Private LOGIN\_PUBLIC: signIn user Open Source| 
 | frontendType | ENUM\(HISTORY, NORMAL, SPECIAL, \) |No| Front-end UI rendering method| 
 | name | string |No| Plugin name| 
 | repositoryAuthorizer | string |No| Plugin Code Repository Licensor| 
 | publisher | string |No| publisher| 
 | classifyCode | string |No| Plugin Service Classification code| 
 | category | string |No| Plugin category| 
 | dailyStatisticList |List&lt; Daily Statistics&gt;|No| Daily Statistics List| 

 ## user Comments 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | commentFlag | boolean |Yes| Have you commented true: Yes, false: No| 
 | commentId | string |No| Comment ID| 

 ## label Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | createTime | integer |No| Created at| 
 | labelType | string |Yes| category ATOM: Plugin TEMPLATE: Templates IMAGE: Mirroring IDE\_ATOM:IDE Plugins| 
 | updateTime | integer |No| Update date| 
 | id | string |Yes| label ID| 
 | labelName | string |Yes| Label Name| 
 | labelCode | string |Yes| label Code| 

 ## Daily Statistics 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | dailySuccessNum | integer |No| Number of SUCCEED per day| 
 | statisticsTime | string |No| Statistics time, format yyyy-MM-dd HH:mm:ss| 
 | dailyFailNum | integer |No| Number of fail per day| 
 | dailyFailRate | number |No| Daily fail Rate| 
 | dailyDownloads | integer |No| Daily download| 
 | totalDownloads | integer |No| Total download| 
 | dailySuccessRate | number |No| Daily Success rate| 
 | dailyFailDetail | object |No| Daily fail detail| 

