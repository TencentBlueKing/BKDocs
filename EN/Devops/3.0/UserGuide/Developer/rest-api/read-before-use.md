 # Read before using 

 ## Return value

 | Return value| implication| 
 | :--- | :--- | 
 | `200 OK` |operateSuc| 
 | `201 Created` |Create succeeded| 
 | `400 Bad Request` |Parameter Error or parameter format error| 
 | `401 Unauthorized` |Authentication failed| 
 | `403 Forbidden` |The account does not have auth for The Operation or the settings do not Allow this operation| 
 | `404 Not Found` |The Resource not exist, or the account may not have auth for The project (to prevent hackers from accessing the library list)| 
 | `405 Method Not Allowed` |No The interface| 
 | `409 Conflict` |Conflict with hasExisted Object/content or Operation behavior conflicts with rule| 
 | `422 Unprocessable` |Operation cannot be performed| 
 | `423 Locked` |Account is locked, or api Request frequency exceeds limit| 
 | `429 Too Many Requests` |Request is current limited| 
 | `500 Server Error` |service Error| 



 ## enable acces_token authentication

 Note: Access_token authentication is not required to enable the API.  The certification is One Safety measure and is recommended to be enable.  If it is not enable, you can make API Request without carrying access_token. 

 enable authentication, you need to Revise the setting file first. You can obtain the password only after enabling access_Token authentication. signIn the CI service and edit the content of the accessToken section under the Auth section of the configuration file/data/bkce/etc/ci/common.yml. 

 Set enabled to true, secret to any string, expirationTime to expireDate in ms. 

 example are as follows 

 ``` 
  accessToken: 
    enabled: true 
    secret: ea0950b9-79e3-4193-8bf3-1f22856ca075 
    expirationTime: 86400000 
 ``` 



 ![image-20220707143212672](<../../assets/common.yml_demo.png>) 



 After Revise, you need to restart the corresponding service 

 ``` 
 systemctl restart bkci-auth.service 
 systemctl restart bkci-openapi.service 
 ``` 





 ## Authentication Method

 Authentication is required for each API call. Please carry the access_Token in the query Parameter. The access_Token can be obtained approve calling the API/ms/Auth/api/user/token/get. 



 **example of accessToken** 

 Get it from https://{domain}/ms/Auth/api/user/token/get 

 The Return example is as follows. 

 ```javascript 
 { 
    "userId" : "testUserId", 
    "expirationTime" : 1630565380912, 
    "accessToken" : "PryTxowDezaM6u1QE1KDeZXiDH%2Bayb%2BabHZHOYLR8%2B8Md9QhAXrUrs2z3U4%2FZ3p9CvP4ObZjZJJ2VdNWQqgX3qeQ1TBK7ADhNXRVWn4q2Q0%3D" 
 } 

 If present: 
 {"status": 401,"data":"","result":true,"message":"user auth validation failed.  "} 
 Please signIn BK-CI first 
 ``` 



 **API Request Example** 

 Header information X-DEVOPS-UID needs to be append: username 

 ```javascript 
 GET https://{domainname/ip}/ms/openapi/api/apigw/v3/projects?  access_token=PryTxowDezaM6u1QE1KDeZXiDH%2Bayb%2BabHZHOYLR8%2B8Md9QhAXrUrs2z3U4%2FZ3p9CvP4ObZjZJJ2VdNWQqgX3qeQ1TBK7ADhNXRVWn4q2Q0%3D -H "X-DEVOPS-UID: admin" 

 1)If present: 
 Verification failed : Error: Access token expired in: 1630919127633 
 Please Generate because the access_token expired. 
 2)If present: 
 Request accessToken is empty. 
 Check whether access_token is carried in the query Parameter 
 3)If present: 
 verification failed : Invalid token Parameter Error: Access token illegal 
 Please check that access_token is Input correctly 
 ``` 