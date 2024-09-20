# How to set alarm callback

Alarm callback is a frequently used method of linking with other systems and performing secondary processing. Generally, the callback services are on the same platform. Most strategies in the industry will include alarm callbacks when notifying, so it needs to be done every time. Configure each alarm policy. If the callback service changes on any day, changes will need to be made in batches, resulting in higher maintenance costs. The HTTP callback for processing packages can be reused very simply.
![](media/16616757408656.jpg)


## Processing package-HTTP callback function description

### Parameters

Parameters (Params): Write the parameters required for the request. For example, adding username will generate a request for URL+?username=jack. Variables can be used for the value part.

Request method GET: default

Request method POST

* Certification: No certification
* Header information: Content-type:application/json
*Body: The format is JSON content variable, and the complete alarm data can be referenced through the variable ``
* Settings: timeout 10s, retry interval 2s, retry 2 times
![](media/16616757684576.jpg)

### Certification

Authentication (Authorization): This can be set when the requested target address requires authentication.

* No Auth requires no authentication: By default, "No Auth" does not require authentication.
* Bearer Token: Bearer Token is a security token. Any user with a Bearer Token can use it to access data resources without using encryption keys
* Basic Auth: Fill in username and password
![](media/16616758051575.jpg)


### Header information

Headers: The header information of the request can be set according to the requirements of the target address, and can also be supplemented with certain linkage with the main information.

Correspondence between content-type and body

POST parameter format | Content-Type | Parameter example
---|---|---
Form submission | application/x-www-form-urlencoded | username=jack&password=123
JSON submission | application/json | {"username":"jack","password":"123"}
XML submission | text/xml| <?xml version="1.0" encoding="utf-8"?><book>< title>xxxx</title></book>

![](media/16616758612179.jpg)

### Subject

Body: The body information of the request, which is generally used in POST. The format of the subject has a corresponding relationship with Content-Type and will be set automatically. Variables can be used in the content section. See the documentation for more information.
![](media/16616758698875.jpg)

### set up

Setting: Relevant settings for the requested action.

![](media/16616758862767.jpg)


## Use case-WeChat group custom robot

See the document for details [Case: WeChat Group Custom Robot](./solutions_http_callback_case1.md)