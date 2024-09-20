# Introduction to Multi-Module Functionality in BlueKing Applications

## What is "Multi-Module"?

"Module" is a concept similar to "BlueKing Application" within the BlueKing Developer Center.

Every BlueKing application has at least one module: the **default (default module)**, which exists as soon as the application is created.

Modules are the direct carriers of application resources such as enhanced services, source code repositories, and deployment environments.

In a sense, these resources do not directly belong to the application but to the default module of the application.

In addition to the default module, you can also create new modules under the application. New modules will have a set of resources completely isolated from the default module.

You can flexibly switch between modules through the dropdown menu at the top of the application page.

## Why Use "Multi-Module"?

For the vast majority of BlueKing applications, one default module can meet all needs.

But imagine this scenario: you have a front-end and back-end separated web application, where the front end is implemented using webpack + vue.js, and the back end is a Python + Django REST API.

In that case, if you only use one default module, you will find that it is impossible to deploy the application in a normal way. You can only compile the front end into static files in the local development environment in advance, and then externally mount them to the back-end Django project for access.

<center>Figure: Single-module deployment of front-end and back-end separated projects</center>

The multi-module feature was born to solve such problems. For front-end and back-end separated projects like the one above, you can create multiple modules to achieve a true front-end and back-end separation architecture:

- Default module: used to store front-end related code, using nginx to host front-end static pages
- Backend-api module: used to store back-end API related code, directly using gunicorn to handle requests

<center>Figure: Front-end and back-end separated multi-module</center>

Using the multi-module feature, we can allow the two modules to be developed and deployed independently, achieving true front-end and back-end separation.

In addition to front-end and back-end separated applications, the multi-module feature is also suitable for any architecture that needs to split application functions through modules and communicate based on network protocols. For example, practicing the popular "microservices architecture" applications in the industry.

## How Application Resources Are Isolated Through Modules

Most resources within an application are isolated based on modules, such as the source code repository address bound by the module, the enhanced service instances applied for, etc.

When you switch the current module on the application page, the functional pages you visit will display the situation of the current module.

However, there are also some functions within the application that are not isolated based on modules, such as **Member Management**. If you add someone as a member of the application, they can operate all modules under the application. Like member management, **Basic Information, Cloud API Permissions** functions also do not distinguish modules.

It is worth noting that the **Application Market** function also does not distinguish modules. The same application, no matter how many modules are created under it, can only be listed as **one application** on the BlueKing market.

So when an application with multiple modules is listed on the market, which module will be opened when users click on the application icon through the BlueKing desktop? The answer is the **"Main Module"**.

## What is the "Main Module"?

An application can create many modules, but can only have one main module. By default, the default module is the main module of the application. The main module means:

1. The quick access address of the application (such as the "Access" button on the application list page) will point to the various environment addresses of the main module
2. **The access address of the application in the BlueKing Application Market will point to the production environment address of the main module**
3. The main access address of the application's short domain name will point to the production environment of the main module

When you switch the main module of the application, the modules pointed to by the above three addresses will change. If the vast majority of your application's customers use these short domain names to access the application, please be extra careful when switching the main module.

### How to Switch the Main Module

Operation entry: **Access Management**

On the Access Management page, hover the mouse over the module you want to set as the "Main Module", and then click the "Set as Main Module" button to complete the main module switch.