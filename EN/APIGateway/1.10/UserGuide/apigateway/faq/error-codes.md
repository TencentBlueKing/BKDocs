# Gateway API error code

The request to the gateway API failed. The reason may be a gateway error or a backend interface error.
- The request response header `X-Bkapi-Error-Code` is not empty, indicating a gateway error. The error code is a 7-digit integer string. The response header `X-Bkapi-Error-Message` indicates a detailed error message.
- The request response header `X-Bkapi-Error-Code` is empty, indicating the backend interface response transparently transmitted by the API gateway


| Error Code | HTTP Status Code | Error Message | Solution |
| ------ | ----------- | -------- | -------- |
| 1640001 | 400 | Parameters error | Parameter error, please update the corresponding parameters according to the error message |
| 1640101 | 401 | App authentication failed | Application authentication failed, valid application authentication data needs to be provided |
| 1640102 | 401 | User authentication failed | User authentication failed, valid application authentication data needs to be provided |
| 1640301 | 403 | App has no permission to the resource | The app has no permission to access the resource. Please go to the Developer Center to apply for resource access permission |
| 1640302 | 403 | Request rejected, the request source IP has no permission, please apply for IP permission | The request source IP has no permission to access resources, please contact the person in charge of the gateway to add an IP whitelist |
| 1640401 | 404 | API not found | Gateway resource does not exist |
| 1640501 | 405 | Request unsupported method | The gateway resource does not support this request method |
| 1641301 | 413 | Request body size too large | The request body is too large. The maximum request body supported by the gateway is 40M |
| 1642901 | 429 | API rate limit exceeded by stage global limit | The global traffic frequency of the environment exceeds the limit. Please contact the person in charge of the gateway to confirm whether you need to adjust the global traffic control of the gateway environment |
| 1642902 | 429 | API rate limit exceeded by stage strategy | The frequency of application request environment exceeds the limit. Please contact the person in charge of the gateway to apply to adjust the frequency of application access to the gateway environment |
| 1642903 | 429 | API rate limit exceeded by resource strategy | The frequency of application request resources exceeds the limit. Please contact the person in charge of the gateway to apply for adjusting the frequency of application access to gateway resources |
| 1642904 | 429 | Request concurrency exceeds | The number of concurrent requests exceeds the limit. Each application supports 1000 concurrent requests |
| 1650002 | 500 | Resource configuration error | Gateway configuration error, please contact the person in charge of the gateway to check the gateway resource configuration |
| 1650003 | 500 | Request rejected, detected recursive request to API Gateway | The gateway resource configuration is wrong. The resource backend address is configured with the address of a gateway resource. Please contact the person in charge of the gateway for adjustment |
| 1650201 | 502 | Request backend service failed | The gateway failed to request the backend interface service. It may be due to network jitter and other reasons. Please try again later, or contact the person in charge of the gateway to check |
| 1650401 | 504 | Request backend service timeout | The gateway requested the backend interface timed out (did not respond within the specified time), please contact the person in charge of the gateway to check |