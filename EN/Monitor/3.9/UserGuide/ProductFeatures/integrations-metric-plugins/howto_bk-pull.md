# How to directly obtain Prometheus data

The monitoring platform supports the data reporting format of Prometheus and also provides some convenient tools, but it does not mean that the monitoring platform is fully compatible because the entire architecture is different from Prometheus and the storage is also different, so Prometheus is obtained directly. The data only gets the data exposed by the Exporter.

The server has already run Prometheus' Exporter or pushgateway or the metrics interface exposed by the service. At this time, there is no need to make any changes to the original collection plug-in. You only need to follow the following steps to access the monitoring platform.

## Preliminary steps

**working principle**

![-w2021](media/16003126158054.jpg)

**Steps**

* Step one: Make BK-Pull plug-in
* Step 2: Send and collect
* Step 3: View data
* Step 4: Configure alarms

## Step one: Make BK-Pull plug-in

![-w2021](media/16003127689460.jpg)

Make a plug-in and choose the BK-Pull method

![-w2021](media/16003128089807.jpg)

debug plugin

![-w2021](media/16003128803887.jpg)

![-w2021](media/16003129004634.jpg)

## Step 2: Issue collection tasks

![-w2021](media/16003129894876.jpg)

## Step 3: View the collected data

View the data through the Inspection View of the acquisition task.


## Step 4: Configure alarms

Alarm configuration reference [Policy Configuration Function Description](../alarm-configurations/rules.md)


# How to directly obtain Prometheus data

The monitoring platform supports the data reporting format of Prometheus and also provides some convenient tools, but it does not mean that the monitoring platform is fully compatible because the entire architecture is different from Prometheus and the storage is also different, so Prometheus is obtained directly. The data only gets the data exposed by the Exporter.

The server has already run Prometheus' Exporter or pushgateway or the metrics interface exposed by the service. At this time, there is no need to make any changes to the original collection plug-in. You only need to follow the following steps to access the monitoring platform.

## Preliminary steps

**working principle**

![-w2021](media/16003126158054.jpg)

**Steps**

* Step one: Make BK-Pull plug-in
* Step 2: Send and collect
* Step 3: View data
* Step 4: Configure alarms

## Step one: Make BK-Pull plug-in

![-w2021](media/16003127689460.jpg)

Make a plug-in and choose the BK-Pull method

![-w2021](media/16003128089807.jpg)

debug plugin

![-w2021](media/16003128803887.jpg)

![-w2021](media/16003129004634.jpg)

## Step 2: Issue collection tasks

![-w2021](media/16003129894876.jpg)

## Step 3: View the collected data

View the data through the Inspection View of the acquisition task.


## Step 4: Configure alarms

Alarm configuration reference [Policy Configuration Function Description](../alarm-configurations/rules.md)