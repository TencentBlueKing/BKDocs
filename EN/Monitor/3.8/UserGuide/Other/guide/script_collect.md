# How to monitor via script

Scripting is a flexible and fast monitoring and collection method. Monitoring objects at different levels can be completed using scripts. Scripts are a very efficient solution when the default out-of-the-box functionality does not meet individual needs.

## Preliminary steps

Monitoring through scripts is roughly divided into the following steps:

* The first step: script plug-in definition and debugging
* Step 2: Collect configuration and check the view
* Step 3: Configure policies and event center
* Step 4: Configure dashboard view

## Step one: Script plug-in definition

**Navigation location**: Navigation → Monitoring Configuration → Plug-in → New

The script collection plug-in can be used to write and debug various scripts directly online, which can quickly meet the needs of monitoring and collection.

**How the script plug-in works**:

![-w2021](media/15769080736217.jpg)

**Script plug-in definition steps**:

* (1) Plug-in definition
     * [Required] Plug-in basic information
     * [Required] Select the system and write script content
     * [Optional] Configuration parameters
     * [Optional] Supplement logo and description information
* (2) Plug-in debugging
     * Fill in parameters
     * Debugging machine selection
     * Debugging process
     * save

Next, take `disk usage as an example` to implement script collection and indicator monitoring.

![Disk usage plug-in screenshot](media/15833951960344.jpg)

Script content:

```bash
#!/bin/bash

#Get disk usage
disk_name="$1"
diskUsage=`df -h | grep ${disk_name} | awk -F '[ %]+' '{print $5}'`

echo "disk_usage{disk_name=\"${disk_name}\"} ${diskUsage}"
```

Setting parameters:

Parameters are positional parameters such as shell's `$1`.

![Screenshot of parameter definition](media/15795359812413.jpg)


### Plug-in debugging: select the server and fill in the parameters

> Note: The services and delivery here are test joint debugging. The filled-in content will be the same in the later collection configuration, mainly to verify whether the plug-in production is reasonable and the results are as expected.

![Plug-in debugging screenshot](media/15833954908600.jpg)

### Confirm joint debugging results and set indicators and dimensions

After the joint debugging obtains the data, the indicator dimensions will be set and confirmed.

![Screenshot of setting indicator dimensions](media/15833956164126.jpg)

* **Indicator Grouping**: When there are many indicators, they can be grouped to facilitate subsequent use.
* **Unit setting**: You can set the unit. The unit is the base unit of the reported value. Subsequent display will be dynamically displayed according to the unit system.
* **Data Preview**: It is very convenient to see whether the data values obtained during debugging are in line with expectations.

> Note: The indicator dimensions can continue to be set after saving (in the lower left corner of the debugging window)
> ![Debug window screenshot](media/15833958304147.jpg)
> Note: The timeout of the entire debugging process is 600 seconds. If the debugging process is not saved within 600 seconds, the debugging process will be closed to ensure that there will be no residual debugging process on the server.

### Save plugin

![-w2021](media/15795333851539.jpg)

> Note: Each modification requires successful joint debugging before it can be truly saved.

## Step 2: Add collection configuration

After creating a new plug-in normally, you can directly click "Add Collection Configuration" to automatically create some content. If you return to the list page, you can also enter from the following navigation.

**Navigation location**: Navigation → Monitoring Configuration → Collection → New

Collection steps:

*1) Plug-in selection and parameter filling
*2) Select target
*3) Collection and distribution
*4) Completed

### 1) Fill in the collection parameters

After selecting the plug-in, you can fill in the parameters.

![-w2021](media/15795335324256.jpg)

### 2) Select target

Target selection can be static or dynamic. It is recommended to use dynamic method.

* Static: Only operating system-based IP selection can be based on static IP selection. Static IP supports manual input and service topology selection.
* Dynamic: The minimum selection can only be made to the module level. Based on any node, it can automatically realize the expansion and contraction of collection after expansion and contraction.

### 3) Collection and distribution

Collection and delivery, you can view the collection and delivery process, and you can retry when it fails. Of course, leaving directly will still result in abnormal execution. Finally, you can view the final results in "Status" on the list page.

### 4) Complete

After completion, you will be directed to "Inspection View" and "Policy Configuration".

![-w2021](media/15795343310324.jpg)

### Check the view

Check the view to verify the correctness of the collection.

![-w2021](media/15795345126810.jpg)

## Step 3: Policy configuration

Policy configuration steps:

*1) Basic information:
     * Policy name: It will be displayed in the alarm notification.
     * Monitoring objects: The scope of influence of the impact indicators.
*2) Monitoring items:
     *Selection of monitoring indicators
     * Monitoring statistical methods: monitoring dimensions, conditions, cycles, formula selection
     * Detection algorithm selection and configuration
     * Advanced options: convergence rules, notification templates.
*3) Notification settings:
     *Notification interval
     *Notification time period
     * Notification method: Alarm group setting
*4) Monitoring target range selection

### Basic information and monitoring items

![Fill in basic information](media/15833966792804.jpg)

> Note: The selection of monitoring objects affects the scope of indicator selection and also determines the classification of the current strategy.

### Indicator item settings

![Screenshot of indicator selection](media/15833967379533.jpg)

#### Monitoring target range selection

It is also divided into static and dynamic. It is recommended to use the dynamic method.

![-w2021](media/15795355374829.jpg)

![Screenshot of indicator item settings](media/15833967895707.jpg)

### Notification settings

![-w2021](media/15833968260066.jpg)

### Event Center

View the alarm events hit by the policy in the event center.

![-w2021](media/15795356641882.jpg)

View alarm details:

![-w2021](media/15795356836020.jpg)

## Step 4: Dashboard view configuration

Set commonly used indicator views into the dashboard.