 # Create Project 

 ### Method/Path 

 #### POST  /ms/openapi/api/apigw/v3/projects 

 ### Resource Description 

 #### Create Project 

 ### Input Parameters Description 

 #### Body Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 
 | body |[project model](create-project.md)| Yes| Project information|| 

 #### Path Parameter 

 | variableName| Type| Must| Parameter Description| defaultValue| 
 | :--- | :--- | :--- | :--- | :--- | 


 #### Response 

 | HTTP Code| Description| Type| 
 | :--- | :--- | :--- | 
 | 200 | successful operation |[data Return Wrapper model Boolean](create-project.md)| 

 #### Request Sample 

 ```javascript 
 curl -X POST '[Replace with API Address bar Request Url]' \ 
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

 ## Project-new a model 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | englishName | string |No| englishName| 
 | deptName | string |No| name of secondary department| 
 | centerId | integer |No| Level 3 Dept. ID| 
 | secrecy | boolean |No| Confidentiality| 
 | kind | integer |No|  kind | 
 | projectType | integer |No| Project type| 
 | deptId | integer |No| Secondary Department ID| 
 | description | string |No| description| 
 | bgName | string |No| Name of One department| 
 | projectName | string |No| projectName| 
 | bgId | integer |No| One Dept. ID| 
 | centerName | string |No| name of Level 3 Department| 

 ## Data Return Package model Boolean 

 | variableName| Type| Must| Parameter Description| 
 | :--- | :--- | :--- | :--- | 
 | data | boolean |No| data| 
 | message | string |No| Error Message| 
 | status | integer |Yes| Status Code| 