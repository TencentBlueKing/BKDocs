# How to monitor via script

Scripting is a flexible and fast monitoring and collection method. Monitoring objects at different levels can be completed using scripts. Scripts are a very efficient solution when the default out-of-the-box functionality does not meet individual needs.



## Step one: Script plug-in definition

**Navigation location**: Navigation → Integration → Plug-in Production → New

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

**Navigation location**: Navigation → Integration → Data Collection → New

Collection steps:

*1) Plug-in selection and parameter filling
*2) Select target
*3) Collection and distribution
*4) Completed