# API documentation

All APIs of the platform have been connected to the BlueKing Unified Gateway API Gateway. Visit `http://<BK_PAAS_HOST>/esb/api_docs/system/` to view the documentation.

## Authentication method
DataAPI currently supports two authentication methods, and authentication information needs to be added to the request parameters.

### User mode

User mode is to pass authentication information that can prove the user's identity. Please follow the ESB component calling instructions for the parameter passing method.

- Example of user mode parameters:

```json
{
   "bk_app_code": "xxxx",
   "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
   "bkdata_authentication_method": "user",
   "bk_username": "jeeeeee",
   "bk_token": "P8ZEfxOfT0uLWHdnzLp5E3r8_896f3yqlUNbwaaaskA"
}
```

### Authorization code mode
Authorization code mode currently only supports data query and data subscription. For specific application methods, please see the ["Authorization Management"](../user-guide/auth-management/token.md) guide.

- Parameter examples of authorization code mode:

```json
{
     "bk_app_code": "xxxx",
     "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
     "bkdata_authentication_method": "token",
     "bkdata_data_token": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

## How to call DataAPI

Currently, DataAPI is not encapsulated in the ESB SDK, and the ESB client cannot be used to request the interface. You can directly request the interface through the HTTP request sample.

- GET request sample

```python
def send_request():
      response = requests.get(
         url="http://<BK_PAAS_HOST>/api/c/compapi/data/v3/meta/projects/1/",
         params={
             "bk_app_code": "xxxx",
             "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
             "bkdata_authentication_method": "user",
             "bk_username": "jeeeeee",
             "bk_token": "P8ZEfxOfT0uLWHdnzLp5E3r8_896f3yqlUNbwaaaskA"
         }
     )
     print('Response HTTP Status Code: {status_code}'.format(status_code=response.status_code))
     print('Response HTTP Response Body: {content}'.format(content=response.content))
```

- POST request sample, similar to PUT and DELETE

```python
def send_request():
      response = requests.post(
         url="http://<BK_PAAS_HOST>/api/c/compapi/data/v3/meta/projects/",
         headers={
             "Content-Type": "application/json; charset=utf-8",
         },
         data=json.dumps({
             "bk_app_code": "xxxx",
             "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
             "bkdata_authentication_method": "user",
             "bk_username": "jeeeeee",
             "bk_token": "P8ZEfxOfT0uLWHdnzLp5E3r8_896f3yqlUNbwaaaskA",

             "project_name": "Test project",
             "description": "test"
         })
     )
     print('Response HTTP Status Code: {status_code}'.format(status_code=response.status_code))
     print('Response HTTP Response Body: {content}'.format(content=response.content))

```

## Call API to query data

In order to ensure data security, the query data interface currently only supports authorization code mode. If a third-party platform wishes to use user mode, please contact the platform assistant to add a whitelist.

- Specific calling examples

```python
# Install the Python Requests library:
# `pip install requests`

import requests
import json

def send_request():
     # Request Duplicate (2)
     # POST http://<BK_PAAS_HOST>/api/c/compapi/data/v3/dataquery/query/

     try:
         response = requests.post(
             url="http://<BK_PAAS_HOST>/api/c/compapi/data/v3/dataquery/query",
             headers={
                 "Content-Type": "application/json; charset=utf-8",
             },
             data=json.dumps({
                 "bkdata_authentication_method": "token",
                 "bkdata_data_token": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                 "bk_app_code": "xxxx",
                 "bk_app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                 "sql": "select dteventtimestamp as ts,count from 111_jeee_set_login where thedate=20160920 AND cc_set='303' AND biz_id='111' limit 1",
                 "prefer_storage": ""
             })
         )
         print('Response HTTP Status Code: {status_code}'.format(
             status_code=response.status_code))
         print('Response HTTP Response Body: {content}'.format(
             content=response.content))
     except requests.exceptions.RequestException:
         print('HTTP Request failed')
```