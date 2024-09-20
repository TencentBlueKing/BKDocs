# Gateway API active authorization

The gateway can proactively add gateway API access permissions to BlueKing applications.

## Active authorization

On the gateway's management page, expand the left menu **Permission Management**, click **Apply Permissions**, open the permissions management page, and click **Active Authorization**.

Fill in the authorization information:
- BlueKing application ID: `bk_app_code` of the BlueKing application to be authorized, please refer to [Get BlueKing application account] (../use-api/bk-app.md)
- Validity time: the validity period of the authorization, which can be set for a limited time or permanently
- Resources to be authorized:
   - All resources: including all resources under the gateway, including newly created resources in the future
   - Partial Resources: Only the currently selected resources are included

Click **Save** to add permissions to the application.

![](../../assets/apigateway/howto/api-permissions-grant.png)

## View the authorizations added by the gateway

On the gateway's management page, expand the left menu **Permission Management** and click **Apply Permissions** to view the list of permissions that have been added to the gateway.

- Authorization dimensions:
   - By gateway: Query the permissions of all resources corresponding to the application
   - By resource: Query the permissions of an application corresponding to a single resource

![](../../assets/apigateway/howto/api-permissions-list.png)