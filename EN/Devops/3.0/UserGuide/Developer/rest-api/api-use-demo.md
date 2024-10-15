 # API example 

 In this chapter, you will use **Get Project information, Create Project, and Revise Project** Three APIs in **OPNEAPI-project resources** to example how to use APIs approve Curl or Python. 

 ## Curl example 

 1. The access_token needs to be Replace with the password obtained by yourself 

 2. POST, PUT and other APIs that need to carry Body, the body is required.  If the Body is full of unnecessary Parameter, you can pass One empty body, for example: -d '{}' 

 3. Parameter such as {projectId} in the API need to be Replace with corresponding name 

 --- 

 **GET Project information** 

 ```bash 
 curl -X GET http://devops.bktencent.com/ms/openapi/api/apigw/v3/projects/demo?  access_token=%2BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%2B7%2BTZihy1Tg5iLj5Gsj%2FdCC51MakqW0UGQ%3D%3D -H "accept: application/json" -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin" 
 ``` 



 **POST Create Project** 

 ```bash 
 curl -X POST http://devops.bktencent.com//ms/openapi/api/apigw/v3/projects?  access_token=%252BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%252B7%252BTZihy1Tg5iLj5Gsj%252FdCC51MakqW0UGQ%253D%253D -H "accept: application/json" -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin" -d '{"englishName":"apitest","deptName":"apitest","centerId":0,"secrecy":false,"kind":0,"projectType":0,"deptId":0,"description":"apitest","bgName":"apitest","projectName":"apitest"}' 
 ``` 



 **PUT Revise project** 

 ```bash 
 curl -X PUT http://devops.bktencent.com//ms/openapi/api/apigw/v3/projects/apitest2?  access_token=%252BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%252B7%252BTZihy1Tg5iLj5Gsj%252FdCC51MakqW0UGQ%253D%253D -H "accept: application/json" -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin" -d '{"englishName":"apitest2","deptName":"apitest2","centerId":0,"secrecy":false,"kind":0,"projectType":0,"deptId":0,"description":"apitest2","bgName":"apitest2","projectName":"apitest2"}' 
 ``` 





 ## Python example 

 1. The access_token needs to be Replace with the password obtained by yourself 

 2. POST, PUT and other APIs that need to carry Body, the body is required.  If the Body is full of unnecessary Parameter, you can pass One empty body, for example: body={} 

 3. Parameter such as {projectId} in the API need to be Replace with corresponding name 

 --- 

 ** GET Project information** 

 ```python 
 import requests 

 # CI Domain Name 
 hostname = "http://devops.bktencent.com/" 
 # API Address 
 api_url = "/ms/openapi/api/apigw/v3/projects/demo" 
 #Obtained token password 
 token = "%2BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%2B7%2BTZihy1Tg5iLj5Gsj%2FdCC51MakqW0UGQ%3D%3D" 
 url = hostname + api_url 
 params = {'access_token': token} 
 headers = {"Content-Type": "application/json", 
           "accept": "application/json", 
           "X-DEVOPS-UID": "admin"} 
 r = requests.get(url, headers=headers, params=params) 
 print(r.text) 
 ``` 



 **POST Create Project** 

 ```python 
 import requests 

 # CI Domain Name 
 hostname = "http://devops.bktencent.com/" 
 # API Address 
 api_url = "/ms/openapi/api/apigw/v3/projects" 
 # token password 
 token = "%2BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%2B7%2BTZihy1Tg5iLj5Gsj%2FdCC51MakqW0UGQ%3D%3D" 
 url = hostname + api_url 
 body = { 
    "englishName": "apitest", 
    "deptName": "apitest", 
    "centerId": 0, 
    "secrecy": False, 
    "kind": 0, 
    "projectType": 0, 
    "deptId": 0, 
    "description": "apitest", 
    "bgName": "apitest", 
    "projectName": "apitest", 
    "bgId": 0, 
    "centerName": "apitest" 
 } 
 params = { 
    'access_token': token 
 } 
 headers = {"Content-Type": "application/json", 
           "accept": "application/json", 
           "X-DEVOPS-UID": "admin"} 
 r = requests.post(url=url, json=body, headers=headers, params=params) 
 print(r.text) 
 ``` 



 **PUT Revise project** 

 ```python 
 import requests 

 # CI Domain Name 
 hostname = "http://devops.bktencent.com/" 
 # API Address 
 api_url = "/ms/openapi/api/apigw/v3/projects/apitest" 
 # token password 
 token = "%2BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%2B7%2BTZihy1Tg5iLj5Gsj%2FdCC51MakqW0UGQ%3D%3D" 
 url = hostname + api_url 
 body = { 
    "englishName": "apitest2", 
    "deptName": "apitest2", 
    "centerId": 0, 
    "secrecy": False, 
    "kind": 0, 
    "projectType": 0, 
    "deptId": 0, 
    "description": "apitest2", 
    "bgName": "apitest2", 
    "projectName": "apitest2", 
 } 
 params = { 
    'access_token': token 
 } 
 headers = {"Content-Type": "application/json", 
           "accept": "application/json", 
           "X-DEVOPS-UID": "admin"} 
 r = requests.put(url=url, json=body, headers=headers, params=params) 
 print(r.text) 
 ``` 