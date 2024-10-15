# Gateway API request record

The gateway supports querying the request records of the gateway API to facilitate troubleshooting. However, due to the large amount of logs, the backend interface responds to requests with status code 20X.
Sampling will be performed and only part of the requested records can be queried; overlong parameters and response content will also be truncated and only part of the content will be displayed.

On the gateway management page, expand the left menu **Running Data** and click **Flow Log** to enter the request record query page.

Entering precise query conditions will help quickly locate request records. For more query rules, please refer to [Request Log Query Rules](../reference/log-search-specification.md)

![](../../assets/apigateway/howto/access-log.png)