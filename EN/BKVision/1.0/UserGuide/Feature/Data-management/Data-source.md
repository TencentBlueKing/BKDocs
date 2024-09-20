## Data source

In the chart platform, the essence of the data source is a database, which is used to store and manage data. If users want to display their data through the chart platform, the first step is to connect the database that stores various data to the chart platform.

Users can view and retrieve the data source information that has been connected to the space through the list;

![data-sourc](../media/data-source.png)

Click **`New`** to enter the "New Data Source" page;

1. **Select the data source type**

![data-source1](../media/data-source1.png)

2. **Fill in the data source configuration information**: Fill in different data source configuration information for different data source types

- **Computing platform**

![data-source](../media/data-source2.png)

​ **Basic information**: including **`Data source name`** and **`Data source identifier`**, to help users locate and identify the required data source more efficiently

​ **`Data source name`**: Data source display name, assign a clear and easy-to-understand name to the data source;

**`Data Source Identifier`**: a code or symbol that uniquely identifies the data source. Only the following characters are allowed: **`a-z 0-9 _`**, which is unique

​ **Connection information**: includes **`Select object`** and **`Specific object name`**. This operation represents the application for connecting to the data table of the computing platform project (the actual data usage rights are subject to the user's rights on the computing platform);

​ **`Select object`**: divided into **`Project`** and **`Business`**;

​ **`Project/Business`**: After determining the project/business, you can select the corresponding project/business name;

- **MySql**

![data-source3](../media/data-source3.png)

​ **Basic information**: includes **`Data source name`** and **`Data source identifier`**, which help users locate and identify the required data source more efficiently

​ **`Data source name`**: Data source display name, assigning a clear and easy-to-understand name to the data source;

**`Data Source Identifier`**: The code or symbol that uniquely identifies the data source. Only the following characters are allowed: `a-z 0-9 _`, which is unique;

​ **Connection Information**: Fill in the relevant information for the platform to access the database, including:

​ **`Database Address`**: The location of the database server, usually expressed as an IP address or domain name. For example, "192.168.1.1

​ **`Port number`**: The port number is a number associated with a specific database service. When the platform tries to connect to the database, it needs to specify the correct port number

​ **`Database name`**: Used to distinguish multiple databases on the same server

​ **`User name`**: One of the user credentials used to connect to the database. Database administrators create user accounts with different permissions, and the platform uses the correct username and password combination to gain access

​ **`Password`**: Credentials used in conjunction with usernames to authenticate the identity of the application and grant access to the database

​ **`Character set`**: Defines the types of characters that can be stored and used in the database

- **Web API**

![data-source4](../media/data-source4.png)

​ **Basic information**: Includes **`Data source name`** and **`Data source identifier`**, which help users locate and identify the required data source more efficiently

​ **`Data source name`**: Data source display name, assign a clear and understandable name to the data source;

**`Data Source Identifier`**: The code or symbol that uniquely identifies the data source. Only these characters are allowed: **`a-z 0-9 _`** are unique

​ **Connection information**: Specify the requested resource;

​ **`Request method & link`**: Support **`GET`**, **`POST`** two request methods, and enter the link, such as: https://bkvision.blueking.com/rest_api/demo;

​ **`header`**: HTTP request header information, also known as HTTP header, which contains application-specific information about the request or response;

​ **`Request parameters`**: Data sent with the HTTP request, used to pass additional information to the server so that the server can perform corresponding operations based on this information;

3. **Complete**