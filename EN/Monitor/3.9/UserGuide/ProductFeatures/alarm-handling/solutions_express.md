# Quick processing package

## Type of package

There are three main types of fault self-healing packages: **Quick Package**, **Built-in Package**, and **Peripheral System Package**.

*Quick package: Users can use it directly without making any settings. Other packages require user configuration.
* Built-in packages: Mainly refers to two types: alarm notification and alarm callback. The execution actions of these two are the logic guaranteed by the platform itself.
* Peripheral system package: refers to the operating platform, standard operation and maintenance, ITSM, etc., and the capabilities provided by peripheral system services.

## Express package list

### [Quick] Disk Cleanup (Applicable to Linux)

Dependency: Standard operation and maintenance

Application scope: Suitable for Linux

Introduction: Mainly used to clean up disk space.


#### [Shortcut] Send the TOP10 processes with CPU usage

Depends on: standard operation and maintenance and notification channels

Application scope: Suitable for Linux

Introduction: Obtain the process list of the top 10 CPU usage of the target server


#### [Quick] Send the TOP10 processes of MEM usage

Depends on: standard operation and maintenance and notification channels

Application scope: Suitable for Linux

Introduction: Obtain the process list of the top 10 CPU usage of the target server


#### [Shortcut] CMDB is moved to the "Faulty Machine" module

Call the interface of the BlueKing configuration platform to move the faulty machine to the faulty machine module of the current business.

Dependencies: CMDB

Introduction: Obtain the process list of the top 10 CPU usage of the target server


### Express package in combo package

Packages under this category can only be used in combination packages.

#### [Quick] Configuration platform copies the properties of the faulty machine to the backup machine.

> (You need to call first to get the backup package for the faulty machine)

- Specific operations:

     - Call the configuration platform replacement interface to transfer the replacement machine to the same module as the faulty machine (including the case of multiple modules belonging to the faulty machine).

     - Copy the standard attributes and custom attributes of the faulty machine to the replacement machine.

- Usage scenario: After the faulty machine is switched over, copy the CC information of the faulty machine to the backup machine;


#### [Quick] Swap the faulty machine and the backup machine for subsequent processing

> (You need to call first to get the backup package for the faulty machine)

- Specific operations:
After calling this package, the operation object will be replaced in the subsequent process of combining the package. By default, the process operates on the faulty machine, and after calling it once, it will operate on the backup machine by default. Call it again to restore the original state.

- scenes to be used:
For example, after obtaining the selected standby machine and wanting to initialize the standby machine, you must first call this package and then call the initialization. After initialization, if you want to move the faulty machine to the faulty machine module of the configuration platform, you need to call this package again, and then call the configuration platform move module.



## Combo package class

### Combo Package

The combination package, as the name suggests, is to combine the packages under this business with the official general package.

- Specific operations: Execute the package according to the configured process sequence.

- Usage scenario: When a single package cannot meet the fault recovery process, use packages in series.

### Obtain the backup machine of the faulty machine

Obtain the backup machine based on the configuration properties of the configuration platform. Many fault replacement operations depend on this package.

In addition to obtaining the backup machine through this package, you can also obtain the backup machine through the operating platform. Just use the operating platform package to obtain the parameter with the variable ip_bak.

- Specific operations: According to the configuration, in the Set and AppModule specified by the configuration platform, search for machines with the same specified attributes as the faulty machine. All qualified machine IPs will be selected for operation and maintenance approval through WeChat. This backup machine IP can be obtained in other packages through variables.

- Usage scenario: This package must be called before calling the fault replacement operation package in the combined package.

For more variables, please refer to [Package built-in variables](../alarm-handling/solutions_parameters_all.md).