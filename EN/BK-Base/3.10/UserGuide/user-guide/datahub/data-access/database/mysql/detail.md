# Access details

The access details page displays the access status and provides stop and start operations for source data access.

## Access status

Access status includes statistical overview and access status of each access object.

The statistical overview includes normal, abnormal, running and stopped status. The number is 1. Click the refresh button to query the latest status

![](media/deploy_status_summary.png)

## Start and stop tasks

Here you can stop/start the collection task. After stopping the task, data will no longer be collected.

![](media/control_btn.png)

## Access object

The access object displays the configured collection db domain name, database name and table name

![](media/access_object_db.png)



## Access method

Here is the configured access method![](media/access_param_db.png)



## Run log

The operation log displays the operator and operation log of each deployment

![](media/access_log_db.png)



## Operation history

Operation history displays the operation logs of source data. It includes source data access, stop, start, and start and stop operations of source data-related tasks.

![](media/access_history_db.png)

## db access example

Q: Assuming that the db data source is configured at 2020-03-24 14:55 (frequency 5min, data delay 1min), from which time is it judged to be incremental data?

2020-03-24 15:01 Start pulling data from 2020-03-24 14:55~2020-03-24 15:00
2020-03-24 15:06 Start pulling data from 2020-03-24 15:00~2020-03-24 15:05