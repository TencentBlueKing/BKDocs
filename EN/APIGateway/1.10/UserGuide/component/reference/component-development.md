# Component class development

Custom component classes must inherit from the `components.component.Component` class, which provides some public data or methods to assist component development.

Custom component classes mainly need to define the following parts:
- Class name: It is formed by removing the underscore (\_) from the English name of the component and converting the first letters of each word to uppercase. For example, the class name of the component get_host_list should be GetHostList.
- Class attribute sys_name: the English name of the system to which the component belongs, associating the component with the system
- Internal class Form: Django Form, optional, used to verify request parameters
- Class method handle: component processing entry

## Inner class Form

The internal class Form, that is, Django Form, inherits from `common.forms.BaseComponentForm` and is used to verify request parameters. The example is as follows:

```python
from common.forms import BaseComponentForm, DefaultBooleanField, ListField, TypeCheckField
from components.component import Component


class MyComponent(Component):

     class Form(BaseComponentForm):
         ip_list = TypeCheckField(label="ip list", promise_type=list, required=False)
         is_public = DefaultBooleanField(label="is public", default=True)
         maintainers = ListField(label="maintainers", required=True)

         #The data returned by the clean method can be obtained through the form_data attribute of the component
         def clean(self):
             return self.get_cleaned_data_when_exist()
```

In the common.forms module of the project, several commonly used Fields are defined:

- ListField: List Field, which can convert strings separated by commas, semicolons, newlines, and spaces into lists. For example, "123;456;789" can be converted into ["123", "456", "789"]
- TypeCheckField: Type detection Field. By setting the promise_type parameter, the type of data is detected. If the type does not match, an exception is thrown.
- DefaultBooleanField: Default Boolean Field, Boolean data can set the default value through the default parameter


## Class method handle

The class method handle is the processing entry point of the component class. In this method, you can get the request parameters, request the backend interface, and set the response content of the component.

### Get request information

In the method handle, you can get the information of the current request
- self.form_data: data after component customization Form clean
- self.request.kwargs: The current request parameters, QueryString data in the GET request or Request Body data in the POST request, have been converted to dict
- self.request.request_id: the request ID of the current request, different request IDs are different
- self.request.app_code: the application ID of the current request (i.e., the bk_app_code of the application in the BlueKing Developer Center)
- self.current_user.username: the username of the current requesting user

### Request backend interface

If you need to request the backend interface in a component, you can use the built-in `outgoing.http_client`, whose interface protocol is

```python
self.outgoing.http_client.request(
     method,
     host,
     path,
     params=None,
     data=None,
     headers={},
     #response_type: json, whether the interface data needs to be converted into a JSON dictionary, and others will not be converted
     response_type="json",
     # max_retries: 0, the number of retries when the interface request is abnormal
     max_retries=0,
     # response_encoding: The interface return data is transcoded to this type
     response_encoding=None,
     # request_encoding: Request interface parameters are transcoded to this type
     request_encoding=None,
     verify=False,
     cert=None,
     timeout=None
)
```

Simplified get/post methods can also be used
```python
# means request("GET", *args, **kwargs)
self.outgoing.http_client.get(*args, **kwargs)

# means request("POST", *args, **kwargs)
self.outgoing.http_client.post(*args, **kwargs)
```

### Call other components within a component

invoke_other method, the current user current_user will be passed to the called component

```python
result = self.invoke_other("generic.cc.get_biz_by_id", kwargs={"bk_biz_id": 1})
```

Direct calling method

```python
from esb.components.generic.apis.cc.get_biz_by_id import GetBizById

result = GetBizById().invoke(kwargs={"bk_biz_id": 1})
```

### Set component response

In the component handle method, you need to explicitly set the response content of the component

```python
#Set the component to return the result. The payload content is the actual response result of the component.
self.response.payload = result
```