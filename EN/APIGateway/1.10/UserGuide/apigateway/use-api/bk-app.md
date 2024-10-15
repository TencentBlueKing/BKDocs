# Get BlueKing application account

When accessing the cloud API, if you authenticate the application, you need to provide the BlueKing application account.

This article will guide you to create a BlueKing application and obtain a BlueKing application account (application ID: bk_app_code, application secret key: bk_app_secret).

## Determine application type

`BlueKing Developer Center` provides the following 3 basic application types:
- Ordinary applications: The platform provides application engines, enhanced services, cloud API permissions, application markets and other functions for this type of applications; suitable for scenarios in which SaaS is independently developed based on the PaaS platform.
- External link applications: The platform provides cloud API permission application, application market and other functions for this type of applications.

If you only need to call the gateway interface and create an external link application, but if you have subsequent application development and deployment needs, you can choose a normal application.

## Common application

### Create application

Visit `BlueKing Developer Center`, click **Create Application**, open the application creation page, and select **Normal Application**.

Fill in the configuration and click the **Create Application** button at the bottom of the page to create a BlueKing application:
- Application ID: the unique identifier of the application, i.e. bk_app_code
- Application name: A name indicating the purpose of the application
- Application Engine: If you are not using a PaaS platform to host your application, you can turn off the Application Engine
- App Market: The access address can be set to "Not set yet"

![](../../assets/apigateway/use-api/create-app.png)

### Get application account

Visit `BlueKing Developer Center`, click on the navigation menu **Application Development**, search for the application, and enter the application's management page.

![](../../assets/apigateway/use-api/app-list.png)

On the application management page, expand the left menu **Basic Settings** and click **Basic Information**.
The `bk_app_code` and `bk_app_secret` in the authentication information on the right page are the BlueKing application accounts required to access the cloud API.

![](../../assets/apigateway/use-api/app-basic-info.png)


## External link application

### Create application

Visit `BlueKing Developer Center`, click **Create Application**, open the application creation page, and select **External Link Application**.

Fill in the configuration and click the **Create Application** button at the bottom of the page to create a BlueKing application:
- Application ID: the unique identifier of the application, i.e. bk_app_code
- Application name: A name indicating the purpose of the application

The rest of the content can be filled in based on actual conditions.

![](../../assets/apigateway/use-api/create-external-app.png)

### Get application account

Similar to a normal application, enter the management page of the external link application.

On the application management page, expand the left menu **Basic Settings** and click **Basic Information**.
The `bk_app_code` and `bk_app_secret` in the authentication information on the right page are the BlueKing application accounts required to access the cloud API.

![](../../assets/apigateway/use-api/external-app-basic-info.png)