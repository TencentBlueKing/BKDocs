# API 使用示例

本章中将使用**OPNEAPI-项目资源**中的**获取项目信息、创建项目、修改项目**三个API，示例如何通过Curl或Python去使用API。

## **Curl示例**

1、access_token 需替换成自己获取到的口令

2、POST、PUT 等需要携带body的API，body是必需的。如果body中都是非必要参数，可以传一个空的body，例如： -d '{}'

3、API 中的 {projectId}等参数，需要自行替换为相应的名称

---

**GET获取项目信息**

```bash
curl -X GET http://devops.bktencent.com/ms/openapi/api/apigw/v3/projects/demo?access_token=%2BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%2B7%2BTZihy1Tg5iLj5Gsj%2FdCC51MakqW0UGQ%3D%3D -H "accept: application/json" -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin"
```



**POST创建项目**

```bash
curl -X POST http://devops.bktencent.com//ms/openapi/api/apigw/v3/projects?access_token=%252BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%252B7%252BTZihy1Tg5iLj5Gsj%252FdCC51MakqW0UGQ%253D%253D -H "accept: application/json" -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin" -d '{"englishName":"apitest","deptName":"apitest","centerId":0,"secrecy":false,"kind":0,"projectType":0,"deptId":0,"description":"apitest","bgName":"apitest","projectName":"apitest"}'
```



**PUT修改项目**

```bash
curl -X PUT http://devops.bktencent.com//ms/openapi/api/apigw/v3/projects/apitest2?access_token=%252BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%252B7%252BTZihy1Tg5iLj5Gsj%252FdCC51MakqW0UGQ%253D%253D -H "accept: application/json" -H "Content-Type: application/json" -H "X-DEVOPS-UID: admin" -d '{"englishName":"apitest2","deptName":"apitest2","centerId":0,"secrecy":false,"kind":0,"projectType":0,"deptId":0,"description":"apitest2","bgName":"apitest2","projectName":"apitest2"}'
```





## **Python示例**

1、access_token 需替换成自己获取到的口令

2、POST、PUT 等需要携带body的API，body是必需的。如果body中都是非必要参数，可以传一个空的body，例如： body={}

3、API 中的 {projectId}等参数，需要自行替换为相应的名称

---

**GET获取项目信息**

```python
import requests

# CI域名
hostname = "http://devops.bktencent.com/"
# API 地址
api_url = "/ms/openapi/api/apigw/v3/projects/demo"
# 获取到的 token 口令
token = "%2BxeaZC44Jt0tCbF5a3ZglMOvBxROaHtKLbFBrJsZp9KC4QhcsQwX%2B7%2BTZihy1Tg5iLj5Gsj%2FdCC51MakqW0UGQ%3D%3D"
url = hostname + api_url
params = {'access_token': token}
headers = {"Content-Type": "application/json",
           "accept": "application/json",
           "X-DEVOPS-UID": "admin"}
r = requests.get(url, headers=headers, params=params)
print(r.text)
```



**POST创建项目**

```python
import requests

# CI域名
hostname = "http://devops.bktencent.com/"
# API 地址
api_url = "/ms/openapi/api/apigw/v3/projects"
# token 口令
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



**PUT修改项目**

```python
import requests

# CI域名
hostname = "http://devops.bktencent.com/"
# API 地址
api_url = "/ms/openapi/api/apigw/v3/projects/apitest"
# token 口令
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

