# How to monitor open source components

How to use the monitoring platform to quickly monitor open source components and middleware services to ensure the normal operation of business application services.

## Preliminary steps

Open source service modules are often called "components" and "middleware". They are well-known common service modules. Therefore, there are many ready-made monitoring and collection methods. In fact, they really need to meet the requirements of components. Monitoring not only has these methods, but also completely customizable scripts and so on.

## Component monitoring solution

### Method 1: Use the built-in official plug-in

Currently, it covers performance indicator monitoring of common components such as Apache, Nginx, Tomcat, MySQL, and Redis. For specific configuration, please refer to the access guide on the APP. Please see [Built-in official plug-in list](../integrations-metric-plugins/builtin_plugins.md) for details.

> **Note**: If the component you want to monitor is not listed here, or the access prompt provided by the component is unclear/you cannot successfully access according to the instructions, please contact BlueKing Assistant QQ: [800802001](http:// wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDgwMjAwMV80NDMwOTZfODAwODAyMDAxXzJf) Feedback to the monitoring platform team. (The feedback function of the Document Center can also access this feedback)

### Method 2: Import using a monitoring platform plug-in made by others

You can import plug-ins made or shared by others into plug-in management through the import function.

**Import function location**: Navigation → Integration → Plug-in Production → Import

### Method 3: Use the open source Exporter online definition plug-in

See [How to use open source Exporter](../../Other/guide/import_exporter.md) for details.

### Method 4: Develop Exporter collection plug-in

When there is no open source on the market, or it does not meet the needs. Developing an Exporter is also very simple. See [How to develop an Exporter collection plug-in](../../Dev/plugin_exporter_dev.md) for details.