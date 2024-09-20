# Troubleshooting Guide for Frequently Asked Questions about Service Dial Testing

## 1. Failed to initialize the test node

> Possible reasons: The machine is not deployed with a dial test collector, the configuration file is incorrect, and the data link is blocked.

### Troubleshooting ideas

1. In the monitoring platform -> "Host Monitoring", check whether the basic performance data of the machine is displayed normally. If the basic performance data is not displayed, it can be determined that there is a problem with the data reporting link of the machine.

2. Log in to the machine where the collector is located and check whether the collector process is working normally.

```bash
ps aux | grep uptimecheckbeat
```

![15456208356084](../media/15456208356084.jpg)

3. If the collector process is not started, please go to the `/usr/local/gse/plugins/bin` directory to check whether the uptimecheckbeat binary file (dial test collector) exists. If it does not exist, please contact the technical staff to provide gse Version number, confirm whether this version has built-in dial test collector

4. If there is no problem in step 2 and the collector process has not started, please go to the `/usr/local/gse/plugins/etc` directory and check whether the uptimecheckbeat.conf file exists. If it does not exist, please go to the job platform to check the historical tasks of the api call, whether there is a record of execution failure, and provide a screenshot; if uptimecheckbeat.conf exists, please execute the following command to manually start the collector, and provide a screenshot of the output result.

```bash
cd /usr/local/gse/plugins/bin
./uptimecheckbeat -c ../etc/uptimecheckbeat.conf
```

5. If the collector process starts normally, but the front-end still shows that the test node is unavailable, please try to redeploy the node on the front-end, wait and observe whether there is an error message, and provide a screenshot.

6. Check whether the collector has correctly reported heartbeat information. Switch to the collector log path and find the latest log file:

```bash
cd /var/log/gse
ls -rlt uptime* | tail -n1
```

Assume that the latest log file here is `uptimecheckbeat.1`, filter whether there is a heartbeat report keyword "Publish" from it, and whether the reporting time is the latest time:

```bash
tail -n100 uptimecheckbeat.1 | grep -A10 Publish
```

Under normal circumstances, the heartbeat reporting status of the collector within the latest 1 minute can be observed:

![15456380115265](../media/15456380115265.jpg)

7. Check whether the system time of the abnormal node is synchronized

8. If the above checkpoints are normal, please package the following files and provide them:

```bash
# Configuration file
/usr/local/gse/plugins/etc/uptimecheckbeat.conf
# Log file
/var/log/gse/uptimecheckbeat.*
```

## 2. The dial-up test node is normal. After saving the dial-up test task, "No data" is displayed.

> Possible reasons: configuration file error, collector failure to load configuration, data reporting exception, etc.

### Troubleshooting ideas

1. Log in to the machine where the dial-test node is located, switch to the `/usr/local/gse/plugins/etc` path, and use the grep command to find out the dial-test task configuration. If the target address of the dial test task is "https://www.xxx.xxx.com/", the command is as follows:

```bash
cd /usr/local/gse/plugins/etc
grep -A3 https://www.xxx.xxx.com/ uptimecheckbeat.conf
```

If the dial test task is a TCP/UDP task, just replace the target address here with the dial test target IP.

Under normal circumstances, the following filtering results can be observed

![20181227221111](../media/20181227221111.png)

If there is no result output here, it can be judged that the latest task configuration has not been delivered to the dial-test node. Please try to re-save the dial-test task on the front-end page and observe again. If it still doesn't work, you can contact the technical staff for feedback.

2. If step 1 is normal, please record the task_id in the grep result in step 1 (as shown in the figure, task_id is 22). Then switch to the collector log path and find the latest log file:

```bash
cd /var/log/gse
ls -rlt uptime* | tail -n1
```

Assume that the latest log file here is `uptimecheckbeat.1`, filter whether there is data reporting with task_id 22, and whether the reporting time is the latest time:

```bash
grep -B25 '"task_id": 22' uptimecheckbeat.1
```

Under normal circumstances, you will get the result as shown in the figure:

![20181227221318](../media/20181227221318.png)

If there is no result output here, or there are error logs similar to "ERROR", "Failed", etc. in the output result, please save the screenshot and provide it to the technical support students.

## 3. When creating a new node, the specified host cannot be filtered by province or operator.

> Possible reasons: CMDB information synchronization abnormality, query abnormality, etc.

### Troubleshooting ideas

1. Check whether the node geographical location information saved in the CMDB is correct, save it in the CMDB again, and try to pull the machine list in the monitoring again after one minute.

2. Click "Monitor Platform Operation Status" at the bottom of the monitoring page to check whether there is any abnormality in the CMDB interface status.

![20181227221431](../media/20181227221431.png)

If the interface status is abnormal and displayed in red, please click the "?" after the interface name and provide the screenshot to the technical staff

![15457188640688](../media/15457188640688.jpg)

3. Monitor SaaS logs to see if there are any abnormalities such as query interface timeout. If the query interface times out, please adjust the CMDB query time limit.