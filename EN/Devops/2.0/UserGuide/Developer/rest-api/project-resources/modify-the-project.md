 # Revise the project 

 ### Method/Path 

 #### PUT  /ms/openapi/api/apigw/v3/projects/{projectId} 

 ### Resource Description 

 #### Revise project 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[project model](modify-the-project.md)| Yes| Project information|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | projectId | string |Yes| Project ID|| 

 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](modify-the-project.md)| 

 #### Request Sample 

 ```javascript 
 curl -X PUT '[Replace with API Address bar Request Url]' \ 
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
  "data" : true, 
  "message" : "String", 
  "status" : 0 
 } 
 ``` 

 ## Project-Revise model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | centerId | integer |No| Site ID| 
 | deptName | string |No| Department name| 
 | englishName | string |No| englishName| 
 | ccAppName | string |No|  cc app name | 
 | kind | integer |No| Container select, 0 is not selected, 1 is k8s, 2 is mesos| 
 | projectType | integer |No| Project type| 
 | deptId | integer |No| Department ID| 
 | description | string |No| description| 
 | bgId | integer |No| Business Group ID| 
 | secrecy | boolean |No| Confidentiality| 
 | bgName | string |No| Business Group Name| 
 | projectName | string |No| projectName| 
 | ccAppId | integer |No|  cc app id | 
 | centerName | string |No| name of Center| 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 