# Custom indicator-SDK PUSH reporting

Custom indicator reporting, PUSH through Prometheus SDK, similar to Pushgateway, only requires two steps to complete

## Access steps

* Step one: Create a Token to ensure security. On the monitoring platform, go to Integrate → Custom Indicators → Select Prometheus. After submission, the token will be created and accompanied by corresponding documentation.

* Step 2: Load the SDK application token. Just put the Token in the header or URL parameter to complete the authentication.

It is strongly recommended that the loading of configurations such as token or dataid should be configured as much as possible rather than hard-coded.

![](media/16613213624173.jpg)


## View data

After reporting the data, confirm the data and use it for simple visualization by checking the view.
![](media/16613213713524.jpg)


Generate rich dashboards, data query and visualization

![](media/16613213858987.jpg)


## Configure alarms and management

![](media/16613213974835.jpg)

## Various SDK access

[SDK access instructions](../../QuickStart/sdk_list.md)