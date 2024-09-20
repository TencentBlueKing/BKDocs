# Plug-in production

All collection configurations need to define plug-ins first (except built-in plug-ins, such as logs). Plug-ins include built-in plug-ins and custom plug-ins, business private plug-ins and public plug-ins, local collection and remote collection modes of plug-ins, and support different operating systems.

## Preliminary steps

> Note: Linux and Windows only support 64-bit operating systems by default. If you need to support 32-bit operating systems, you need to customize it.

Plug-in output format description: See [Data Model](../../concepts/datamodule.md#Promtheus's data structure) for details: "Monitoring platform supports Promtheus's data structure".

**working principle**:

![-w2021](media/15767474716683.jpg)

**Explanation of terms**:

* **Collector**: Monitor Collector monitors the built-in collector, like basereport collects operating system indicators, and bkmonitorbeat manages the collection plug-in.
* **Collection plug-in**: User-defined collection plug-in, which can be infinitely expanded based on standard requirements.

> The difference between the two, please see [Explanation of Terms](../../concepts/glossary.md) for more information

## List of main functions

* Supported operating systems: Linux, Windows, AIX6, AIX7
* Supported plug-in types: Exporter, DataDog, Script (Linux: Shell, Python, Perl, custom, Windows: PowerShell, VBS, Python, custom), BK-Pull, JMX
* Supported operating modes: public plug-in, remote plug-in, official plug-in
* Parameter definition: command line parameters, environment variables, positional parameters
* Plug-in import and export
* Plug-in debugging
* Plug-in definition: LOGO, description, indicator dimension unit, etc.

## Function Description

![-w2021](media/15754467635624.jpg)

The production of plug-ins is divided into several situations:

1. Online definition, defined directly in the web interface, for example: [How to use open source Exporter](../../guide/import_exporter.md)
2. Define offline. Make the plug-in package offline and import it directly, for example: [How to define DataDog plug-in offline](../../guide/import_datadog_offline.md)
3. Development of the collection program itself, such as:
     * [Exporter plug-in development](../../dev/plugin_exporter_dev.md)
     * [DataDog plug-in development](../../dev/plugin_datadog_dev.md)

### Plug-in import and export

Plug-in import supports the import and export of a single custom plug-in

Certified plug-ins can be imported in batches

> **NOTE**:
> 1) Because the official plug-in is a public plug-in by default, only administrators can import it.
> 2) You can also export related plug-ins in the configuration import and export of the menu

### Online production plug-in

**Basic process of plug-in definition**:

* **Step one: Plug-in definition**
     *Basic information about the plug-in: ID, alias, classification, whether it is a public plug-in, and whether it supports remote
     * Main content of the plug-in:
         * Script/binary program/configuration content
         * Parameter definition
     * Auxiliary information of the plug-in: description, LOGO

![Define plug-in](media/15833902302710.jpg)

> Note: Public plug-ins can only be set with platform permissions. Once set up, the entire platform and all services are available.

* **Step 2: Plug-in debugging**

    Plug-in debugging is to ensure that the data returned by the plug-in production is normal.

    * Steps:
         * Fill in parameters
         * Select debugging machine
         * Debugging process
         * Set indicators and dimensions
         * save

     ![-w2021](media/15833949594912.jpg)

![-w2021](media/15833949793387.jpg)

#### Parameter definition description

Three methods are provided for parameter definition: command line parameters, positional parameters, and environment variables.

##### Command line parameters

The most common way to define parameters.

Such as the startup parameters of redis_exporter

| Name | Environment Variable Name | Description |
| -------------- | ------------------------- | ---------------------------------------------------------------------- |
| redis.addr | REDIS_ADDR | Address of the Redis instance, defaults to `redis://localhost:6379`. |
| redis.password | REDIS_PASSWORD | Password of the Redis instance, defaults to `""` (no password). |

As defined `--redis.addr redis://localhost:6379`

It can be set like this: Select command line parameters

* Parameter name: `--redis.addr`
* Default value: text `redis://localhost:6379`
* Parameter description: Address of the Redis instance, defaults to `redis://localhost:6379`

For more complete redis_exporter plug-in production, see [How to use the open source Exporter to make plug-ins online](../../guide/import_exporter.md)

##### Positional parameters

It is often used in shell scripts, such as `$1,$2`.

For example, script execution `./script1.sh localhost 6379`

Then there must be a place to receive it in the script.

```bash
#!/bin/bash
redis-cli -h $1 -p $2
```

Then you can set it like this (taking $1 as an example): Select the position parameter

* Parameter name: `redis address` # The parameter name is a display name in the positional parameter. This will be displayed in the parameter filling part when the plug-in is used.
*Default value: text `localhost` # You can set the default value or not set it
* Parameter description: `Fill in the redis address, the default is localhost`

> Note: `$1 $2` is determined by the order of setting.

##### Environment variables

Environment variables are used in the program to obtain the content. Just use environment variable parameters to define.

For example, if you directly obtain a variable in the environment variable in the program, you want this variable to be set by the user of the plug-in `os.getenv('PYTHONPATH')`

Then you can set it like this: Select environment variables

* Parameter name: `PYTHONPATH`
* Default: text `/usr/bin/python`
* Parameter description: `Python path defaults to /usr/bin/python`

#### Script plug-in definition

Script is a user-defined script for Metrics collection. As long as it conforms to the standard format of monitoring, the data can be collected. Supported scripts are:

*Linux: Shell, Python, custom

* Windows: Shell, Python, VBS, PowerShell, Custom

> INFO: Customization is executed directly without an interpreter. Such as ./script

![-w2021](media/15794940408106.jpg)

* [How to monitor via script](../../guide/script_collect.md)

#### Exporter plug-in definition

Exporter is used to expose metrics of third-party services to Prometheus. It is an important component in Prometheus.

According to the specifications of the monitoring platform plug-in, the open source Exporter plug-in can be turned into the collection capability of the monitoring platform.

The running Exporter is a go binary program that needs to define the startup process and occupied ports.

![-w2021](media/15794940142991.jpg)

* [How to use the open source Exporter collection capability](../../guide/import_exporter.md)

#### DataDog plug-in definition

![-w2021](media/15794940751608.jpg)

* [How to use the open source DataDog collection capability](../../guide/import_datadog_online.md)

#### JMX plug-in definition

JMX can collect the service status of any java process with the JMX service port enabled, and collect the jvm information of the java process through JMX.

Including information such as gc time consumption, gc times, gc throughput, old generation usage, new generation promotion size, number of active threads, etc.

![-w2021](media/15794940240535.jpg)

* [How to define a JMX plug-in](../../guide/plugin_jmx.md)

#### BK-Pull plug-in definition

BK-Pull mainly solves data sources that only expose port services. Pull the target's data through pull.

![-w2021](media/15794940929248.jpg)

* [How to get Prometheus data directly](../../guide/howto_bk-pull.md)

#### Remote plug-in definition

![-w2021](media/15794941254275.jpg)

  * [How to implement monitoring without installing BlueKing Agent](../../guide/noagent_monitor.md)

#### Public plug-in definition

Only administrators can set the public plug-in. After it is set as a public plug-in, all users of the monitoring platform can use the plug-in.

![-w2021](media/15795316967969.jpg)

> Note: Once it is set as a public plug-in and has collection configuration, it cannot be canceled unless there is no collection dependency.

### Offline production plug-in

Plug-ins can also be imported directly through offline production. Offline plug-in production mainly understands the configuration content and relationships of various plug-ins.

* [Plug-in configuration explanation](../../functions/addenda/plugins_explain.md)
* [How to define DataDog plug-in offline](../../guide/import_datadog_offline.md)

### Upgrade plugin

Every time a plug-in is modified, the version will be recorded, and the version records are divided into two categories. Such as: x.y. The action of upgrading the plug-in will have a corresponding upgrade reminder in the collection configuration after editing the plug-in.

> Note: x and y change independently and are not affected.

Large version x

- Binary/script modifications
- Configuration template modification
- Parameter modification
- Whether it is remote collection

small version y

- Plugin indicators
- Plugin description
- Plugin alias
-LOGO