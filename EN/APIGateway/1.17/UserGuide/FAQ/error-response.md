# Gateway error response description

[toc]

## Preface

> Link: Caller -> APIGateway -> Backend Service

The current gateway error response protocol is

```json
{
"code_name": "",
"data": null,
"code": 16xxxxx,
"message": "",
"result": false
}
```

If the response body is not this protocol, then the response is returned by the `backend service`. If you have any questions about the response, you need to find the corresponding **gateway person in charge**

The following is a detailed description of the gateway error response, which can be found by status code or keyword

## status: 400

### app code cannot be empty

```json
{
"code": 1640001,
"data": null,
"code_name": "INVALID_ARGS",
"message": "Parameters error [reason=\"app code cannot be empty\"]",
"result": false
}
```- Reason: No `X-Bkapi-Authorization` header is provided or `bk_app_code` is not included in the `X-Bkapi-Authorization` header
- Solution: Provide `X-Bkapi-Authorization` header and include `bk_app_code`

Others:
- `app code cannot be longer than 32 characters`: The passed `bk_app_code` is wrong, and the length of the normally issued `bk_app_code` will not exceed 32
- `app secret cannot be longer than 128 characters`: The passed `bk_app_secret` is wrong, and the length of the normally issued `bk_app_secret` will not exceed 128

### please provide bk_app_secret or bk_signature to verify app

```json
{
"code": 1640001,
"data": null,
"code_name": "INVALID_ARGS",
"message": "Parameters error [reason=\"please provide bk_app_secret or bk_signature to verify app\"]",
"result": false
}
```

- Reason: `bk_app_secret` is not in `X-Bkapi-Authorization` header
- Solution: `bk_app_secret` is included in `X-Bkapi-Authorization` header

### bk_app_code or bk_app_secret is incorrect

```json
{
"code": 1640001,
"data": null,
"code_name": "INVALID_ARGS",
"message": "Parameters error [reason=\"bk_app_code or bk_app_secret is incorrect\"]",
"result": false
}
```

- Reason: `bk_app_code + bk_app_secret` verification failed, illegal
- Processing: Confirm that the `bk_app_code / bk_app_secret` in the request header is legal and consistent with the one issued by the BlueKing PaaS platform or operation and maintenance

### user authentication failed, please provide a valid user identity, such as bk_username, bk_token, access_token

```json
{
"code": 1640001,
"data": null,
"code_name": "INVALID_ARGS",
"message": "Parameters error [reason=\"user authentication failed, please provide a valid user identity, such as bk_username, bk_token, access_token\"]",
"result": false
}
```

- Reason:
- No `X-Bkapi-Authorization` header is provided
- The header does not contain `bk_token` or `access_token`
- `bk_token` is illegal (Will go to BlueKing unified login verification, verification failed, may be illegal `bk_token` or expired)
- `access_token` is illegal (will go to BlueKing bkauth/ssm verification, verification failed, may be illegal `access_token` or expired)
- Processing: Confirm that `bk_token/access_token` exists and is legal

### user authentication failed, the user indicated by bk_username is not verified

```json
{
"code":1640001,
"data":null,
"code_name":"INVALID_ARGS",
"message":"Parameters error [reason=\"user authentication failed, the user indicated by bk_username is not verified\"]",
"result":false
}
```

- Reason:
- The user authentication information provided only contains bk_username, but no bk_token, access_token, etc. that can indicate the user's true identity. bk_username cannot truly represent the user's real identity (non-verified)
- Solution:
- Provide a valid bk_token/access_token

Others:
In the "Plugin Configuration" of the gateway, find the plugin "Application Whitelist without User Authentication (Not Recommended)", and in the plugin configuration, add the application to the Application Whitelist without User Authentication. This plugin is not recommended for use. It is not an official gateway and may not be added for the time being.

Note: `Application whitelist without user authentication (not recommended)` will be offline, and it is not recommended to use this plug-in; the interface needs to enable `application authentication` or `user authentication` according to the needs, and it should not be turned off and then try to obtain user information

### access_token is invalid

```json
{
"code":1640001,
"data":null,
"code_name":"INVALID_ARGS",
"message":"Parameters error [reason=\"access_token is invalid, url: ......., code: 403\"]",
"result":false
}
```

- Reason:
- access_token is wrong, it may be copied incorrectly
- access_token has expired
- access_token is not generated through [bkssm or bkauth](../Explanation/access-token.md) or in other environments
- Processing:
- If it is expired, you can renew or regenerate an access_token [access_token interface document](../Explanation/access-token.md)

### the access_token is the application type and cannot indicate the user

```json
{
"code_name": "INVALID_ARGS",
"code": 1640001,
"data": null,
"message": "Parameters error [reason=\"the access_token is the application type and cannot indicate the user\"]",
"result": false
}
```

- Reason:
- The access_token used to call the API is in application state, which only represents `bk_app_code+bk_app_secret`, and cannot represent the user
- Processing:
- Apply for and use the user state access_token to call the interface 165040

## status: 401

## status: 403

### App has no permission to the resource

```
{
"code": 1640301,
"data": null,
"code_name": "APP_NO_PERMISSION",
"message": "App has no permission to the resource",
"result": false
}
```

- Reason: Gateway API has enabled `Verify access permissions`, caller bk_app_code has no permission to call (no permission applied or permission expired)

- Processing: Go to the Developer Center to find the corresponding application, click in, `Cloud API Management - Cloud API Permissions` to apply for the corresponding interface permission or renew the permission

### Request rejected by ip restriction

```json
{
"code_name": "IP_NOT_ALLOWED",
"message": "Request rejected by ip restriction",
"result": false,
"data": null,
"code": 1640302
}
```

- Reason: IP access protection configured by the gateway or resource was triggered
- Handling: Add the caller's IP to the whitelist of IP access protection

## status: 404

### API not found

```json
{
"code_name": "API_NOT_FOUND",
"message": "API not found [method=\"POST\" path=\"/api/xxxxx\"]",
"result": false,
"data": null,
"code": 1640401
}
```

- Reason: The corresponding API (method+path) cannot be found in APIGateway
- Handling:
- The caller confirms that the method/path called is correct and there is no splicing error
- Find the gateway manager to confirm that the corresponding method/path resource has been published and the interface exists

## status: 413

### Request body size too large

```json
{
  "code_name": "BODY_SIZE_LIMIT_EXCEED",
  "message": "Request body size too large.",
  "result": false,
  "data": null,
  "code": 1641301
}
```
- Reason: The request body exceeds the gateway limit. The current maximum gateway limit is 40M
- Processing:
- Request the backend service directly without going through the gateway

## status: 414

### Request uri size too large

```json
{
"code_name": "URI_SIZE_LIMIT_EXCEED",
"message": "Request uri size too large.",
"result": false,
"data": null,
"code": 1641401
}
```

- Reason: The request uri exceeds the gateway limit
- Processing:
- Do not put too long parameters in the uri

## status: 415

The gateway will not return `status code = 415`. For details, please refer to [How to confirm whether the wrong response is returned by the gateway or the backend service? - The backend returns status code 415](./gateway-error-or-backend-error.md)

## status: 429

### API rate limit exceeded by stage strategy

```json
{
"code_name": "RATE_LIMIT_RESTRICTION",
"message": "API rate limit exceeded by stage strategy",
"result": false,
"data": null,
"code": 1642902
}
```

- Reason: The application triggered the access frequency control strategy of the gateway corresponding to the `environment`
- Handling: Reduce the call frequency, or contact the gateway person in charge to adjust the corresponding frequency limit

You can get the information related to access frequency control from the request header

```
"X-Bkapi-RateLimit-Limit": Total frequency control count
"X-Bkapi-RateLimit-Remaining": Remaining count
"X-Bkapi-RateLimit-Reset": How long to reset
"X-Bkapi-RateLimit-Plugin": plugin name
```

### API rate limit exceeded by resource strategy

```json
{
"code_name": "RATE_LIMIT_RESTRICTION",
"message": "API rate limit exceeded by resource strategy",
"result": false,
"data": null,
"code": 1642903
}
```

- Reason: The application call triggered the access frequency control strategy of the gateway corresponding to the `API resource`
- Handling: Reduce the call frequency, or contact the gateway person in charge to adjust the corresponding frequency limit

You can get the information related to access frequency control from the request header

```
"X-Bkapi-RateLimit-Limit": Total frequency control count
"X-Bkapi-RateLimit-Remaining": Remaining number
"X-Bkapi-RateLimit-Reset": How long to reset
"X-Bkapi-RateLimit-Plugin": plugin name
```

### API rate limit exceeded by stage global limit (deprecated)

```json
{
"code_name": "RATE_LIMIT_RESTRICTION",
"message": "API rate limit exceeded by stage global limit",
"result": false,
"data": null,
"code": 1642901
}
```

- Reason: The application triggered the global access frequency control policy of the gateway corresponding to the `environment` (deprecated)
- Handling: Reduce the call frequency, or contact the gateway person in charge to adjust the corresponding frequency limit

(Deprecated, this plugin policy should not exist in most environments)

### Request concurrency exceeds

```json
{
"code_name": "CONCURRENCY_LIMIT_RESTRICTION",
"message": "Request concurrency exceeds",
"result": false,
"data": null,
"code": 1642904
}
```

- Reason: The request concurrency is too high, exceeding the gateway limit
- Handling: Reduce concurrency (Note that it is forbidden to use the gateway interface for stress testing)INTERNAL_SERVER_ERROR

## status: 499 Client Closed Request

### No response body

> 499 client has closed connection means that the **client** has disconnected, that is, after the client initiates a request, it closes the connection without waiting for the server to respond.

Cause: The client calls the gateway and the waiting time exceeds the set timeout time, and actively closes the connection. This may be because the timeout time set by the client is too short, or the backend service responds very slowly;

Handling:
- Confirm whether the timeout set by the client is reasonable
- Contact the gateway manager to confirm whether the performance of the backend service meets the requirements (the response time of the backend service can be reduced by optimizing the interface performance and expanding the capacity)

Other phenomena and causes:
- The user's application requests the gateway or ESB interface, and the request fails. The gateway log is queried and the recorded status code is 499
- If it is SaaS, and the failed requests are basically around 30s, please check whether it is started using gunicorn. If the timeout time is not configured, the default is `30s` [gunicorn settings timeout](https://docs.gunicorn.org/en/stable/settings.html#timeout);
- If it is non-SaaS, then you need to check the context of the request initiation to see if it is in a certain woker or handler. In this way, due to the belonging woker or the handler is aborted, which will cause the request to be aborted;

## status: 500

## status: 502

### cannot read header from upstream

```json
{
  "data": null,
  "code_name": "BAD_GATEWAY",
  "code": 1650200,
  "message": "Bad Gateway [upstream_error=\"cannot read header from upstream\"]",
  "result": false
}
```
- The corresponding nginx error log is: `upstream prematurely closed connection while reading response header from upstream`, you can [google this string](https://www.google.com.hk/search?q=upstream+prematurely+closed+connection+while+reading+response+header+from+upstream&oq=upstream+prematurely+closed+connection+while+reading+response+header+from+upstream&sourceid=chrome&ie=UTF-8) for further understanding

- Reason: The gateway requested the backend service and was waiting for the backend service to respond. At this time, due to network reasons (such as jitter) or backend service reasons (such as reload, restart), the connection was interrupted
- The backend has been published/restarted
- The backend has keep-alive enabled but the configured keep-alive timeout is less than 60s

- Handling:
- Provide call information (time/request information/request-id, etc.) and find the gateway person in charge to find out the cause. Is it caused by release/restart? If not, the gateway manager needs to further investigate

### DNS resolution failed

```json
{
"data": null,
"code_name": "BAD_GATEWAY",
"code": 1650200,
"message": "Bad Gateway",
"result": false
}
```

When the domain name address of the backend service proxied by the gateway cannot be resolved by DNS, it will also be displayed as 502. At this time, the error of the underlying resolution failure is only recorded in nginx error.log, and the upper-level plug-in cannot obtain the specific error

Common:

1. Backend service address configuration error

Solution: Check whether the backend service address domain name can be pinged in IDC

### Request backend service failed

```json
{
"data": null,
"code_name": "ERROR_REQUESTING_RESOURCE",
"code": 1650201,
"message": "Request backend service failed [detail=\"Bad Gateway\" err=\"EOF\" status=\"502\"]",
"result": false
}
```

- Reason: Gateway failed to request backend service. For specific error information, see `message`
- Solution: Directly connect the address of the backend service and use `curl` to access and confirm the problem on the IDC machine. This is usually caused by problems with the backend service or the access layer of the backend service.

## status: 503

## status : 504

### cannot read header from upstream

```json
{
"code_name": "REQUEST_BACKEND_TIMEOUT",
"data": null,
"code": 1650401,
"message": "Request backend service timeout [upstream_error=\"cannot read header from upstream\"]",
"result": false
}
```
- The corresponding nginx error log is: `upstream timed out (110: Connection timed out) while reading response header from upstream`, you can google this string for further information

- Reason: Gateway resources will configure the timeout time of the backend interface. If the backend interface call times out, the gateway returns 504

- Processing: The backend service needs to improve the interface performance (the response time of the backend service can be reduced by optimizing the interface performance, expanding the capacity, etc.), or increase the gateway timeout time (not recommended)

Supplement:
- Another possible reason: The backend service is only configured to support https, not http protocol, and the backend address configured in the gateway environment configuration uses `http://{host}:{port}`

- Processing: Change the protocol to https `https://{host}:{port}`

## status: 508

### Recursive request detected, please contact the api manager to check the resource configuration

```json
{
"code_name": "RECURSIVE_REQUEST_DETECTED",
"data": null,
"code": 1650801,
"message": "Recursive request detected, please contact the api manager to check the resource configuration",
"result": false
}
```

- Reason: The gateway is prohibited from using another gateway as the backend, which may lead to infinite recursive calls and eventually cause the gateway service itself to hang up, so a detection was made
- Processing:
- Do not use another gateway address as the backend
- If the request comes from the gateway and needs to call another gateway interface again after reaching the backend service, please do not reuse the header of the request, but create a new request to assemble the relevant information and then initiate the call (reusing the upstream request header will bring security issues, and the downstream can obtain various information that does not belong to it, including user information/some sensitive information agreed by this system, etc.)