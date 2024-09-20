 # Get file based on metaData 

 ### Method/Path 

 #### GET  /ms/openapi/api/apigw/v3/projects/{projectId}/artifactories 

 ### Resource Description 

 #### Obtain file based on metaData 

 ### Input Parameters Description 

 #### Query Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | pipelineId | string |Yes| pipelineId|| 
 | buildId | string |Yes| build ID|| 
 | page | integer |No| Page number|  1 | 
 | pageSize | integer |No| Number of entries per page\(if not passed, All will be Return by default\)|  20 | 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |data Return Wrapper model Paging Data Wrapper Model artifactory-file Info| 

 #### Request Sample 

 ```javascript 
 curl -X GET '[Replace with API Address bar Request Url]?  pipelineId={pipelineId}&amp;buildId={buildId}&amp;page={page}&amp;pageSize={pageSize}' \ 
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
    "records" : [ { 
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
    "count" : 0, 
    "totalPages" : 0, 
    "pageSize" : 0, 
    "page" : 0 
  }, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Data Return Wrapper model Pagination Data Wrapper Model artifactory-file Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data |Paged data Wrapper Model artifactory-file Info| No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 

 ## Paged data Packaging Model artifactory-file Information 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | records |List&lt; artifactory-file Info&gt;|Yes| data| 
 | count | integer |Yes| Total number of record lines| 
 | totalPages | integer |Yes| How many pages total| 
 | pageSize | integer |Yes| How many items per page| 
 | page | integer |Yes| Page number| 

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
 | properties |List&lt; artifactory-metaData&gt;|Yes| metaData| 
 | md5 | string |No|  MD5 | 

 ## Artifactory-metaData 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | value | string |Yes| metaData value| 
 | key | string |Yes| metaData key| 