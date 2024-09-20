# Deploy BlueKing Applications

## Introduction

Once your application development is complete, you can deploy it through the BlueKing Developer Center.

The BlueKing Developer Center provides an independent runtime environment based on container technology for all BlueKing applications. The underlying container orchestration capabilities offer flexible replica scaling, automatic failure migration, and other technologies to ensure the availability of the application.

Entry points for application deployment operations:

- Cloud Native Applications: 'Deploy'
- Regular Applications: 'APP Engine' - 'Deploy'

## 'Staging' and 'Production' Environments for Application Deployment

On the application deployment page, you will find both 'Staging' and 'Production' deployment environments.

The 'Staging' environment is mainly used after development is complete, when you want to deploy it online for functional testing by testers or product managers. After successful deployment, the platform will generate a test service address for accessing the application.

However, when users access your application through the BlueKing desktop, they are accessing the 'Production' environment. Therefore, after modifying the application, be sure to deploy it to the 'Production' environment to make the changes effective.

In addition, these two different environments have the following differences:

- Only applications successfully published to the 'Production' environment can be found in the 'APP Markets'
- BlueKing plugin applications can only be used in platforms such as Standard Operations and Maintenance after being successfully published to 'Production'

## Application Unlisting

After choosing to unlist an application, users will no longer be able to access it, and the application will also disappear from the 'APP Markets'. However, unlike deleting an application, the application's database will still be retained.

## Next Steps

After understanding the application deployment features, let's take a look at the [Application Deployment Process](./deploy_flow.md).