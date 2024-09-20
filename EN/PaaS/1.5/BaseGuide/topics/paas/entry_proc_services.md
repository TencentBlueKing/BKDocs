# Process Service Description

## Introduction

In [Application Processes](./process_procfile.md), we introduced how to define processes for an application and how to manage them.

However, processes cannot provide services independently to others; we need to configure "Access Main Entry" and "Process Services" to expose the application processes to both internal and external users.

This article is an introduction to "Access Main Entry" and "Process Services."

## Access Main Entry

Each BlueKing application has two different deployment environments by default: "Staging" and "Production," and each environment has an "Access Main Entry." When users request the external addresses of each environment through a browser, the request will be forwarded to the target service pointed to by the "Access Main Entry" of that environment.

By default, the "Access Main Entry" for each environment is set to port **5000** of the **web** process. At the same time, to facilitate the process listening to this default port, the platform will also inject an environment variable named `PORT` into the application runtime environment, with a value of 5000. See [Built-in Environment Variables Explanation](./builtin_configvars.md) for details.

## Process Services

Process services are the core concept for application processes to complete internal communication and external exposure, and their main functions are as follows:

- Internally within the application, communicate via "Process Service Name + Port Number" (e.g., http://default-bkapp-amazingblues-stag-web:8080)
- Set a certain process service port as the "Access Main Entry" to expose the service externally

### How to View

On the 'Access Management' - 'Process Service Management' page, you can view the current application's process services.
Each process service can have one or more port rules set, and the meanings of the fields in the rules are as follows:

- **Name**: A name used to distinguish the port rule, which cannot be duplicated within the same process
- **Protocol**: TCP / UDP
- **Service Port**: The port number accessed within the application by "Service Name," which cannot be duplicated within the same process
- **Internal Process Port**: The actual port number that the process listens to, for example, if the web process is started with "gunicorn -b :8080," then the internal process port it listens to is 8080

By default, the platform will create a default rule for each process:

- Name: http
- Protocol: TCP
- Service Port: 80
- Internal Process Port: 5000

This default rule ensures that a new application can be accessed directly by a browser after the first deployment without configuring any rules.