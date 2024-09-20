# Introduction to BlueKing Applications

## What is a BlueKing Application?

BlueKing Applications are SaaS applications that run on the 'BlueKing Desktop', providing users with a variety of different services. Once a user applies to become a 'Developer' under their respective developer, they gain the permission to create BlueKing Applications.

## Highlights of the Upgrade to the BlueKing PaaS Platform Developer Center

Recently, the BlueKing PaaS Platform Developer Center has undergone a comprehensive upgrade, introducing new application models and providing a better cloud-native deployment experience. The main updates include:

- **Centralized Module Configuration Interface**: Makes application management and operations more convenient.
- **Global Process View**: Helps users monitor and manage application processes more clearly.
- **New Features**:
  - **Auto Scaling**: Automatically adjusts the resource allocation of applications according to demand.
  - **Mount Volumes**: Supports data persistence and sharing.
  - **Custom Domain Resolution**: Allows users to set domain names as needed.

In the new version, cloud-native applications built with BlueKing Buildpack retain all the features of the original regular applications, further enhancing the user experience.

### Classification of BlueKing Applications

BlueKing Applications are divided into the following three categories:

- **Cloud-Native Applications**: Deployed based on container images, support using YAML format files to describe application models, suitable for modern development and operational needs.
- **Ext-Link Applications**: Used to apply for cloud API permissions or register applications on the BlueKing Desktop, facilitating integration and management.
- **Regular Applications**: Only support applications developed with specific languages (such as Python, Node.js, etc.). Please note that the creation entry for this type of application is no longer provided in the latest version.

## Different Roles of BlueKing Applications

To better collaborate on the development and management of BlueKing Applications, each application has three different roles: **Admin**, **Developer**, **Operator**.

The permissions for each role are shown in the table below:

| Operation             | Admin | Developer | Operator |
| --------------------- | ----- | --------- | -------- |
| View Basic Information | o     | o         | o        |
| Basic Development      | o     | o         | x        |
| Data Statistics        | o     | o         | o        |
| Cloud API Management   | o     | o         | x        |
| Alarm Records          | o     | o         | o        |
| Application Promotion  | o     | o         | o        |
| Edit Basic Information | o     | x         | o        |
| Permission Management  | o     | x         | o        |
| Delete Application     | o     | x         | x        |
| Member Management      | o     | x         | x        |
| Add-ons Management     | o     | x         | x        |
| Deployment Environment Restrictions Management | o | x | x |
| Module Management      | o     | x         | x        |
| Alarm Policy Configuration | o     | o         | x        |

Note:

- Basic Development: Includes deployment management, process management, logging, environment configuration, access entry, viewing add-ons information, repository configuration, image credentials, etc.
- Module Management: Includes setting as the default module, creating new modules, etc.
- Add-ons Management: Includes unbinding and deleting add-ons, etc.

## Next Steps

One of the most important operations in the process of developing BlueKing Applications is deploying them. You can [learn about application deployment-related knowledge](./deploy_intro.md) next.