# RequestID

When requesting the gateway API, the gateway will generate a RequestID for each request and pass it to the backend interface and gateway API caller through the header `X-Bkapi-Request-Id`.
It is recommended that the gateway API caller and backend interface record this RequestID to facilitate troubleshooting.
- Gateway API requester, the RequestID can be obtained by responding to Header`X-Bkapi-Request-Id`
- Resource backend interface, RequestID can be obtained by requesting Header `X-Bkapi-Request-Id`

Sample RequestID in response header

![](../../assets/apigateway/reference/response-request-id-header.png)

## Query the request flow log based on RequestID

On the gateway's management page, expand the menu item **Running Data**, click **Flow Log**, and open the log query page.

In the flow log, you can quickly locate the request information through RequestID to facilitate troubleshooting, and you can also share the log with other users.

![](../../assets/apigateway/reference/search-request-log-by-request-id.png)