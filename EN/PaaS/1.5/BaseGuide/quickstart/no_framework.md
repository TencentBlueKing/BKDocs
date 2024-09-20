# Introduction to Non-Development Framework Application Deployment

Most applications on the BlueKing PaaS platform are developed based on development frameworks (such as Python/Node.js), and after being deployed to the platform, features like log querying and observability can be used out-of-the-box. However, in addition to development frameworks, the platform also supports several other delivery types:

- Build based on Dockerfile: The platform builds images based on the Dockerfile in the repository.
- Provide image repository: The platform directly obtains images from a remote repository.

When using these types, developers need to ensure that the application's behaviors and configurations comply with the standards to use the various features provided by the platform normally. This document collects some best practices related to this.

### Best Practices

#### Listening on the Correct Port

To ensure that user requests can be processed normally, the image process needs to listen on the correct port.

> **Request Processing Principle**: User requests are sent to port 80 (or 443) of each domain and then forwarded to the port configured for each process. Visit the "Module Configuration" -> "Process Configuration" page in the Developer Center, where you can view or modify this port number in the "Container Port" field.

Only when the actual port listened to by the process matches the port number in the "Process Configuration" will the request chain be unobstructed. There are two methods to achieve this:

1. Adjust the "Process Configuration" and modify the "Container Port" to match;
2. Adjust the "Command Parameters" to change the actual port listened to by the process to match.

For example, application A is built into an image through the Dockerfile in the repository and deployed to the Developer Center but cannot be accessed normally. At this time, the startup command used by the web process is `/serve`, and the command parameter is `--port 8083`—configured through the Dockerfile's `CMD` command (`CMD ["./serve", "--port", "8083"]`).

To fix the access issue of application A, there are three ways:

1. Visit the "Process Management" page, change the "Container Port" to `8083`, save, and redeploy.
2. Visit the "Process Management" page, change the "Command Parameters" to `--port $PORT` (when "Container Port" is not configured) or `--port {value of "Container Port" field}` (when there is a value in "Container Port"), save, and redeploy.
3. Modify the `Dockerfile`, adjust the port number 8083 in `CMD ["./serve", "--port", "8083"]` to the value configured in the "Container Port", such as `5000`.

In short, the key is to match the port number in the process configuration with the actual listened port number, and various methods can be flexibly selected.

#### Log Collection

Application logs are divided into two categories:

1. Standard output logs, access logs
2. Structured logs

The first category of logs is automatically collected by the platform, including the standard output (stdout or stderr) of the process and the access logs of the access layer. These logs do not require additional configuration by the developer, and can be directly queried on the page after the application is successfully deployed.

The second category of logs is structured logs, which can contain any content defined by the user. These logs need to be actively written to a file by the application process and cleaned and collected by the Developer Center. The log file must follow the following specifications:

- File path: Stored in the `/app/v3logs/` directory.
- File name: Complies with the rule `${process-type}-${random number}-${stream}.log`.
- File format: Each line is a complete `JSON` format, and content that does not conform to this format will be ignored.

For example, application A records the request logs for calling cloud APIs to a log file. To allow the platform to collect it as "structured logs" normally, developers can choose to output the logs to the file `/app/v3logs/web-oZbs-component.log`.

The following is an example of valid file content:

```plain
{"levelname": "INFO", "asctime": "2024-01-11 13:21:50,511", "pathname": "/app/backends.py", "lineno": 77, "funcName": "foo", "message": "request to cloud api finished."}
```

**Note**: If you need to customize log collection/cleaning rules, use log export, and other functions, you need to deploy the "BlueKing Log Platform".

#### Reading "Add-ons" Information from Environment Variables

When an application enables a type of add-on service, the platform will inject related environment variables into the application's running environment. For example, environment variables related to the MySQL add-on service include `MYSQL_HOST`, `MYSQL_USER`, and `MYSQL_PASSWORD`, etc. Detailed variable names can be queried in the "Module Configuration" -> "Add-ons" tab.

When writing application code, please prioritize reading configuration from environment variables. For example:

```python
# file: settings.py
import os

# Try to get the username from the environment variable injected by the BlueKing PaaS platform
db_host = os.environ.get('MYSQL_HOST') or `localhost`
```

This can achieve higher flexibility.